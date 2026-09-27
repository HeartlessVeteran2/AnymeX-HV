import 'package:anymex/hv/reader/core/reader_downloads.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('title choice wins over the global switch', () {
    expect(shouldDeleteAfterRead(HvDeleteAfterReadMode.inherit, true), isTrue);
    expect(shouldDeleteAfterRead(HvDeleteAfterReadMode.inherit, false), isFalse);
    expect(shouldDeleteAfterRead(HvDeleteAfterReadMode.enabled, false), isTrue);
    expect(shouldDeleteAfterRead(HvDeleteAfterReadMode.disabled, true), isFalse);
  });

  group('chapterToDeleteAfterRead', () {
    final chapters = [3.0, 1.0, 2.0, 4.0, 5.0];
    test('keep 0 deletes the chapter just read', () {
      expect(chapterToDeleteAfterRead(chapters, 3, 0), 3);
    });
    test('keep N deletes the chapter N before it', () {
      expect(chapterToDeleteAfterRead(chapters, 5, 2), 3);
      expect(chapterToDeleteAfterRead(chapters, 2, 1), 1);
    });
    test('nothing to delete near the start or for unknown chapters', () {
      expect(chapterToDeleteAfterRead(chapters, 2, 3), isNull);
      expect(chapterToDeleteAfterRead(chapters, 9, 0), isNull);
    });
  });

  group('chaptersToDownloadAhead', () {
    final chapters = [1.0, 2.0, 3.0, 4.0, 5.0];
    test('waits until 80% of the chapter', () {
      expect(
          chaptersToDownloadAhead(
              chapterNumbers: chapters,
              current: 2,
              progress: 0.5,
              count: 2,
              isDownloaded: (_) => false),
          isEmpty);
    });
    test('queues the next N that are not downloaded', () {
      expect(
          chaptersToDownloadAhead(
              chapterNumbers: chapters,
              current: 2,
              progress: 0.85,
              count: 2,
              isDownloaded: (n) => n == 3),
          [4.0]);
      expect(
          chaptersToDownloadAhead(
              chapterNumbers: chapters,
              current: 4,
              progress: 1,
              count: 3,
              isDownloaded: (_) => false),
          [5.0]);
    });
    test('off when count is 0', () {
      expect(
          chaptersToDownloadAhead(
              chapterNumbers: chapters,
              current: 1,
              progress: 1,
              count: 0,
              isDownloaded: (_) => false),
          isEmpty);
    });
  });
}
