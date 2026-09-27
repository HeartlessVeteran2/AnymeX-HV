/// One reader spread as the gallery sees it: the chapter it belongs to and
/// its one or two pages. Transition spreads have no pages.
class GallerySpread<C, P> {
  final C? chapter;
  final List<P> pages;
  final bool isTransition;

  const GallerySpread(this.chapter, this.pages, {this.isTransition = false});
}

/// A page thumbnail: where it is in the reader and its number in its chapter.
class GalleryItem<P> {
  /// Index into the reader's spreads (what the reader jumps to).
  final int spreadIndex;

  /// 1-based page number within its chapter.
  final int pageNumber;
  final P page;

  const GalleryItem(this.spreadIndex, this.pageNumber, this.page);
}

/// All loaded pages of one chapter.
class GallerySection<C, P> {
  final C? chapter;
  final List<GalleryItem<P>> items;

  GallerySection(this.chapter, this.items);
}

/// Turns the reader's spreads (current chapter plus chapters loaded inline)
/// into per-chapter sections of page thumbnails.
List<GallerySection<C, P>> buildGallery<C, P>(List<GallerySpread<C, P>> spreads) {
  final sections = <GallerySection<C, P>>[];
  for (var i = 0; i < spreads.length; i++) {
    final spread = spreads[i];
    if (spread.isTransition || spread.pages.isEmpty) continue;
    if (sections.isEmpty || sections.last.chapter != spread.chapter) {
      sections.add(GallerySection<C, P>(spread.chapter, []));
    }
    final items = sections.last.items;
    for (final page in spread.pages) {
      items.add(GalleryItem<P>(i, items.length + 1, page));
    }
  }
  return sections;
}

/// Section and item index of the first thumbnail on [spreadIndex], or null.
({int section, int item})? findGalleryItem<C, P>(
    List<GallerySection<C, P>> sections, int spreadIndex) {
  for (var s = 0; s < sections.length; s++) {
    final items = sections[s].items;
    for (var i = 0; i < items.length; i++) {
      if (items[i].spreadIndex == spreadIndex) return (section: s, item: i);
    }
  }
  return null;
}

/// Scroll offset that puts the row holding [target] at the top of a gallery
/// laid out as: per section, a header of [headerExtent] then a grid of
/// [columns] with rows of [rowExtent] (spacing included).
double galleryScrollOffset<C, P>(
  List<GallerySection<C, P>> sections,
  ({int section, int item}) target, {
  required int columns,
  required double headerExtent,
  required double rowExtent,
}) {
  var offset = 0.0;
  for (var s = 0; s < target.section; s++) {
    final rows = (sections[s].items.length + columns - 1) ~/ columns;
    offset += headerExtent + rows * rowExtent;
  }
  offset += headerExtent + (target.item ~/ columns) * rowExtent;
  return offset;
}
