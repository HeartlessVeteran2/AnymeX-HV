import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/bookmarks/bookmark_repository.dart';
import 'package:anymex/hv/bookmarks/models/hv_page_bookmark.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';

/// Bookmark helpers bound to the reader's current state.
class HvReaderBookmarks {
  HvReaderBookmarks._();

  /// Same key the reader uses for a chapter's loaded pages.
  static String chapterKey(Chapter? chapter) {
    if (chapter == null) return '';
    if ((chapter.link ?? '').isNotEmpty) return chapter.link!;
    if ((chapter.localPath ?? '').isNotEmpty) return chapter.localPath!;
    return 'n:${chapter.number ?? ''}';
  }

  static String mediaKey(ReaderController c) =>
      hvMediaKey(c.media.mediaType.index, c.media.id);

  static String currentKey(ReaderController c) => hvBookmarkKey(
      mediaKey(c), chapterKey(c.currentChapter.value), c.currentPageIndex.value);

  static PageUrl? _page(ReaderController c, Chapter? chapter, int pageNumber) {
    final pages = c.loadedChapterPages[chapterKey(chapter)] ?? c.pageList;
    final i = pageNumber - 1;
    return i >= 0 && i < pages.length ? pages[i] : null;
  }

  /// Bookmarks (or un-bookmarks) a page; the current page by default.
  /// Returns true when it is bookmarked afterwards.
  static Future<bool> toggle(ReaderController c,
      {Chapter? chapter, int? pageNumber}) async {
    final ch = chapter ?? c.currentChapter.value;
    final page = pageNumber ?? c.currentPageIndex.value;
    final key = chapterKey(ch);
    if (ch == null || key.isEmpty || page < 1) return false;
    final pageUrl = _page(c, ch, page);
    final headers = pageUrl?.headers ?? const <String, String>{};
    return BookmarkRepository.toggle(HvPageBookmark()
      ..bookmarkKey = hvBookmarkKey(mediaKey(c), key, page)
      ..mediaKey = mediaKey(c)
      ..mediaId = c.media.id
      ..mediaTypeIndex = c.media.mediaType.index
      ..mediaTitle = c.media.title
      ..poster = c.media.poster
      ..chapterKey = key
      ..chapterNumber = ch.number
      ..chapterTitle = ch.title
      ..pageNumber = page
      ..pageUrl = pageUrl?.url
      ..headerKeys = headers.keys.toList()
      ..headerValues = headers.values.toList()
      ..createdAt = DateTime.now().millisecondsSinceEpoch);
  }
}
