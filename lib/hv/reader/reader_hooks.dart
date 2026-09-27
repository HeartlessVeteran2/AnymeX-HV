import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/reader/reader_downloads_service.dart';
import 'package:anymex/hv/reader/series_settings.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:get/get.dart';

/// Hooks and helpers for the manga reader (`ReaderController`).
class HvReaderHooks {
  HvReaderHooks._();

  /// A page to open once its chapter's pages have loaded (set before
  /// opening the reader from a bookmark).
  static ({String chapterKey, int pageNumber, int at})? _pendingJump;

  static void openAtPage(String chapterKey, int pageNumber) => _pendingJump = (
        chapterKey: chapterKey,
        pageNumber: pageNumber,
        at: DateTime.now().millisecondsSinceEpoch,
      );

  /// Called from `ReaderController.init` after it loaded its settings.
  static void attach(ReaderController c) {
    HvSeriesSettings.attach(c);

    // Delete-after-read runs when the reader moves off a finished chapter;
    // download-ahead checks progress on every page change.
    Chapter? shown = c.currentChapter.value;
    ever<Chapter?>(c.currentChapter, (chapter) {
      final left = shown;
      shown = chapter;
      if (left != null && left != chapter) {
        HvReaderDownloads.onChapterLeft(c, left);
      }
    });
    ever<int>(c.currentPageIndex,
        (page) => HvReaderDownloads.onPageChanged(c, page));

    ever<LoadingState>(c.loadingState, (state) {
      final jump = _pendingJump;
      if (state != LoadingState.loaded || jump == null) return;
      // A jump that didn't happen within a minute (reader failed to open,
      // different chapter) is dropped.
      if (DateTime.now().millisecondsSinceEpoch - jump.at > 60000) {
        _pendingJump = null;
        return;
      }
      final chapter = c.currentChapter.value;
      final key = (chapter?.link ?? '').isNotEmpty
          ? chapter!.link!
          : (chapter?.localPath ?? '');
      if (key != jump.chapterKey) return;
      _pendingJump = null;
      // After the reader's own "resume at saved page" jump.
      Future.delayed(const Duration(milliseconds: 400),
          () => c.navigateToPage(jump.pageNumber - 1));
    });
  }

  /// Called when the reader closes.
  static void detach(ReaderController c) {
    HvReaderDownloads.onChapterLeft(c, c.currentChapter.value);
  }

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
