import 'package:anymex/hv/matching/string_similarity.dart';
import 'package:anymex/hv/matching/title_matcher.dart';
import 'package:anymex/hv/matching/title_normalizer.dart';
import 'package:flutter_test/flutter_test.dart';

class _C {
  final int id;
  final List<String?> titles;
  const _C(this.id, this.titles);
}

TitleMatch<_C>? _match(String source, List<_C> candidates,
        {List<String> alternatives = const []}) =>
    TitleMatcher.bestMatch<_C>(
        [source, ...alternatives], candidates, (c) => c.titles);

void main() {
  group('StringSimilarity', () {
    test('ratio', () {
      expect(StringSimilarity.ratio('berserk', 'berserk'), 1);
      expect(StringSimilarity.ratio('', ''), 1);
      expect(StringSimilarity.ratio('', 'berserk'), 0);
      expect(StringSimilarity.ratio('bersek', 'berserk'),
          closeTo(1 - 1 / 7, 0.0001));
      expect(StringSimilarity.ratio('love is war', 'war is love'),
          lessThan(0.6));
    });

    test('partialRatio finds a title inside a longer one', () {
      expect(
          StringSimilarity.partialRatio('berserk', 'berserk deluxe edition'), 1);
      expect(
          StringSimilarity.partialRatio(
              'berserk', 'the complete berserk archive'),
          1);
    });

    test('tokenSetRatio ignores order and extra words', () {
      expect(StringSimilarity.tokenSetRatio('love is war', 'war is love'), 1);
      expect(StringSimilarity.tokenSetRatio('hero academia',
          'boku no hero academia'), 1);
      expect(StringSimilarity.tokenSetRatio('berserk', 'vagabond'),
          lessThan(0.5));
    });

    test('levenshtein', () {
      expect(StringSimilarity.levenshtein('kitten', 'kitten'), 0);
      expect(StringSimilarity.levenshtein('kitten', 'sitten'), 1);
      expect(StringSimilarity.levenshtein('kitten', 'kitteng'), 1);
      expect(StringSimilarity.levenshtein('kitten', 'kiten'), 1);
      expect(StringSimilarity.levenshtein('kitten', 'sitting'), 3);
      expect(StringSimilarity.levenshtein('', 'berserk'), 7);
    });
  });

  group('TitleNormalizer', () {
    test('normalize strips years, articles, punctuation, trailing units', () {
      expect(TitleNormalizer.normalize('The Promised Neverland (2016)'),
          'promised neverland');
      expect(TitleNormalizer.normalize('Spy×Family'), 'spy x family');
      expect(TitleNormalizer.normalize('Re:Zero - Starting Life'),
          're zero starting life');
      expect(TitleNormalizer.normalize('Kaguya-sama: Love is War Season 2'),
          'kaguya sama love is war');
    });

    test('keeps non-latin letters', () {
      expect(TitleNormalizer.normalize('僕のヒーローアカデミア'), '僕のヒーローアカデミア');
    });

    test('placeholders are not meaningful, case-insensitively', () {
      expect(TitleNormalizer.isMeaningful('?'), isFalse);
      expect(TitleNormalizer.isMeaningful('n/a'), isFalse);
      expect(TitleNormalizer.isMeaningful('Unknown Title'), isFalse);
      expect(TitleNormalizer.isMeaningful('   '), isFalse);
      expect(TitleNormalizer.isMeaningful('Berserk'), isTrue);
    });
  });

  group('TitleMatcher', () {
    test('an exact title wins', () {
      final r = _match('Berserk', const [
        _C(1, ['Berserk']),
        _C(2, ['Bastard']),
      ]);
      expect(r!.candidate.id, 1);
      expect(r.confident, isTrue);
    });

    test('the english title matches when the source uses romaji', () {
      final r = _match('Boku no Hero Academia', const [
        _C(1, ['Kimetsu no Yaiba', 'Demon Slayer']),
        _C(2, ['Boku no Hero Academia', 'My Hero Academia']),
      ]);
      expect(r!.candidate.id, 2);
      expect(r.confident, isTrue);
    });

    test('a synonym matches when neither main title does', () {
      final r = _match('OPM', const [
        _C(1, ['One Punch-Man', 'One-Punch Man', 'OPM']),
        _C(2, ['Onepunch-Man Gaiden']),
      ]);
      expect(r!.candidate.id, 1);
    });

    test('a season 2 title does not match the season 1 entry', () {
      final r = _match('Kaguya-sama: Love is War Season 2', const [
        _C(1, ['Kaguya-sama wa Kokurasetai', 'Kaguya-sama: Love is War']),
        _C(2, ['Kaguya-sama: Love is War Season 2']),
      ]);
      expect(r!.candidate.id, 2);
    });

    test('the season 1 entry wins when it is listed second too', () {
      final r = _match('Kaguya-sama: Love is War Season 2', const [
        _C(2, ['Kaguya-sama: Love is War Season 2']),
        _C(1, ['Kaguya-sama: Love is War']),
      ]);
      expect(r!.candidate.id, 2);
    });

    test('an unmarked title prefers the unmarked entry over a sequel', () {
      final r = _match('Overlord', const [
        _C(1, ['Overlord 2']),
        _C(2, ['Overlord']),
      ]);
      expect(r!.candidate.id, 2);
    });

    test('the ordinal season form is understood', () {
      final r = _match('Shingeki no Kyojin 2nd Season', const [
        _C(1, ['Shingeki no Kyojin']),
        _C(2, ['Shingeki no Kyojin 2nd Season']),
      ]);
      expect(r!.candidate.id, 2);
    });

    test('punctuation and spacing differences still match', () {
      final r = _match('Re:Zero kara Hajimeru Isekai Seikatsu', const [
        _C(1, ['ReZero kara Hajimeru Isekai Seikatsu']),
        _C(2, ['Tensei Shitara Slime Datta Ken']),
      ]);
      expect(r!.candidate.id, 1);
      expect(r.confident, isTrue);
    });

    test('a subtitle on the candidate does not prevent a match', () {
      final r = _match('Berserk', const [
        _C(1, ['Berserk: Deluxe Edition']),
        _C(2, ['Bastard!!']),
      ]);
      expect(r!.candidate.id, 1);
      expect(r.confident, isTrue);
    });

    test('placeholder titles are ignored', () {
      final r = _match('Vinland Saga', const [
        _C(1, ['?', 'n/a']),
        _C(2, ['Vinland Saga']),
      ]);
      expect(r!.candidate.id, 2);
    });

    test('an alternative title matches when the source title does not', () {
      final r = _match('Zzzz Unknown Release', const [
        _C(1, ['Berserk']),
        _C(2, ['Vagabond']),
      ], alternatives: const ['Vagabond']);
      expect(r!.candidate.id, 2);
    });

    test('an unrelated title returns the best candidate, not confident', () {
      final r = _match('Completely Unrelated Manga Title', const [
        _C(1, ['Berserk']),
      ]);
      expect(r!.candidate.id, 1);
      expect(r.confident, isFalse);
    });

    test('the season comes from the matched title, not a sibling', () {
      final r = _match('Overlord Season 2', const [
        _C(1, ['Overlord Season 5', 'Overlord Season 2']),
      ]);
      expect(r!.score, 1);
      expect(r.confident, isTrue);
    });

    test('a trailing volume number is not a season', () {
      expect(TitleMatcher.seasonOf('Berserk Vol 3'), isNull);
      expect(TitleMatcher.seasonOf('Overlord 2'), 2);
      final r = _match('Berserk Vol 3', const [
        _C(1, ['Berserk']),
        _C(2, ['Bastard!!']),
      ]);
      expect(r!.candidate.id, 1);
      expect(r.confident, isTrue);
    });

    test('empty inputs', () {
      expect(_match('Berserk', const []), isNull);
      expect(
          _match('   ', const [
            _C(1, ['Berserk'])
          ]),
          isNull);
      final r = _match('Berserk', const [
        _C(1, []),
        _C(2, ['Berserk']),
      ]);
      expect(r!.candidate.id, 2);
    });
  });
}
