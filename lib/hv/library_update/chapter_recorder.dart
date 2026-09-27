import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/library_update/core/chapter_diff.dart';
import 'package:anymex/hv/library_update/models/hv_chapter_update.dart';
import 'package:anymex/hv/library_update/update_repository.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';

/// Compares a freshly fetched chapter list with what a link has seen before,
/// records the new chapters as updates, and advances the link's known list.
///
/// The link is updated in memory only; the caller saves it.
class ChapterRecorder {
  ChapterRecorder._();

  static Future<ChapterDiff> record({
    required HvSourceLink link,
    required List<Chapter> chapters,
    required bool reportNew,
    String? mediaTitle,
    String? poster,
  }) async {
    final keys = [
      for (final c in chapters)
        chapterKey(link: c.link, number: c.number, title: c.title),
    ];
    final diff = diffChapters(link.knownChapterKeys, keys);
    final now = DateTime.now().millisecondsSinceEpoch;

    if (diff.kind != ChapterDiffKind.empty) {
      link.knownChapterKeys = diff.knownAfter;
      link.lastCheckedAt = now;
    }

    if (reportNew &&
        diff.kind == ChapterDiffKind.changes &&
        diff.newIndexes.isNotEmpty) {
      final mediaKey = hvMediaKey(link.mediaTypeIndex, link.mediaId);
      final updates = <HvChapterUpdate>[];
      for (final i in diff.newIndexes) {
        final chapter = chapters[i];
        updates.add(HvChapterUpdate()
          ..updateKey = '$mediaKey|${keys[i]}'
          ..mediaKey = mediaKey
          ..mediaId = link.mediaId
          ..mediaTypeIndex = link.mediaTypeIndex
          ..mediaTitle = mediaTitle
          ..poster = poster
          ..sourceId = link.sourceId
          ..sourceName = link.sourceName
          ..chapterTitle = chapter.title
          ..chapterNumber = chapter.number
          ..chapterLink = chapter.link
          ..scanlator = chapter.scanlator
          ..releaseDate = chapter.releaseDate
          ..foundAt = now);
      }
      await UpdateRepository.addUpdates(updates);
      link.lastNewChapterAt = now;
    }
    return diff;
  }
}
