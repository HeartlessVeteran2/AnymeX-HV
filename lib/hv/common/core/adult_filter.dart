/// Makes an AniList query's `media(...)` lists follow "Hide Adult Content".
///
/// With [hideAdult], each list gets `isAdult: false`. Without it, any fixed
/// `isAdult` filter is dropped, so adult and other titles both come back
/// (AniList returns both when the filter is left out).
///
/// Only for queries whose `media(` fields are `Page.media` lists, which take
/// an `isAdult` argument. GraphQL ignores commas, so a comma left behind by a
/// removed argument is harmless.
String hvAdultMediaQuery(String query, {required bool hideAdult}) {
  final open = query.replaceAll(RegExp(r'isAdult:\s*(true|false)'), '');
  if (!hideAdult) return open;
  return open.replaceAll(RegExp(r'\bmedia\('), 'media(isAdult: false, ');
}

/// A MyAnimeList list URL that includes 18+ entries unless [hideAdult].
/// MyAnimeList leaves them out unless the request asks with `nsfw=true`.
String hvAdultMalUrl(String url, {required bool hideAdult}) {
  if (hideAdult || url.contains('nsfw=')) return url;
  return '$url${url.contains('?') ? '&' : '?'}nsfw=true';
}

/// The tags search offers: [tags], plus [adultTags] when adult results are on.
List<String> hvSearchTags(
  List<String> tags,
  List<String> adultTags, {
  required bool showAdult,
}) =>
    showAdult ? ([...tags, ...adultTags]..sort()) : tags;

/// [filters] without the adult tags in [adultTags], for a search that leaves
/// adult titles out: asking for an adult tag there can only return nothing.
Map<String, dynamic> hvWithoutAdultTags(
  Map<String, dynamic> filters,
  List<String> adultTags,
) {
  final tags = filters['tags'];
  if (tags is! List || adultTags.isEmpty) return filters;
  final kept = tags.where((t) => !adultTags.contains(t)).toList();
  return {...filters, 'tags': kept.isEmpty ? null : kept};
}

/// Titles in the bundled home fallback lists (`lib/utils/fallback/`) that
/// AniList marks 18+. That data carries no `isAdult` flag, so they are listed
/// here; checked against AniList. `adult_filter_test.dart` fails if the
/// fallback data stops containing one of them.
const hvAdultFallbackIds = {
  98543, 98563, 98585, 98601, 98617, 98620, 99256, 148784, //
  149015, 149089, 149096, 149115, 169086, 183358, 183401,
};

/// Whether a fallback title with this [id] is 18+.
bool hvIsAdultFallback(String id) =>
    hvAdultFallbackIds.contains(int.tryParse(id));
