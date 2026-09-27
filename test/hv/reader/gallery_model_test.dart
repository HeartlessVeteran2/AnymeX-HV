import 'package:anymex/hv/reader/core/gallery_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Chapter 1 (3 pages, the last two as a spread), a transition, then an
  // inline-loaded chapter 2 (2 pages).
  const spreads = [
    GallerySpread<String, String>('c1', ['1a']),
    GallerySpread<String, String>('c1', ['1b', '1c']),
    GallerySpread<String, String>('c2', [], isTransition: true),
    GallerySpread<String, String>('c2', ['2a']),
    GallerySpread<String, String>('c2', ['2b']),
  ];

  test('sections per chapter, page numbers restart, spreads kept', () {
    final sections = buildGallery(spreads);
    expect(sections.map((s) => s.chapter).toList(), ['c1', 'c2']);
    final c1 = sections[0].items;
    expect(c1.map((i) => i.page).toList(), ['1a', '1b', '1c']);
    expect(c1.map((i) => i.pageNumber).toList(), [1, 2, 3]);
    expect(c1.map((i) => i.spreadIndex).toList(), [0, 1, 1]);
    final c2 = sections[1].items;
    expect(c2.map((i) => i.pageNumber).toList(), [1, 2]);
    expect(c2.map((i) => i.spreadIndex).toList(), [3, 4]);
  });

  test('finds the first thumbnail of a spread', () {
    final sections = buildGallery(spreads);
    expect(findGalleryItem(sections, 1), (section: 0, item: 1));
    expect(findGalleryItem(sections, 4), (section: 1, item: 1));
    expect(findGalleryItem(sections, 2), isNull);
  });

  test('scroll offset counts headers and full rows of earlier sections', () {
    final sections = buildGallery(spreads);
    // 2 columns: section 0 has 3 items = 2 rows.
    final offset = galleryScrollOffset(sections, (section: 1, item: 1),
        columns: 2, headerExtent: 40, rowExtent: 100);
    expect(offset, 40 + 2 * 100 + 40 + 0 * 100);
    final inFirst = galleryScrollOffset(sections, (section: 0, item: 2),
        columns: 2, headerExtent: 40, rowExtent: 100);
    expect(inFirst, 40 + 1 * 100);
  });
}
