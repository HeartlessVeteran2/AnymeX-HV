/// What the library search can look at for one title.
class LibrarySearchFields {
  final List<String> titles;
  final String? source;
  final String? status;
  final List<String> genres;

  const LibrarySearchFields({
    required this.titles,
    this.source,
    this.status,
    this.genres = const [],
  });
}

/// A parsed library search (Komikku-style syntax):
/// - `word` — title (or genre) contains the word
/// - `"exact phrase"` — title contains the phrase
/// - `-word` / `-"phrase"` — excluded
/// - `src:name` / `source:name` — source name contains `name`
/// - `status:value` — publishing status contains `value`
/// - `genre:value` / `tag:value` — a genre contains `value`
///
/// Field values may be quoted (`src:"weeb central"`); every part is
/// case-insensitive and all parts must match.
class LibrarySearchQuery {
  final List<String> include;
  final List<String> exclude;
  final Map<String, List<String>> fields;
  final Map<String, List<String>> excludedFields;

  const LibrarySearchQuery._(
      this.include, this.exclude, this.fields, this.excludedFields);

  bool get isEmpty =>
      include.isEmpty &&
      exclude.isEmpty &&
      fields.isEmpty &&
      excludedFields.isEmpty;

  static const Map<String, String> _fieldAliases = {
    'src': 'source',
    'source': 'source',
    'status': 'status',
    'genre': 'genre',
    'tag': 'genre',
  };

  static final RegExp _token =
      RegExp(r'(-?)(?:(\w+):)?(?:"([^"]*)"|(\S+))');

  factory LibrarySearchQuery.parse(String query) {
    final include = <String>[];
    final exclude = <String>[];
    final fields = <String, List<String>>{};
    final excludedFields = <String, List<String>>{};
    for (final m in _token.allMatches(query)) {
      final negated = m.group(1) == '-';
      final rawField = m.group(2)?.toLowerCase();
      final value = (m.group(3) ?? m.group(4) ?? '').trim().toLowerCase();
      final field = rawField == null ? null : _fieldAliases[rawField];
      if (rawField != null && field == null) {
        // Unknown "x:y" — treat the whole token as text.
        final text = '$rawField:$value';
        (negated ? exclude : include).add(text);
        continue;
      }
      if (value.isEmpty) continue;
      if (field == null) {
        (negated ? exclude : include).add(value);
      } else {
        (negated ? excludedFields : fields)
            .putIfAbsent(field, () => [])
            .add(value);
      }
    }
    return LibrarySearchQuery._(include, exclude, fields, excludedFields);
  }

  bool matches(LibrarySearchFields f) {
    final titles = f.titles.map((t) => t.toLowerCase()).toList();
    final genres = f.genres.map((g) => g.toLowerCase()).toList();
    bool text(String term) =>
        titles.any((t) => t.contains(term)) || genres.any((g) => g == term);
    bool field(String name, String value) => switch (name) {
          'source' => (f.source ?? '').toLowerCase().contains(value),
          'status' => (f.status ?? '').toLowerCase().contains(value),
          'genre' => genres.any((g) => g.contains(value)),
          _ => false,
        };

    if (!include.every(text)) return false;
    if (exclude.any(text)) return false;
    for (final entry in fields.entries) {
      if (!entry.value.every((v) => field(entry.key, v))) return false;
    }
    for (final entry in excludedFields.entries) {
      if (entry.value.any((v) => field(entry.key, v))) return false;
    }
    return true;
  }
}
