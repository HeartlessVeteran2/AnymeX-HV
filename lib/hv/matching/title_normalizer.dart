/// Title normalization shared by the matcher (ported from Otaku Reader's
/// `TitleNormalizer` and `PlaceholderTitles`).
class TitleNormalizer {
  TitleNormalizer._();

  static const Set<String> _placeholders = {
    '?',
    '??',
    '???',
    '-',
    '--',
    'N/A',
    'NA',
    'NULL',
    'UNKNOWN',
    'UNKNOWN TITLE',
  };

  /// False for titles that carry no information (`"?"`, `"N/A"`, blank...).
  /// Two placeholders would otherwise be a perfect match for each other.
  static bool isMeaningful(String? title) {
    final trimmed = (title ?? '').trim();
    return trimmed.isNotEmpty && !_placeholders.contains(trimmed.toUpperCase());
  }

  static final RegExp _yearInBrackets = RegExp(r'\s*[(\[]\s*\d{4}\s*[)\]]\s*');
  static final RegExp _trailingYear = RegExp(r'\s*-\s*\d{4}\s*$');
  static final RegExp _nonWord = RegExp(r'[^\p{L}\p{N}\p{M}\s]', unicode: true);
  static final RegExp _spaces = RegExp(r'\s+');
  static final RegExp _trailingUnit = RegExp(
    r'\s*(?:part|season|vol|volume|ch|chapter)\s+\d+\s*$',
    caseSensitive: false,
  );

  /// Lowercases, drops year markers, a leading article, punctuation and a
  /// trailing `part/season/vol/chapter N`, and collapses whitespace.
  static String normalize(String title) {
    var s = title.toLowerCase().trim();

    s = s.replaceAll('×', ' x ').replaceAll('–', ' ').replaceAll('—', ' ');

    s = s.replaceAll(_yearInBrackets, ' ');
    s = s.replaceAll(_trailingYear, '');

    for (final prefix in const ['the ', 'a ', 'an ']) {
      if (s.startsWith(prefix)) {
        s = s.substring(prefix.length);
        break;
      }
    }

    s = s.replaceAll(_nonWord, ' ');
    s = s.replaceAll(_spaces, ' ');
    s = s.replaceAll(_trailingUnit, '');
    return s.replaceAll(_spaces, ' ').trim();
  }

  static final RegExp _seasonWord = RegExp(r'\bseason\b');
  static final RegExp _nonAlphanumeric =
      RegExp(r'[^\p{L}\p{N}]', unicode: true);

  /// Drops the word "season" and everything that isn't a letter or digit from
  /// an already-normalized title (`"re zero"` → `"rezero"`).
  static String heavy(String normalized) => normalized
      .replaceAll(_seasonWord, ' ')
      .replaceAll(_nonAlphanumeric, '');
}
