import 'dart:async';

import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/core/latest_only.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/reader/core/dual_page.dart';
import 'package:anymex/hv/reader/reader_downloads_service.dart';
import 'package:anymex/hv/reader/series_settings.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:flutter/widgets.dart';
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

    // Finished chapters are noted as the reader moves off them (their
    // downloads are deleted when it closes); download-ahead checks progress
    // on every page change.
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

  /// Dual page spreads for one chapter: first page alone when chosen, wide
  /// pages (already known to be wide) alone.
  static List<ReaderPage> dualSpreads(
      ReaderController c, List<PageUrl> pages, Chapter? chapter) {
    final pairs = pairPages<PageUrl>(
      pages,
      shiftFirst: HvKeys.hvDualPageShift.get<bool>(false),
      isWide: (p) => (c.pageAspectRatios[p.url] ?? 0) > kWidePageRatio,
    );
    return [
      for (final (first, second) in pairs)
        ReaderPage(page1: first, page2: second, chapter: chapter),
    ];
  }

  static final Expando<Timer> _respread = Expando('hvRespread');

  /// Paged mode: records a page's shape when its image loads, and re-pairs
  /// the spreads when a page shown paired turns out to be wide.
  ///
  /// Page shapes were only recorded by the continuous reader, and spreads
  /// are built before any image loads, so "wide pages alone" never applied
  /// in dual page mode. This re-pairs once per newly found wide page
  /// (debounced) and keeps the reader on the same page.
  static void onPagedImageLoaded(
      ReaderController c, String url, double width, double height) {
    if (width <= 0 || height <= 0) return;
    final wasWide = (c.pageAspectRatios[url] ?? 0) > kWidePageRatio;
    c.updatePageAspectRatio(url, width, height);
    if (wasWide || width / height <= kWidePageRatio || !c.isDualPage) return;
    final paired = c.spreads.any((s) =>
        s.page2 != null && (s.page1?.url == url || s.page2?.url == url));
    if (!paired) return;
    final chapter = c.currentChapter.value;
    _respread[c]?.cancel();
    _respread[c] = Timer(const Duration(milliseconds: 300), () {
      if (c.isClosed ||
          c.currentChapter.value != chapter ||
          c.loadingState.value != LoadingState.loaded) {
        return;
      }
      final page = c.currentPageIndex.value;
      c.toggleDualPageMode(c.dualPageMode.value); // recomputes the spreads
      c.navigateToPage(page - 1);
    });
  }

  /// The two halves of a spread in reading order: right-to-left puts the
  /// first page on the right.
  static List<Widget> orderSpread(ReaderController c, List<Widget> halves) =>
      c.readingDirection.value == MangaPageViewDirection.left
          ? halves.reversed.toList()
          : halves;

  // ---- chapter transition ------------------------------------------------

  static final Expando<bool> _bypassTransition = Expando('hvTransition');

  /// Called at the start of `chapterNavigator`. Shows the chapter transition
  /// page first when "Always show chapter transition" is on or chapters are
  /// missing in between — the reader had the setting and the logic
  /// (`maybeShowChapterTransition`) but nothing ever called it. Returns true
  /// when the navigation was handled here.
  static bool interceptChapterNav(ReaderController c, bool next) {
    if (_bypassTransition[c] == true) {
      _bypassTransition[c] = false;
      return false;
    }
    final i = c.currentSpreadIndex.value;
    // Already looking at an inline transition page: just go.
    if (i >= 0 && i < c.spreads.length && c.spreads[i].isTransition) {
      return false;
    }
    // maybeShowChapterTransition either shows the transition or calls
    // chapterNavigator again, which must then pass straight through.
    _bypassTransition[c] = true;
    c.maybeShowChapterTransition(next);
    _bypassTransition[c] = false;
    return true;
  }

  static void continueTransition(ReaderController c) {
    c.showingTransition.value = false;
    _bypassTransition[c] = true;
    c.chapterNavigator(c.transitionIsNext.value);
  }

  static void cancelTransition(ReaderController c) =>
      c.showingTransition.value = false;

  static final Expando<Set<String>> _inlineFailures =
      Expando('hvInlineFailures');

  /// Shows why the next chapter couldn't be added below this one, once per
  /// chapter while the reader is open. The reader retries every 1.5 seconds
  /// while the end of the chapter is on screen, so a chapter that keeps
  /// failing would otherwise show the message again and again.
  static void reportInlineLoadFailure(
      ReaderController c, String chapterKey, String message) {
    // A page load can take up to a minute, so it may fail after the reader
    // closed; the message would then show over another screen.
    if (c.isClosed) return;
    if ((_inlineFailures[c] ??= <String>{}).add(chapterKey)) {
      snackBar(message);
    }
  }

  static final Expando<HvLatestOnly> _pageLoads = Expando('hvPageLoads');

  /// Starts loading a chapter's pages and returns the load's number.
  ///
  /// A load can take up to a minute (a slow source, or the time limit), so it
  /// may finish after the user opened another chapter. Only the newest load
  /// may then set the pages or the error; see [isLatestPageLoad].
  static int beginPageLoad(ReaderController c) =>
      (_pageLoads[c] ??= HvLatestOnly()).begin();

  static bool isLatestPageLoad(ReaderController c, int load) =>
      _pageLoads[c]?.isCurrent(load) ?? true;

  // ---- settings -----------------------------------------------------------

  static final Expando<Timer> _saveTimers = Expando('hvSave');

  /// Saves reader settings shortly after the last change (for sliders).
  static void saveSoon(ReaderController c) {
    _saveTimers[c]?.cancel();
    _saveTimers[c] =
        Timer(const Duration(milliseconds: 400), c.savePreferences);
  }

  /// Called when the reader closes.
  static void detach(ReaderController c) {
    HvReaderDownloads.onReaderClosed(c);
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
