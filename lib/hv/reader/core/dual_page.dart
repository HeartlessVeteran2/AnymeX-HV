/// Wider than this (width / height) and a page is shown alone in dual page
/// mode — it's already a two-page spread.
const double kWidePageRatio = 1.2;

/// Pairs pages for dual page mode (Komikku/Otaku Reader rules):
/// - with [shiftFirst] the first page (usually the cover) is shown alone,
///   which lines up the rest of the book's spreads;
/// - a wide page is shown alone and pairing restarts after it.
List<(T, T?)> pairPages<T>(
  List<T> pages, {
  bool shiftFirst = false,
  bool Function(T page)? isWide,
}) {
  final wide = isWide ?? (_) => false;
  final result = <(T, T?)>[];
  var i = 0;
  if (shiftFirst && pages.isNotEmpty) {
    result.add((pages.first, null));
    i = 1;
  }
  while (i < pages.length) {
    final first = pages[i];
    if (wide(first) || i + 1 >= pages.length || wide(pages[i + 1])) {
      result.add((first, null));
      i += 1;
    } else {
      result.add((first, pages[i + 1]));
      i += 2;
    }
  }
  return result;
}
