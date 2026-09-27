/// One row of the Feed: a source's latest (or popular) titles, or a saved
/// search on that source.
class FeedRow {
  final String id;
  final int typeIndex;
  final String sourceId;
  final String sourceName;

  /// Saved search; null or empty = the source's latest updates.
  final String? query;

  const FeedRow({
    required this.id,
    required this.typeIndex,
    required this.sourceId,
    required this.sourceName,
    this.query,
  });

  bool get isSearch => (query ?? '').trim().isNotEmpty;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': typeIndex,
        'sourceId': sourceId,
        'sourceName': sourceName,
        if (isSearch) 'query': query!.trim(),
      };

  static FeedRow? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'], type = json['type'], source = json['sourceId'];
    if (id is! String || type is! int || source is! String) return null;
    return FeedRow(
      id: id,
      typeIndex: type,
      sourceId: source,
      sourceName: json['sourceName'] as String? ?? source,
      query: json['query'] as String?,
    );
  }
}

/// Decodes stored rows, skipping malformed ones.
List<FeedRow> decodeFeedRows(List<Object?> raw) => [
      for (final r in raw)
        if (FeedRow.fromJson(r) case final FeedRow row) row,
    ];

/// Adds [row] unless the same source + search is already there.
List<FeedRow> addFeedRow(List<FeedRow> rows, FeedRow row) {
  final exists = rows.any((r) =>
      r.typeIndex == row.typeIndex &&
      r.sourceId == row.sourceId &&
      (r.query ?? '').trim().toLowerCase() ==
          (row.query ?? '').trim().toLowerCase());
  return exists ? rows : [...rows, row];
}

/// Moves the row with [id] by [delta] places (clamped to the list).
List<FeedRow> moveFeedRow(List<FeedRow> rows, String id, int delta) {
  final from = rows.indexWhere((r) => r.id == id);
  if (from == -1) return rows;
  final to = (from + delta).clamp(0, rows.length - 1);
  final result = [...rows];
  final row = result.removeAt(from);
  result.insert(to, row);
  return result;
}
