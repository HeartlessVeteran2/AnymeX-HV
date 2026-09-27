/// One "X is recommended for Y" edge from AniList.
class RecEdge {
  /// The library title that recommends it (for "because you like …").
  final String fromTitle;

  final int mediaId;
  final int? idMal;
  final String title;
  final String? cover;
  final String? format;
  final int? averageScore;

  /// AniList community rating of this recommendation (can be negative).
  final int rating;

  const RecEdge({
    required this.fromTitle,
    required this.mediaId,
    this.idMal,
    required this.title,
    this.cover,
    this.format,
    this.averageScore,
    required this.rating,
  });
}

/// A title recommended by one or more library titles.
class RankedRec {
  final int mediaId;
  final int? idMal;
  final String title;
  final String? cover;
  final String? format;
  final int? averageScore;
  final List<String> because;
  final int ratingSum;

  const RankedRec({
    required this.mediaId,
    this.idMal,
    required this.title,
    this.cover,
    this.format,
    this.averageScore,
    required this.because,
    required this.ratingSum,
  });

  int get count => because.length;

  Map<String, dynamic> toJson() => {
        'id': mediaId,
        'idMal': idMal,
        'title': title,
        'cover': cover,
        'format': format,
        'score': averageScore,
        'because': because,
        'rating': ratingSum,
      };

  static RankedRec? fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! int) return null;
    return RankedRec(
      mediaId: id,
      idMal: json['idMal'] as int?,
      title: json['title'] as String? ?? '?',
      cover: json['cover'] as String?,
      format: json['format'] as String?,
      averageScore: json['score'] as int?,
      because: (json['because'] as List?)?.whereType<String>().toList() ?? [],
      ratingSum: json['rating'] as int? ?? 0,
    );
  }
}

/// Komikku's "common recommendations": titles recommended by the most
/// library titles first (ties broken by the summed community rating), with
/// titles already in the library — by AniList or MAL id — left out, and
/// recommendations the community voted down ignored.
List<RankedRec> rankRecommendations(
  List<RecEdge> edges, {
  Set<int> excludeIds = const {},
  Set<int> excludeMalIds = const {},
}) {
  final byId = <int, List<RecEdge>>{};
  for (final e in edges) {
    if (e.rating < 0) continue;
    if (excludeIds.contains(e.mediaId)) continue;
    if (e.idMal != null && excludeMalIds.contains(e.idMal)) continue;
    byId.putIfAbsent(e.mediaId, () => []).add(e);
  }
  final ranked = [
    for (final group in byId.values)
      RankedRec(
        mediaId: group.first.mediaId,
        idMal: group.first.idMal,
        title: group.first.title,
        cover: group.first.cover,
        format: group.first.format,
        averageScore: group.first.averageScore,
        because: group.map((e) => e.fromTitle).toSet().toList(),
        ratingSum: group.fold(0, (sum, e) => sum + e.rating),
      ),
  ];
  ranked.sort((a, b) {
    final byCount = b.count.compareTo(a.count);
    if (byCount != 0) return byCount;
    final byRating = b.ratingSum.compareTo(a.ratingSum);
    if (byRating != 0) return byRating;
    return (b.averageScore ?? 0).compareTo(a.averageScore ?? 0);
  });
  return ranked;
}
