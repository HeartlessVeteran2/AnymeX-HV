import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/chapters/core/chapter_filters.dart';
import 'package:anymex/hv/chapters/core/mark_read_planner.dart';
import 'package:flutter_test/flutter_test.dart';

Chapter ch(double n, {int? page, int? total, String? link}) => Chapter(
    number: n, link: link ?? '/c/$n', pageNumber: page, totalPages: total);

void main() {
  group('applyChapterPrefs', () {
    final chapters = [1, 2, 3, 4];
    bool isRead(int c) => c <= 2;
    bool isDownloaded(int c) => c.isOdd;

    List<int> run(HvChapterListPrefs p) => applyChapterPrefs(chapters, p,
        isRead: isRead, isDownloaded: isDownloaded);

    test('default keeps the list as is', () {
      expect(run(const HvChapterListPrefs()), same(chapters));
    });
    test('read filters', () {
      expect(run(const HvChapterListPrefs(readFilter: HvReadFilter.unread)),
          [3, 4]);
      expect(run(const HvChapterListPrefs(readFilter: HvReadFilter.read)),
          [1, 2]);
    });
    test('downloaded only and newest first combine', () {
      expect(
          run(const HvChapterListPrefs(
              downloadedOnly: true, newestFirst: true)),
          [3, 1]);
    });
    test('json round trip', () {
      const p = HvChapterListPrefs(
          readFilter: HvReadFilter.unread, downloadedOnly: true);
      final back = HvChapterListPrefs.fromJson(p.toJson());
      expect(back.readFilter, HvReadFilter.unread);
      expect(back.downloadedOnly, isTrue);
      expect(back.newestFirst, isFalse);
      expect(HvChapterListPrefs.fromJson({'read': 99}).readFilter,
          HvReadFilter.all);
    });
  });

  group('planReadChapters', () {
    test('marking read completes an existing entry and adds missing ones', () {
      final existing = [ch(1, page: 3, total: 20)];
      final result =
          planReadChapters(existing, [ch(1), ch(2)], read: true);
      expect(result.length, 2);
      expect(result[0].pageNumber, 20);
      expect(result[0].totalPages, 20);
      expect(result[1].number, 2);
      expect(result[1].pageNumber, 1);
      expect(result[1].totalPages, 1);
    });

    test('an entry without a page count becomes 1/1', () {
      final result = planReadChapters([ch(5)], [ch(5)], read: true);
      expect(result.single.pageNumber, 1);
      expect(result.single.totalPages, 1);
    });

    test('marking unread removes entries and leaves others', () {
      final existing = [ch(1, page: 20, total: 20), ch(2, page: 5, total: 20)];
      final result = planReadChapters(existing, [ch(1)], read: false);
      expect(result.map((c) => c.number), [2]);
      expect(existing.length, 2, reason: 'input list is not modified');
    });

    test('chaptersUpTo takes everything numbered at or below', () {
      final all = [ch(1), ch(2), ch(2.5), ch(3)];
      expect(chaptersUpTo(all, ch(2.5)).map((c) => c.number), [1, 2, 2.5]);
    });
  });
}
