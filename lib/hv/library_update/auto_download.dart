import 'package:anymex/controllers/source/source_controller.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/library_update/core/update_filter.dart';
import 'package:anymex/hv/library_update/models/hv_chapter_update.dart';
import 'package:anymex/hv/library_update/update_settings.dart';
import 'package:anymex/main.dart' show isar;
import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/screens/downloads/controller/download_controller.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

/// Queues new manga chapters found by an update run for download.
class HvAutoDownload {
  HvAutoDownload._();

  /// Caps so one run can't flood the download queue (the manga queue starts
  /// every queued chapter at once).
  static const int maxPerTitle = 5;
  static const int maxPerRun = 30;

  /// Returns how many chapters were queued.
  static Future<int> queueNewChapters(List<HvChapterUpdate> updates) async {
    if (!LibraryUpdateSettings.autoDownload || updates.isEmpty) return 0;
    if (!Get.isRegistered<DownloadController>()) return 0;

    final allowedLists = LibraryUpdateSettings.autoDownloadLists;
    final byTitle = <String, List<HvChapterUpdate>>{};
    for (final u in updates) {
      if (u.mediaTypeIndex != ItemType.manga.index) continue;
      byTitle.putIfAbsent(u.mediaKey, () => []).add(u);
    }

    final sources = Get.find<SourceController>();
    final downloads = Get.find<DownloadController>();
    var queued = 0;
    for (final titleUpdates in byTitle.values) {
      if (queued >= maxPerRun) break;
      final first = titleUpdates.first;
      if (allowedLists.isNotEmpty &&
          !_listsOf(first.mediaTypeIndex, first.mediaId)
              .any(allowedLists.contains)) {
        continue;
      }
      final media = LibraryMembership.media(first.mediaTypeIndex, first.mediaId);
      final source = sources.findSourceById(first.sourceId, ItemType.manga);
      if (media == null || source == null) continue;

      titleUpdates.sort(
          (a, b) => (a.chapterNumber ?? 0).compareTo(b.chapterNumber ?? 0));
      final chapters = [
        for (final u in titleUpdates.take(maxPerTitle))
          if ((u.chapterLink ?? '').isNotEmpty)
            Chapter(
              link: u.chapterLink,
              title: u.chapterTitle,
              number: u.chapterNumber,
              scanlator: u.scanlator,
              releaseDate: u.releaseDate,
              sourceName: source.name,
            ),
      ].take(maxPerRun - queued).toList();
      if (chapters.isEmpty) continue;
      try {
        await downloads.enqueueMangaDownloadBatch(
            chapters: chapters, source: source, media: media);
        queued += chapters.length;
      } catch (e) {
        Logger.e('HV: auto-download failed for ${media.name}: $e');
      }
    }
    return queued;
  }

  static Set<String> _listsOf(int typeIndex, String mediaId) {
    final lists =
        isar.customLists.filter().mediaTypeIndexEqualTo(typeIndex).findAllSync();
    return {
      for (final list in lists)
        if ((list.mediaIds ?? const []).contains(mediaId))
          listKey(typeIndex, list.listName ?? ''),
    };
  }
}
