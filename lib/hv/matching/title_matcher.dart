import 'string_similarity.dart';
import 'title_normalizer.dart';

/// The best candidate for a set of titles, with its score (0..1).
class TitleMatch<T> {
  final T candidate;
  final double score;

  /// True when the score reached [TitleMatcher.acceptThreshold].
  final bool confident;

  const TitleMatch(this.candidate, this.score, this.confident);
}

/// Picks the candidate whose titles best match a set of target titles.
///
/// Ported from Otaku Reader's `MatchAniListMediaUseCase`:
/// - every candidate title is compared with every target title and the best
///   pair wins;
/// - a pair scores `max(0.4·tokenSet + 0.3·partial + 0.3·ratio, ratio(heavy))`;
/// - seasons stated in the raw titles add +0.3 when they agree and −0.3 when
///   they differ (nothing when either is unknown);
/// - candidates are ranked on the unclamped score, because normalization
///   strips `season N` and the season term is the only thing that separates a
///   work from its sequel. The reported score is clamped to 0..1.
class TitleMatcher {
  TitleMatcher._();

  static const double weightTokenSet = 0.4;
  static const double weightPartial = 0.3;
  static const double weightRatio = 0.3;
  static const double seasonWeight = 0.3;
  static const double acceptThreshold = 0.7;

  /// Returns the best candidate, or null when there are no candidates or no
  /// meaningful target titles.
  static TitleMatch<T>? bestMatch<T>(
    List<String> targetTitles,
    List<T> candidates,
    List<String?> Function(T candidate) titlesOf,
  ) {
    if (candidates.isEmpty) return null;
    final targets = _forms(targetTitles);
    if (targets.isEmpty) return null;

    T? best;
    var bestRaw = double.negativeInfinity;
    for (final candidate in candidates) {
      final raw = _rawScore(targets, _forms(titlesOf(candidate)));
      if (raw > bestRaw) {
        bestRaw = raw;
        best = candidate;
      }
    }
    if (best == null) return null;
    return TitleMatch<T>(
      best as T,
      bestRaw.clamp(0.0, 1.0).toDouble(),
      bestRaw >= acceptThreshold,
    );
  }

  /// Score of one title against another (0..1), for callers that compare a
  /// single pair.
  static double score(String a, String b) {
    final fa = _forms([a]);
    final fb = _forms([b]);
    if (fa.isEmpty || fb.isEmpty) return 0;
    return _rawScore(fa, fb).clamp(0.0, 1.0).toDouble();
  }

  static double _rawScore(List<_TitleForm> targets, List<_TitleForm> titles) {
    if (titles.isEmpty) return 0;
    var best = 0.0;
    for (final target in targets) {
      for (final title in titles) {
        final paired = _similarity(target, title) +
            _seasonAdjustment(target.season, title.season);
        if (paired > best) best = paired;
      }
    }
    return best;
  }

  static double _similarity(_TitleForm a, _TitleForm b) {
    final light = weightTokenSet *
            StringSimilarity.tokenSetRatio(a.normalized, b.normalized) +
        weightPartial *
            StringSimilarity.partialRatio(a.normalized, b.normalized) +
        weightRatio * StringSimilarity.ratio(a.normalized, b.normalized);
    final heavy = StringSimilarity.ratio(a.heavy, b.heavy);
    return light > heavy ? light : heavy;
  }

  static double _seasonAdjustment(int? a, int? b) {
    if (a == null || b == null) return 0;
    return a == b ? seasonWeight : -seasonWeight;
  }

  static final RegExp _ordinalSeason = RegExp(r'(\d+)(?:st|nd|rd|th)\s+season');
  static final RegExp _seasonNumber = RegExp(r'season\s+(\d+)');
  static final RegExp _unitQualifiedNumber = RegExp(
    r'\b(?:vol|volume|part|pt|ch|chapter|book|arc|ep|episode)\.?\s*\d+\s*$',
  );
  static final RegExp _trailingNumber = RegExp(r'\s(\d{1,2})\s*$');

  /// The season a raw title states, or null. A trailing number introduced by
  /// a unit word (`Vol 3`, `Chapter 12`) is not a season.
  static int? seasonOf(String rawTitle) {
    final lower = rawTitle.toLowerCase();
    final ordinal = _ordinalSeason.firstMatch(lower);
    if (ordinal != null) return int.tryParse(ordinal.group(1)!);
    final numbered = _seasonNumber.firstMatch(lower);
    if (numbered != null) return int.tryParse(numbered.group(1)!);
    if (_unitQualifiedNumber.hasMatch(lower)) return null;
    final trailing = _trailingNumber.firstMatch(lower);
    if (trailing != null) return int.tryParse(trailing.group(1)!);
    return null;
  }

  static List<_TitleForm> _forms(Iterable<String?> titles) {
    final seen = <String>{};
    final forms = <_TitleForm>[];
    for (final raw in titles) {
      if (raw == null || !TitleNormalizer.isMeaningful(raw)) continue;
      final normalized = TitleNormalizer.normalize(raw);
      final heavy = TitleNormalizer.heavy(normalized);
      if (normalized.isEmpty && heavy.isEmpty) continue;
      final season = seasonOf(raw);
      if (seen.add('$normalized|$heavy|$season')) {
        forms.add(_TitleForm(normalized, heavy, season));
      }
    }
    return forms;
  }
}

class _TitleForm {
  final String normalized;
  final String heavy;
  final int? season;

  const _TitleForm(this.normalized, this.heavy, this.season);
}
