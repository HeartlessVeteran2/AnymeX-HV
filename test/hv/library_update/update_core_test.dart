import 'package:anymex/hv/library_update/core/chapter_diff.dart';
import 'package:anymex/hv/library_update/core/source_health.dart';
import 'package:anymex/hv/library_update/core/update_grouping.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chapterKey', () {
    test('uses the link when present', () {
      expect(chapterKey(link: ' /c/12 ', number: 12), '/c/12');
    });
    test('falls back to number and title', () {
      expect(chapterKey(link: '', number: 12, title: 'Ch 12'), 'n:12.0|Ch 12');
      expect(chapterKey(), 'n:|');
    });
  });

  group('diffChapters', () {
    test('first check records a baseline and reports nothing', () {
      final d = diffChapters(const [], const ['a', 'b']);
      expect(d.kind, ChapterDiffKind.baseline);
      expect(d.newIndexes, isEmpty);
      expect(d.knownAfter, ['a', 'b']);
    });

    test('reports only chapters not seen before', () {
      final d = diffChapters(const ['a', 'b'], const ['a', 'b', 'c', 'd']);
      expect(d.kind, ChapterDiffKind.changes);
      expect(d.newIndexes, [2, 3]);
      expect(d.knownAfter.toSet(), {'a', 'b', 'c', 'd'});
    });

    test('a chapter that disappears stays known and is not new again', () {
      final first = diffChapters(const ['a', 'b', 'c'], const ['a', 'b']);
      expect(first.newIndexes, isEmpty);
      expect(first.knownAfter.toSet(), {'a', 'b', 'c'});
      final second = diffChapters(first.knownAfter, const ['a', 'b', 'c']);
      expect(second.newIndexes, isEmpty);
    });

    test('duplicate new keys are reported once', () {
      final d = diffChapters(const ['a'], const ['a', 'b', 'b']);
      expect(d.newIndexes, [1]);
    });

    test('an empty list is a failed check and keeps what was known', () {
      final d = diffChapters(const ['a'], const []);
      expect(d.kind, ChapterDiffKind.empty);
      expect(d.knownAfter, ['a']);
    });

    test('a mass change rebaselines instead of flooding', () {
      final current = List.generate(40, (i) => 'new-$i');
      final d = diffChapters(const ['old-1', 'old-2'], current);
      expect(d.kind, ChapterDiffKind.rebaseline);
      expect(d.newIndexes, isEmpty);
      expect(d.knownAfter, containsAll(current));
    });

    test('a big batch on a long series is still reported', () {
      final known = List.generate(100, (i) => 'c$i');
      final current = [...known, ...List.generate(15, (i) => 'x$i')];
      final d = diffChapters(known, current);
      expect(d.kind, ChapterDiffKind.changes);
      expect(d.newIndexes.length, 15);
    });
  });

  group('SourceHealth', () {
    test('pauses a source after consecutive failures, resets on success', () {
      final h = SourceHealth(pauseAfter: 3);
      h.recordFailure('s');
      h.recordFailure('s');
      expect(h.isPaused('s'), isFalse);
      h.recordSuccess('s');
      h.recordFailure('s');
      h.recordFailure('s');
      expect(h.isPaused('s'), isFalse);
      h.recordFailure('s');
      expect(h.isPaused('s'), isTrue);
      expect(h.isPaused('other'), isFalse);
    });
  });

  group('groupUpdates', () {
    int at(int day, int hour) => DateTime(2026, 9, day, hour).millisecondsSinceEpoch;

    test('groups by day then title, newest first', () {
      final items = [
        (key: 'm1', at: at(25, 10), n: 1.0),
        (key: 'm2', at: at(26, 9), n: 5.0),
        (key: 'm1', at: at(26, 8), n: 2.0),
        (key: 'm1', at: at(26, 11), n: 3.0),
      ];
      final days = groupUpdates(items,
          foundAt: (e) => e.at, mediaKey: (e) => e.key, chapterNumber: (e) => e.n);
      expect(days.length, 2);
      expect(days.first.day, DateTime(2026, 9, 26));
      expect(days.first.titles.map((t) => t.mediaKey).toList(), ['m1', 'm2']);
      expect(days.first.titles.first.items.map((e) => e.n).toList(), [3.0, 2.0]);
      expect(days.last.titles.single.items.single.n, 1.0);
    });
  });
}
