import 'dart:io';
import 'dart:math' as math;

import 'package:anymex/controllers/services/storage/anymex_cache_manager.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/bookmarks/bookmark_repository.dart';
import 'package:anymex/hv/bookmarks/models/hv_page_bookmark.dart';
import 'package:anymex/hv/bookmarks/reader_bookmarks.dart';
import 'package:anymex/hv/bookmarks/ui/bookmarks_screen.dart';
import 'package:anymex/hv/bookmarks/ui/notes_sheet.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/reader/core/gallery_model.dart';
import 'package:anymex/hv/reader/reader_hooks.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/utils/extension_utils.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Reader page gallery (Otaku Reader's page gallery): a grid of every page
/// the reader has loaded — the current chapter plus chapters appended while
/// scrolling — grouped by chapter. Tap a page to jump to it.
class HvPageGallery {
  HvPageGallery._();

  static Future<void> open(BuildContext context, ReaderController c) async {
    if (c.spreads.every((s) => s.isTransition)) {
      snackBar('Pages are still loading');
      return;
    }
    final target = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (_) => HvPageGalleryScreen(controller: c)),
    );
    if (target != null) HvReaderHooks.jumpToSpread(c, target);
  }
}

class HvPageGalleryScreen extends StatefulWidget {
  const HvPageGalleryScreen({super.key, required this.controller});
  final ReaderController controller;

  @override
  State<HvPageGalleryScreen> createState() => _HvPageGalleryScreenState();
}

class _HvPageGalleryScreenState extends State<HvPageGalleryScreen> {
  static const double _headerExtent = 48;
  static const double _spacing = 8;
  static const double _padding = 12;
  static const double _aspect = 0.68;

  late final List<GallerySection<Chapter, PageUrl>> _sections;
  late final int _currentSpread;
  late int _columns;
  final ScrollController _scroll = ScrollController();
  late final Stream<List<HvPageBookmark>> _bookmarks =
      BookmarkRepository.watchForMedia(
          HvReaderBookmarks.mediaKey(widget.controller));
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    final c = widget.controller;
    _currentSpread = c.currentSpreadIndex.value;
    _sections = buildGallery<Chapter, PageUrl>([
      for (final s in c.spreads)
        GallerySpread<Chapter, PageUrl>(
          s.chapter,
          [if (s.page1 != null) s.page1!, if (s.page2 != null) s.page2!],
          isTransition: s.isTransition,
        ),
    ]);
    _columns = HvKeys.hvGalleryColumns.get<int>(3).clamp(2, 4);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  int get _pageCount => _sections.fold(0, (sum, s) => sum + s.items.length);

  void _setColumns(int value) {
    HvKeys.hvGalleryColumns.set(value);
    setState(() {
      _columns = value;
      _scrolled = false;
    });
  }

  void _scrollToCurrent(double width) {
    if (_scrolled) return;
    _scrolled = true;
    final target = findGalleryItem(_sections, _currentSpread);
    if (target == null) return;
    final itemWidth =
        (width - 2 * _padding - (_columns - 1) * _spacing) / _columns;
    final rowExtent = itemWidth / _aspect + _spacing;
    final offset = galleryScrollOffset(_sections, target,
        columns: _columns, headerExtent: _headerExtent, rowExtent: rowExtent);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      final max = _scroll.position.maxScrollExtent;
      _scroll.jumpTo(math.min(math.max(0, offset - _headerExtent), max));
    });
  }

  String _chapterLabel(Chapter? chapter) {
    if (chapter == null) return 'Chapter';
    final number =
        chapter.number != null ? 'Chapter ${chapter.formattedNumber}' : null;
    final title = (chapter.title ?? '').trim();
    if (number == null) return title.isEmpty ? 'Chapter' : title;
    return title.isEmpty || title == number ? number : '$number · $title';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('$_pageCount pages'),
        actions: [
          IconButton(
            tooltip: 'Notes',
            icon: const Icon(Icons.sticky_note_2_outlined),
            onPressed: () => showHvNotesSheet(
              context,
              mediaKey: HvReaderBookmarks.mediaKey(widget.controller),
              chapterKey: HvReaderBookmarks.chapterKey(
                  widget.controller.currentChapter.value),
              chapter: widget.controller.currentChapter.value,
            ),
          ),
          IconButton(
            tooltip: 'Bookmarks',
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => HvBookmarksScreen(
                mediaKey: HvReaderBookmarks.mediaKey(widget.controller),
                title: widget.controller.media.title,
              ),
            )),
          ),
          for (final n in const [2, 3, 4])
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ChoiceChip(
                label: Text('$n'),
                selected: _columns == n,
                onSelected: (_) => _setColumns(n),
                visualDensity: VisualDensity.compact,
              ),
            ),
          const SizedBox(width: 6),
        ],
      ),
      body: StreamBuilder<List<HvPageBookmark>>(
        stream: _bookmarks,
        builder: (context, snapshot) {
          final bookmarked = {
            for (final b in snapshot.data ?? const <HvPageBookmark>[])
              b.bookmarkKey,
          };
          final mediaKey = HvReaderBookmarks.mediaKey(widget.controller);
          return LayoutBuilder(builder: (context, constraints) {
            _scrollToCurrent(constraints.maxWidth);
            return CustomScrollView(
              controller: _scroll,
              slivers: [
                for (final section in _sections) ...[
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: _headerExtent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${_chapterLabel(section.chapter)} · ${section.items.length}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: colors.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: _padding),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _columns,
                        mainAxisSpacing: _spacing,
                        crossAxisSpacing: _spacing,
                        childAspectRatio: _aspect,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final item = section.items[i];
                          final chapterKey =
                              HvReaderBookmarks.chapterKey(section.chapter);
                          return _Thumbnail(
                            item: item,
                            current: item.spreadIndex == _currentSpread,
                            bookmarked: bookmarked.contains(hvBookmarkKey(
                                mediaKey, chapterKey, item.pageNumber)),
                            onTap: () =>
                                Navigator.pop(context, item.spreadIndex),
                            onLongPress: () => HvReaderBookmarks.toggle(
                                widget.controller,
                                chapter: section.chapter,
                                pageNumber: item.pageNumber),
                          );
                        },
                        childCount: section.items.length,
                      ),
                    ),
                  ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          });
        },
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.item,
    required this.current,
    required this.bookmarked,
    required this.onTap,
    required this.onLongPress,
  });

  final GalleryItem<PageUrl> item;
  final bool current;
  final bool bookmarked;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: colors.surfaceContainerHighest),
            _image(item.page, colors),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                color: current
                    ? colors.primary
                    : Colors.black.withValues(alpha: 0.55),
                child: Text(
                  current
                      ? '${item.pageNumber} · Current'
                      : '${item.pageNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: current ? colors.onPrimary : Colors.white,
                  ),
                ),
              ),
            ),
            if (bookmarked)
              Positioned(
                top: 0,
                right: 6,
                child: Icon(Icons.bookmark_rounded,
                    color: colors.primary, size: 26),
              ),
            if (current)
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.primary, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _image(PageUrl page, ColorScheme colors) {
    final url = page.url.trim();
    final error = Center(
        child: Icon(Icons.broken_image_outlined,
            color: colors.onSurface.withValues(alpha: 0.4)));
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        httpHeaders: getPageImageHeaders(page.headers),
        cacheManager: AnymeXCacheManager.instance,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        memCacheWidth: 360,
        fadeInDuration: const Duration(milliseconds: 150),
        placeholder: (_, __) => const Center(
            child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2))),
        errorWidget: (_, __, ___) => error,
      );
    }
    final path = url.startsWith('file://') ? Uri.parse(url).toFilePath() : url;
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      cacheWidth: 360,
      errorBuilder: (_, __, ___) => error,
    );
  }
}
