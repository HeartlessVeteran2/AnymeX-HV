/// String similarity measures for matching titles across sources and trackers.
///
/// Ported from Otaku Reader's `StringSimilarity`. They follow the shape of
/// FuzzyWuzzy's `ratio` / `partial_ratio` / `token_set_ratio`, but the base
/// measure is Levenshtein-normalized (`1 - distance / maxLength`), which is not
/// what the `fuzzywuzzy` Dart package does. The matcher's 0.7 threshold was
/// tuned against this version, so the two are not interchangeable.
///
/// All three expect strings that are already normalized (see
/// `title_normalizer.dart`); none of them lowercase or strip punctuation.
class StringSimilarity {
  StringSimilarity._();

  static final RegExp _whitespace = RegExp(r'\s+');

  /// Levenshtein-normalized similarity in 0..1. Two empty strings are 1.0.
  static double ratio(String a, String b) {
    if (a == b) return 1;
    final maxLength = a.length > b.length ? a.length : b.length;
    if (maxLength == 0) return 1;
    return 1 - levenshtein(a, b) / maxLength;
  }

  /// Best [ratio] between the shorter string and every same-length window of
  /// the longer one, so `"berserk"` scores 1.0 against
  /// `"berserk deluxe edition"`.
  static double partialRatio(String a, String b) {
    if (a.isEmpty || b.isEmpty) return a == b ? 1 : 0;
    final shorter = a.length <= b.length ? a : b;
    final longer = a.length <= b.length ? b : a;
    if (shorter.length == longer.length) return ratio(shorter, longer);

    var best = 0.0;
    for (var start = 0; start <= longer.length - shorter.length; start++) {
      final window = longer.substring(start, start + shorter.length);
      final score = ratio(shorter, window);
      if (score > best) best = score;
      if (best == 1) return 1;
    }
    return best;
  }

  /// Compares the strings as sets of words, so order and duplication don't
  /// matter: `"love is war"` vs `"war is love"` is 1.0.
  static double tokenSetRatio(String a, String b) {
    final tokensA = _tokens(a);
    final tokensB = _tokens(b);
    if (tokensA.isEmpty && tokensB.isEmpty) return 1;
    if (tokensA.isEmpty || tokensB.isEmpty) return 0;

    final intersection = (tokensA.where(tokensB.contains).toList()..sort());
    final restOfA = (tokensA.where((t) => !tokensB.contains(t)).toList()
      ..sort());
    final restOfB = (tokensB.where((t) => !tokensA.contains(t)).toList()
      ..sort());

    final joined = intersection.join(' ');
    final combinedA = '$joined ${restOfA.join(' ')}'.trim();
    final combinedB = '$joined ${restOfB.join(' ')}'.trim();

    return [
      ratio(joined, combinedA),
      ratio(joined, combinedB),
      ratio(combinedA, combinedB),
    ].reduce((x, y) => x > y ? x : y);
  }

  /// Levenshtein edit distance (two-row implementation).
  static int levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    var previous = List<int>.generate(b.length + 1, (i) => i);
    var current = List<int>.filled(b.length + 1, 0);

    for (var i = 1; i <= a.length; i++) {
      current[0] = i;
      final ca = a.codeUnitAt(i - 1);
      for (var j = 1; j <= b.length; j++) {
        final substitution =
            previous[j - 1] + (ca == b.codeUnitAt(j - 1) ? 0 : 1);
        final insertion = current[j - 1] + 1;
        final deletion = previous[j] + 1;
        var best = substitution;
        if (insertion < best) best = insertion;
        if (deletion < best) best = deletion;
        current[j] = best;
      }
      final swap = previous;
      previous = current;
      current = swap;
    }
    return previous[b.length];
  }

  static Set<String> _tokens(String s) =>
      s.split(_whitespace).where((t) => t.isNotEmpty).toSet();
}
