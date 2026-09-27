import 'package:anymex/screens/manga/controller/reader_controller.dart';

/// Hooks and helpers for the manga reader (`ReaderController`).
class HvReaderHooks {
  HvReaderHooks._();

  /// Shows [spreadIndex] in either reading mode. The reader's own page
  /// listeners then update the current chapter and page.
  static void jumpToSpread(ReaderController c, int spreadIndex) {
    if (spreadIndex < 0 || spreadIndex >= c.spreads.length) return;
    if (c.readingLayout.value == MangaPageViewMode.continuous) {
      c.itemScrollController?.jumpTo(index: spreadIndex);
    } else {
      c.pageController?.jumpToPage(spreadIndex);
    }
  }
}
