import 'dart:io';

import 'package:anymex/controllers/services/storage/anymex_cache_manager.dart';
import 'package:anymex/hv/bookmarks/bookmark_repository.dart';
import 'package:anymex/hv/bookmarks/models/hv_bookmark_collection.dart';
import 'package:anymex/hv/bookmarks/models/hv_page_bookmark.dart';
import 'package:anymex/hv/reader/hv_reader_launcher.dart';
import 'package:anymex/hv/reader/reader_hooks.dart';
import 'package:anymex/utils/extension_utils.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Every bookmarked page, grouped by title and chapter, filterable by
/// collection. Tap to open the reader at that page.
class HvBookmarksScreen extends StatefulWidget {
  const HvBookmarksScreen({super.key, this.mediaKey, this.title});

  /// Limit to one title.
  final String? mediaKey;
  final String? title;

  @override
  State<HvBookmarksScreen> createState() => _HvBookmarksScreenState();
}

class _HvBookmarksScreenState extends State<HvBookmarksScreen> {
  final Set<int> _selected = {};

  /// null = all, -1 = not in a collection, otherwise a collection id.
  int? _collection;

  late final Stream<List<HvPageBookmark>> _bookmarks =
      BookmarkRepository.watchAll();
  late final Stream<List<HvBookmarkCollection>> _collections =
      BookmarkRepository.watchCollections();

  bool get _selecting => _selected.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HvBookmarkCollection>>(
      stream: _collections,
      builder: (context, collectionsSnap) {
        final collections = collectionsSnap.data ?? const [];
        return StreamBuilder<List<HvPageBookmark>>(
          stream: _bookmarks,
          builder: (context, snap) {
            final all = (snap.data ?? const <HvPageBookmark>[])
                .where((b) =>
                    widget.mediaKey == null || b.mediaKey == widget.mediaKey)
                .toList();
            _selected.retainAll(all.map((b) => b.id));
            final shown = all.where((b) {
              if (_collection == null) return true;
              if (_collection == -1) return b.collectionId == null;
              return b.collectionId == _collection;
            }).toList();
            return Scaffold(
              appBar: _appBar(context, collections, shown),
              body: Column(
                children: [
                  _CollectionChips(
                    collections: collections,
                    selected: _collection,
                    onSelected: (id) => setState(() => _collection = id),
                  ),
                  Expanded(
                    child: shown.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                'No bookmarks yet. In the reader, tap the '
                                'bookmark button, or long-press a page in '
                                'the page gallery.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : _list(context, shown, collections),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context,
      List<HvBookmarkCollection> collections, List<HvPageBookmark> shown) {
    if (_selecting) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => setState(_selected.clear),
        ),
        title: Text('${_selected.length} selected'),
        actions: [
          IconButton(
            tooltip: 'Select all',
            icon: const Icon(Icons.select_all_rounded),
            onPressed: () =>
                setState(() => _selected.addAll(shown.map((b) => b.id))),
          ),
          IconButton(
            tooltip: 'Move to collection',
            icon: const Icon(Icons.folder_open_outlined),
            onPressed: () => _moveToCollection(context, _selected.toList()),
          ),
          IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              await BookmarkRepository.delete(_selected.toList());
              setState(_selected.clear);
            },
          ),
        ],
      );
    }
    return AppBar(
      title: Text(widget.title == null ? 'Bookmarks' : 'Bookmarks · ${widget.title}'),
      actions: [
        IconButton(
          tooltip: 'New collection',
          icon: const Icon(Icons.create_new_folder_outlined),
          onPressed: () => _newCollection(context),
        ),
      ],
    );
  }

  Widget _list(BuildContext context, List<HvPageBookmark> bookmarks,
      List<HvBookmarkCollection> collections) {
    // Group by title, then chapter, keeping newest-first order of titles.
    final byTitle = <String, List<HvPageBookmark>>{};
    for (final b in bookmarks) {
      byTitle.putIfAbsent(b.mediaKey, () => []).add(b);
    }
    final colors = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        for (final entry in byTitle.entries) ...[
          if (widget.mediaKey == null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(entry.value.first.mediaTitle ?? '?',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: colors.primary)),
            ),
          for (final b in (entry.value
            ..sort((x, y) {
              final c = (x.chapterNumber ?? 0).compareTo(y.chapterNumber ?? 0);
              return c != 0 ? c : x.pageNumber.compareTo(y.pageNumber);
            })))
            _BookmarkTile(
              bookmark: b,
              collectionName: collections
                  .where((c) => c.id == b.collectionId)
                  .map((c) => c.name)
                  .firstOrNull,
              selected: _selected.contains(b.id),
              onTap: _selecting ? () => _toggle(b) : () => _open(b),
              onLongPress: () => _toggle(b),
              onMenu: (action) => _onMenu(context, action, b),
            ),
        ],
      ],
    );
  }

  void _toggle(HvPageBookmark b) => setState(() {
        if (!_selected.remove(b.id)) _selected.add(b.id);
      });

  Future<void> _open(HvPageBookmark b) async {
    HvReaderHooks.openAtPage(b.chapterKey, b.pageNumber);
    await HvReaderLauncher.openChapter(
      mediaId: b.mediaId,
      mediaTypeIndex: b.mediaTypeIndex,
      chapterLink: b.chapterKey,
      chapterNumber: b.chapterNumber,
      fallbackTitle: b.mediaTitle,
      fallbackPoster: b.poster,
    );
  }

  Future<void> _onMenu(
      BuildContext context, String action, HvPageBookmark b) async {
    switch (action) {
      case 'note':
        final controller = TextEditingController(text: b.note ?? '');
        final text = await showDialog<String>(
          context: context,
          builder: (dialog) => AlertDialog(
            title: const Text('Note'),
            content: TextField(
                controller: controller, maxLines: 4, autofocus: true),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(dialog),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(dialog, controller.text),
                  child: const Text('Save')),
            ],
          ),
        );
        controller.dispose();
        if (text != null) await BookmarkRepository.setNote(b.id, text);
      case 'collection':
        if (context.mounted) await _moveToCollection(context, [b.id]);
      case 'share':
        await _share(b);
      case 'delete':
        await BookmarkRepository.delete([b.id]);
    }
  }

  Future<void> _moveToCollection(BuildContext context, List<int> ids) async {
    final collections =
        await BookmarkRepository.watchCollections().first;
    if (!context.mounted) return;
    final choice = await showDialog<int>(
      context: context,
      builder: (dialog) => SimpleDialog(
        title: const Text('Move to collection'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(dialog, -1),
            child: const Text('No collection'),
          ),
          for (final c in collections)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(dialog, c.id),
              child: Text(c.name),
            ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(dialog, -2),
            child: const Text('New collection…'),
          ),
        ],
      ),
    );
    if (choice == null) return;
    int? target = choice == -1 ? null : choice;
    if (choice == -2) {
      if (!context.mounted) return;
      final created = await _newCollection(context);
      if (created == null) return;
      target = created.id;
    }
    await BookmarkRepository.setCollection(ids, target);
    setState(_selected.clear);
  }

  Future<HvBookmarkCollection?> _newCollection(BuildContext context) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (dialog) => AlertDialog(
        title: const Text('New collection'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialog),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(dialog, controller.text),
              child: const Text('Create')),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.trim().isEmpty) return null;
    return BookmarkRepository.createCollection(name);
  }

  Future<void> _share(HvPageBookmark b) async {
    final url = b.pageUrl ?? '';
    if (url.isEmpty) {
      snackBar('No image saved for this bookmark');
      return;
    }
    try {
      final File file = url.startsWith('http')
          ? await AnymeXCacheManager.instance
              .getSingleFile(url, headers: getPageImageHeaders(b.headers))
          : File(url);
      await Share.shareXFiles([XFile(file.path)],
          text: '${b.mediaTitle ?? ''} · page ${b.pageNumber}');
    } catch (e) {
      Logger.e('HV: sharing bookmark failed: $e');
      snackBar('Couldn\'t share this page');
    }
  }
}

class _CollectionChips extends StatelessWidget {
  const _CollectionChips({
    required this.collections,
    required this.selected,
    required this.onSelected,
  });

  final List<HvBookmarkCollection> collections;
  final int? selected;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    if (collections.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _chip('All', null),
          _chip('No collection', -1),
          for (final c in collections)
            GestureDetector(
              onLongPress: () => _confirmDelete(context, c),
              child: _chip(c.name, c.id),
            ),
        ],
      ),
    );
  }

  Widget _chip(String label, int? id) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(label),
          selected: selected == id,
          onSelected: (_) => onSelected(id),
        ),
      );

  Future<void> _confirmDelete(
      BuildContext context, HvBookmarkCollection c) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialog) => AlertDialog(
        title: Text('Delete "${c.name}"?'),
        content: const Text('The bookmarks in it are kept.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialog, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(dialog, true),
              child: const Text('Delete')),
        ],
      ),
    );
    if (ok == true) {
      await BookmarkRepository.deleteCollection(c.id);
      if (selected == c.id) onSelected(null);
    }
  }
}

class _BookmarkTile extends StatelessWidget {
  const _BookmarkTile({
    required this.bookmark,
    required this.collectionName,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
    required this.onMenu,
  });

  final HvPageBookmark bookmark;
  final String? collectionName;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueChanged<String> onMenu;

  @override
  Widget build(BuildContext context) {
    final b = bookmark;
    final colors = Theme.of(context).colorScheme;
    final chapter = b.chapterNumber != null
        ? 'Chapter ${b.chapterNumber! % 1 == 0 ? b.chapterNumber!.toInt() : b.chapterNumber}'
        : (b.chapterTitle ?? 'Chapter');
    return ListTile(
      selected: selected,
      selectedTileColor: colors.primaryContainer.withValues(alpha: 0.4),
      onTap: onTap,
      onLongPress: onLongPress,
      leading: SizedBox(
        width: 44,
        height: 64,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: HvPageThumb(url: b.pageUrl, headers: b.headers),
        ),
      ),
      title: Text('$chapter · page ${b.pageNumber}',
          maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        [
          if ((b.note ?? '').isNotEmpty) b.note!,
          if (collectionName != null) collectionName!,
        ].join(' · '),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: selected
          ? Icon(Icons.check_circle, color: colors.primary)
          : PopupMenuButton<String>(
              onSelected: onMenu,
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'note', child: Text('Edit note')),
                PopupMenuItem(
                    value: 'collection', child: Text('Move to collection')),
                PopupMenuItem(value: 'share', child: Text('Share image')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
    );
  }
}

/// A page image from the web (through the reader's cache) or from disk.
class HvPageThumb extends StatelessWidget {
  const HvPageThumb({super.key, required this.url, this.headers});

  final String? url;
  final Map<String, String>? headers;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final value = (url ?? '').trim();
    final placeholder = ColoredBox(
      color: colors.surfaceContainerHighest,
      child: Icon(Icons.image_outlined,
          color: colors.onSurface.withValues(alpha: 0.4)),
    );
    if (value.isEmpty) return placeholder;
    if (value.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: value,
        httpHeaders: getPageImageHeaders(headers),
        cacheManager: AnymeXCacheManager.instance,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        memCacheWidth: 240,
        placeholder: (_, __) => placeholder,
        errorWidget: (_, __, ___) => placeholder,
      );
    }
    final path =
        value.startsWith('file://') ? Uri.parse(value).toFilePath() : value;
    return Image.file(File(path),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        cacheWidth: 240,
        errorBuilder: (_, __, ___) => placeholder);
  }
}
