import 'package:anymex/hv/library/core/library_filter.dart';
import 'package:anymex/hv/library/core/library_search.dart';
import 'package:flutter_test/flutter_test.dart';

const berserk = LibrarySearchFields(
  titles: ['Berserk', 'ベルセルク'],
  source: 'Weeb Central',
  status: 'RELEASING',
  genres: ['Action', 'Dark Fantasy'],
);
const vagabond = LibrarySearchFields(
  titles: ['Vagabond'],
  source: 'MangaDex',
  status: 'HIATUS',
  genres: ['Action', 'Historical'],
);

bool q(String query, LibrarySearchFields f) =>
    LibrarySearchQuery.parse(query).matches(f);

void main() {
  group('LibrarySearchQuery', () {
    test('plain words match titles, case-insensitively', () {
      expect(q('bers', berserk), isTrue);
      expect(q('BERS', vagabond), isFalse);
      expect(LibrarySearchQuery.parse('   ').isEmpty, isTrue);
    });
    test('all words must match', () {
      expect(q('ber serk', berserk), isTrue);
      expect(q('ber vag', berserk), isFalse);
    });
    test('exclusion and exact phrases', () {
      expect(q('-vagabond', berserk), isTrue);
      expect(q('-vagabond', vagabond), isFalse);
      expect(q('"erse"', berserk), isTrue);
    });
    test('field filters', () {
      expect(q('src:weeb', berserk), isTrue);
      expect(q('source:"weeb central"', berserk), isTrue);
      expect(q('src:dex', berserk), isFalse);
      expect(q('status:hiatus', vagabond), isTrue);
      expect(q('genre:historical', vagabond), isTrue);
      expect(q('-tag:historical action', berserk), isTrue);
      expect(q('-tag:historical', vagabond), isFalse);
    });
    test('a whole-word genre matches as plain text too', () {
      expect(q('historical', vagabond), isTrue);
      expect(q('histor', vagabond), isFalse);
    });
    test('unknown field prefixes are plain text', () {
      const re = LibrarySearchFields(titles: ['Re:Zero']);
      expect(q('re:zero', re), isTrue);
    });
  });

  group('library filters', () {
    const behind = HvLibraryFacts(unreadCount: 2, started: true);
    const fresh = HvLibraryFacts();
    test('tri-state include/exclude', () {
      const onlyUnread = HvLibraryPrefs(unread: HvTriState.include);
      const noUnread = HvLibraryPrefs(unread: HvTriState.exclude);
      expect(passesLibraryFilters(behind, onlyUnread), isTrue);
      expect(passesLibraryFilters(fresh, onlyUnread), isFalse);
      expect(passesLibraryFilters(fresh, noUnread), isTrue);
      expect(passesLibraryFilters(fresh, const HvLibraryPrefs()), isTrue);
    });
    test('tri-state cycles', () {
      expect(HvTriState.off.next, HvTriState.include);
      expect(HvTriState.exclude.next, HvTriState.off);
    });
    test('prefs json round trip tolerates junk', () {
      const p = HvLibraryPrefs(
          started: HvTriState.exclude, groupBy: HvLibraryGroupBy.source);
      final back = HvLibraryPrefs.fromJson(p.toJson());
      expect(back.started, HvTriState.exclude);
      expect(back.groupBy, HvLibraryGroupBy.source);
      expect(HvLibraryPrefs.fromJson({'groupBy': 42}).groupBy,
          HvLibraryGroupBy.none);
    });
  });

  group('groupLibrary', () {
    test('alphabetical with unknown last, item order kept', () {
      final groups = groupLibrary(['b1', 'a1', 'x', 'b2'],
          keyOf: (s) => s == 'x' ? null : s.substring(0, 1).toUpperCase());
      expect(groups.map((g) => g.label).toList(), ['A', 'B', 'Unknown']);
      expect(groups[1].items, ['b1', 'b2']);
    });
    test('explicit order first, then others alphabetically', () {
      final groups = groupLibrary(['DROPPED', 'CURRENT', 'ZZZ', 'PLANNING'],
          keyOf: (s) => s, order: kTrackerStatusOrder);
      expect(groups.map((g) => g.label).toList(),
          ['CURRENT', 'PLANNING', 'DROPPED', 'ZZZ']);
    });
    test('tracker statuses are normalized', () {
      expect(normalizeTrackerStatus('reading'), 'CURRENT');
      expect(normalizeTrackerStatus('Plan to Read'), 'PLANNING');
      expect(normalizeTrackerStatus('on_hold'), 'PAUSED');
      expect(normalizeTrackerStatus(''), isNull);
    });
  });
}
