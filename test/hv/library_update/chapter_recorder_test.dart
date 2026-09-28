import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/library_update/chapter_recorder.dart';
import 'package:anymex/hv/library_update/core/chapter_diff.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a check with no new chapters still records the latest number',
      () async {
    final chapters = [
      Chapter(link: '/c1', number: 1),
      Chapter(link: '/c2', number: 2),
    ];
    // A link saved before latestChapterNumber existed: it already knows
    // these chapters, so nothing is new.
    final link = HvSourceLink()
      ..mediaId = 'm'
      ..mediaTypeIndex = 0
      ..knownChapterKeys = [
        for (final c in chapters)
          chapterKey(link: c.link, number: c.number, title: c.title),
      ];

    final record = await ChapterRecorder.record(
        link: link, chapters: chapters, reportNew: false);

    expect(record.diff.kind, ChapterDiffKind.changes);
    expect(record.diff.newIndexes, isEmpty);
    expect(link.latestChapterNumber, 2);
    expect(link.lastCheckedAt, isNotNull);
  });

  test('an empty chapter list keeps what the link knew', () async {
    final link = HvSourceLink()
      ..mediaId = 'm'
      ..mediaTypeIndex = 0
      ..knownChapterKeys = ['a']
      ..latestChapterNumber = 5;

    final record =
        await ChapterRecorder.record(link: link, chapters: [], reportNew: false);

    expect(record.diff.kind, ChapterDiffKind.empty);
    expect(link.knownChapterKeys, ['a']);
    expect(link.latestChapterNumber, 5);
    expect(link.lastCheckedAt, isNull);
  });
}
