import 'dart:io';

import 'package:anymex/hv/common/core/adult_filter.dart';
import 'package:flutter_test/flutter_test.dart';

// Shaped like the home page query: some lists have no filter, one always
// left adult titles out.
const _home = '''
query {
  popularAnimes: Page(page: 1, perPage: 15) {
    media(type: ANIME, sort: POPULARITY_DESC) { id isAdult }
  }
  recentlyUpdatedAnimes: Page(page: 1, perPage: 15) {
    media(
      type: ANIME,
      status: RELEASING,
      isAdult: false,
      countryOfOrigin: "JP"
    ) { id }
  }
}
''';

void main() {
  group('hvAdultMediaQuery', () {
    test('hiding puts isAdult: false on every list, once', () {
      final q = hvAdultMediaQuery(_home, hideAdult: true);
      expect(RegExp(r'isAdult: false').allMatches(q), hasLength(2));
      expect(q, contains('media(isAdult: false, type: ANIME, sort'));
      // The `isAdult` field that is read back is left alone.
      expect(q, contains('id isAdult }'));
    });

    test('showing drops every fixed filter', () {
      final q = hvAdultMediaQuery(_home, hideAdult: false);
      expect(q, isNot(contains('isAdult:')));
      expect(q, contains('id isAdult }'));
      expect(q, contains('countryOfOrigin: "JP"'));
    });

    test('every list reads back isAdult, either way', () {
      for (final hide in [true, false]) {
        final q = hvAdultMediaQuery(_home, hideAdult: hide);
        expect(RegExp(r'\) \{ isAdult').allMatches(q), hasLength(2),
            reason: 'hideAdult: $hide');
      }
    });

    test('a field whose name only contains "media" is not touched', () {
      const q = 'query { Page { mediaTrends(mediaId: 1) { date } } }';
      expect(hvAdultMediaQuery(q, hideAdult: true), q);
    });
  });

  group('hvAdultMalUrl', () {
    const url =
        'https://api.myanimelist.net/v2/anime/ranking?ranking_type=airing&limit=15';

    test('asks for 18+ entries when they are not hidden', () {
      expect(hvAdultMalUrl(url, hideAdult: false), '$url&nsfw=true');
    });

    test('leaves the URL alone when they are hidden', () {
      expect(hvAdultMalUrl(url, hideAdult: true), url);
    });

    test("doesn't add a second nsfw parameter", () {
      expect(hvAdultMalUrl('$url&nsfw=true', hideAdult: false),
          '$url&nsfw=true');
    });
  });

  group('hvSearchTags', () {
    test('adult tags only when adult search is on, sorted in', () {
      expect(hvSearchTags(['Action', 'Magic'], ['Ahegao'], showAdult: false),
          ['Action', 'Magic']);
      expect(hvSearchTags(['Action', 'Magic'], ['Ahegao'], showAdult: true),
          ['Action', 'Ahegao', 'Magic']);
    });
  });

  group('hvWithoutAdultTags', () {
    test('drops adult tags and keeps the rest', () {
      expect(
          hvWithoutAdultTags({
            'tags': ['Magic', 'Ahegao'],
            'sort': ['POPULARITY_DESC'],
          }, ['Ahegao']),
          {
            'tags': ['Magic'],
            'sort': ['POPULARITY_DESC'],
          });
    });

    test('no tags left becomes no tag filter', () {
      expect(hvWithoutAdultTags({'tags': ['Ahegao']}, ['Ahegao']),
          {'tags': null});
    });

    test('filters without tags are returned as they were', () {
      final filters = {'genres': ['Action']};
      expect(hvWithoutAdultTags(filters, ['Ahegao']), same(filters));
    });
  });

  group('adult titles in the bundled fallback lists', () {
    test('are recognised by id', () {
      expect(hvIsAdultFallback('98543'), isTrue);
      expect(hvIsAdultFallback('21'), isFalse);
      expect(hvIsAdultFallback('not a number'), isFalse);
    });

    test('count as adult home titles, as do titles AniList flags', () {
      expect(hvIsAdultTitle('98543'), isTrue);
      expect(hvIsAdultTitle('21', isAdult: true), isTrue);
      expect(hvIsAdultTitle('21', isAdult: false), isFalse);
      expect(hvIsAdultTitle('21'), isFalse);
    });

    test('are all still in the fallback data', () {
      // Tests run from the project root. If upstream replaces the fallback
      // lists, this list needs checking against AniList again.
      final data = [
        'lib/utils/fallback/fallback_anime.dart',
        'lib/utils/fallback/fallback_manga.dart',
      ].map((f) => File(f).readAsStringSync()).join();
      final ids = RegExp(r'"id":\s*(\d+)')
          .allMatches(data)
          .map((m) => int.parse(m.group(1)!))
          .toSet();
      expect(ids.containsAll(hvAdultFallbackIds), isTrue,
          reason: 'missing: ${hvAdultFallbackIds.difference(ids)}');
    });
  });
}
