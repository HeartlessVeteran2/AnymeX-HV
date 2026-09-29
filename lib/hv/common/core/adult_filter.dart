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
