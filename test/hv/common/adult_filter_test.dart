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
      expect(q, contains('{ id isAdult }'));
    });

    test('showing drops every fixed filter', () {
      final q = hvAdultMediaQuery(_home, hideAdult: false);
      expect(q, isNot(contains('isAdult:')));
      expect(q, contains('{ id isAdult }'));
      expect(q, contains('countryOfOrigin: "JP"'));
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
}
