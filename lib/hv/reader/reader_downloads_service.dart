import 'package:anymex/controllers/source/source_controller.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/common/network_conditions.dart';
import 'package:anymex/hv/common/read_state.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/reader/core/reader_downloads.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/screens/downloads/controller/download_controller.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex/utils/media_downloader.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    show ItemType;
import 'package:get/get.dart';

/// Download-ahead and delete-after-read for the manga reader (from Otaku
/// Reader). Downloads are addressed the way the chapter list does it: by
/// the active source's name and the title.
class HvReaderDownloads {
  HvReaderDownloads._();

  static final Expando<Set<String>> _aheadDone = Expando('hvDownloadAhead');

  /// Finished chapters left during this reading session; their downloads
  /// are deleted when the reader closes (like Mihon), not while their pages
  /// may still be on screen in continuous mode.
  static final Expando<List<Chapter>> _finished = Expando('hvFinished');

  static String _modeKey(Media m) =>
      'hvDeleteAfterRead_${hvMediaKey(m.mediaType.index, m.id)}';

  static HvDeleteAfterReadMode modeFor(Media m) {
    final i = KvHelper.get<int>(_modeKey(m), defaultVal: 0);
    return HvDeleteAfterReadMode
        .values[i.clamp(0, HvDeleteAfterReadMode.values.length - 1)];
  }

  static void setMode(Media m, HvDeleteAfterReadMode mode) =>
      mode == HvDeleteAfterReadMode.inherit
          ? KvHelper.remove(_modeKey(m))
          : KvHelper.set(_modeKey(m), mode.index);

  static String _chapterKey(Chapter? c) => (c?.link ?? '').isNotEmpty
      ? c!.link!
      : (c?.localPath ?? 'n:${c?.number}');

  /// Called on every page change.
  static Future<void> onPageChanged(ReaderController c, int page) async {
    try {
      final count = HvKeys.hvDownloadAhead.get<int>(0);
      final chapter = c.currentChapter.value;
      if (count <= 0 || chapter?.number == null) return;
      final key = _chapterKey(chapter);
      final pages = c.loadedChapterPages[key]?.length ?? c.pageList.length;
      // page > pages is the reader's "open at the bottom" placeholder.
      if (pages <= 0 || page > pages || page / pages < kDownloadAheadAt) {
        return;
      }
      final done = _aheadDone[c] ??= <String>{};
      if (!done.add(key)) return;

      if (HvKeys.hvDownloadAheadWifiOnly.get<bool>(true) &&
          !await HvNetworkConditions.isUnmetered()) {
        return;
      }
      final source = Get.find<SourceController>().activeMangaSource.value;
      if (source == null || !Get.isRegistered<DownloadController>()) return;
      final downloads = Get.find<DownloadController>();
      final ext = source.name ?? '';
      final title = c.media.title;
      await downloads.ensureMangaMetaLoaded(ext, title);
      final queuedTitle = MediaDownloader.sanitizePathSegment(
          c.media.toOfflineMedia().name ?? title);
      bool queued(double n) => downloads.activeMangaTasks.any((t) =>
          t.chapter.number == n &&
          t.mediaTitle.toLowerCase() == queuedTitle.toLowerCase());

      final numbers = chaptersToDownloadAhead(
        chapterNumbers: [
          for (final ch in c.chapterList)
            if (ch.number != null) ch.number!,
        ],
        current: chapter!.number!,
        progress: page / pages,
        count: count,
        isDownloaded: (n) =>
            downloads.isChapterDownloaded(ext, title, n) || queued(n),
      );
      if (numbers.isEmpty) return;
      final chapters = [
        for (final n in numbers)
          if (c.chapterList.firstWhereOrNull((ch) => ch.number == n)
              case final Chapter ch
              when (ch.link ?? '').isNotEmpty)
            ch,
      ];
      if (chapters.isEmpty) return;
      await downloads.enqueueMangaDownloadBatch(
          chapters: chapters, source: source, media: c.media.toOfflineMedia());
      Logger.i('HV: downloading ${chapters.length} chapter(s) ahead');
    } catch (e) {
      Logger.e('HV: download ahead failed: $e');
    }
  }

  /// Called when the reader moves off [chapter]: remembers it if finished.
  static void onChapterLeft(ReaderController c, Chapter? chapter) {
    if (chapter?.number == null) return;
    if (!hvIsPageComplete(chapter!.pageNumber, chapter.totalPages)) return;
    (_finished[c] ??= []).add(chapter);
  }

  /// Called when the reader closes: deletes downloads of the chapters
  /// finished in this session (and the one it closes on).
  static Future<void> onReaderClosed(ReaderController c) async {
    final current = c.currentChapter.value;
    final chapters = [...?_finished[c], if (current != null) current];
    _finished[c] = null;
    for (final chapter in chapters) {
      await _deleteAfterRead(c, chapter);
    }
  }

  /// Whether chapter [number] of the open title is read: finished in its
  /// saved progress or in the reader's chapter list (this session's).
  static bool _isRead(ReaderController c, double number) {
    final saved = LibraryMembership.media(ItemType.manga.index, c.media.id)
            ?.readChapters ??
        const <Chapter>[];
    return hvIsNumberRead([
      for (final ch in [...saved, ...c.chapterList])
        (
          link: ch.link,
          number: ch.number,
          page: ch.pageNumber,
          total: ch.totalPages,
        ),
    ], number);
  }

  static Future<void> _deleteAfterRead(
      ReaderController c, Chapter? chapter) async {
    try {
      if (chapter?.number == null) return;
      final global = HvKeys.hvDeleteAfterRead.get<bool>(false);
      if (!shouldDeleteAfterRead(modeFor(c.media), global)) return;
      if (!hvIsPageComplete(chapter!.pageNumber, chapter.totalPages)) return;

      final target = chapterToDeleteAfterRead(
        [
          for (final ch in c.chapterList)
            if (ch.number != null) ch.number!,
        ],
        chapter.number!,
        HvKeys.hvDeleteAfterReadKeep.get<int>(0),
      );
      // Keeping the last N counts back from the chapter just finished; the
      // chapter N back may never have been read (the user skipped ahead).
      // The chapter just finished (keep 0) was checked above: its saved
      // progress can still be an older visit's.
      if (target == null || (target != chapter.number && !_isRead(c, target))) {
        return;
      }
      final source = Get.find<SourceController>().activeMangaSource.value;
      if (source == null || !Get.isRegistered<DownloadController>()) return;
      final downloads = Get.find<DownloadController>();
      final ext = source.name ?? '';
      final title = c.media.title;
      await downloads.ensureMangaMetaLoaded(ext, title);
      if (!downloads.isChapterDownloaded(ext, title, target)) return;
      await downloads.deleteChapter(ext, title, target);
      Logger.i('HV: deleted downloaded chapter $target after reading');
    } catch (e) {
      Logger.e('HV: delete after read failed: $e');
    }
  }
}
