import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/controllers/source/source_controller.dart';
import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/discovery/core/feed_rows.dart';
import 'package:anymex/hv/discovery/core/rec_ranking.dart';
import 'package:anymex/hv/discovery/feed_service.dart';
import 'package:anymex/hv/discovery/recommendations_service.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/main.dart' show isar;
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/screens/anime/details_page.dart';
import 'package:anymex/screens/manga/details_page.dart';
import 'package:anymex/screens/search/source_search_page.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_image.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

String _typeLabel(ItemType t) => switch (t) {
      ItemType.manga => 'Manga',
      ItemType.anime => 'Anime',
      ItemType.novel => 'Novel',
    };

/// Discover: a Feed of your sources' latest titles and saved searches, and
/// recommendations drawn from your whole library.
class HvDiscoverScreen extends StatelessWidget {
  const HvDiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Discover'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Feed'),
            Tab(text: 'For your library'),
          ]),
        ),
        body: const TabBarView(children: [
          _FeedTab(),
          _RecommendedTab(),
        ]),
      ),
    );
  }
}

// ---- Feed -----------------------------------------------------------------

class _Selected {
  final DMedia item;
  final Source source;
  final ItemType type;
  const _Selected(this.item, this.source, this.type);
}

class _FeedTab extends StatefulWidget {
  const _FeedTab();

  @override
  State<_FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<_FeedTab> {
  final RxMap<String, _Selected> _selected = <String, _Selected>{}.obs;
  bool _hideLibrary = HvKeys.hvFeedHideLibrary.get<bool>(false);

  @override
  void initState() {
    super.initState();
    HvFeed.ensureLoaded();
  }

  String _key(ItemType type, Source source, DMedia item) =>
      '${type.index}|${source.id}|${item.url}';

  void _toggle(ItemType type, Source source, DMedia item) {
    // One media type at a time, since lists belong to a type.
    if (_selected.isNotEmpty && _selected.values.first.type != type) {
      _selected.clear();
    }
    final key = _key(type, source, item);
    if (_selected.remove(key) == null) {
      _selected[key] = _Selected(item, source, type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          final rows = HvFeed.rows.toList();
          return ListView(
            padding: const EdgeInsets.only(bottom: 140),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Row(
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: () => _addRow(context),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Add row'),
                    ),
                    const Spacer(),
                    const Text('Hide library titles'),
                    Switch(
                      value: _hideLibrary,
                      onChanged: (v) {
                        HvKeys.hvFeedHideLibrary.set(v);
                        setState(() => _hideLibrary = v);
                      },
                    ),
                  ],
                ),
              ),
              if (rows.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'Add a row to follow a source\'s latest titles or save a '
                    'search on it. Long-press covers to add several to a list.',
                    textAlign: TextAlign.center,
                  ),
                ),
              for (final row in rows)
                _FeedRowView(
                  key: ValueKey(row.id),
                  row: row,
                  hideLibrary: _hideLibrary,
                  selected: _selected,
                  onTap: (source, item) {
                    final type = ItemType.values[row.typeIndex];
                    if (_selected.isNotEmpty) {
                      _toggle(type, source, item);
                    } else {
                      HvFeed.open(item, source, type);
                    }
                  },
                  onLongPress: (source, item) => _toggle(
                      ItemType.values[row.typeIndex], source, item),
                ),
            ],
          );
        }),
        Positioned(
          left: 12,
          right: 12,
          bottom: MediaQuery.paddingOf(context).bottom + 16,
          child: Obx(() {
            if (_selected.isEmpty) return const SizedBox.shrink();
            return Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: _selected.clear,
                  ),
                  Expanded(child: Text('${_selected.length} selected')),
                  TextButton.icon(
                    onPressed: () => _addSelected(context),
                    icon: const Icon(Icons.playlist_add_rounded),
                    label: const Text('Add to list'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Future<void> _addSelected(BuildContext context) async {
    final items = _selected.values.toList();
    if (items.isEmpty) return;
    final type = items.first.type;
    final names = isar.customLists
        .filter()
        .mediaTypeIndexEqualTo(type.index)
        .findAllSync()
        .map((l) => l.listName ?? '')
        .where((n) => n.isNotEmpty)
        .toList();
    if (names.isEmpty) {
      snackBar('Create a ${_typeLabel(type).toLowerCase()} list first');
      return;
    }
    final list = await showDialog<String>(
      context: context,
      builder: (dialog) => SimpleDialog(
        title: const Text('Add to list'),
        children: [
          for (final n in names)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(dialog, n),
              child: Text(n),
            ),
        ],
      ),
    );
    if (list == null) return;
    await HvFeed.addToList(
        list, [for (final s in items) (s.item, s.source)], type);
    _selected.clear();
    snackBar('Added ${items.length} to "$list"');
  }

  Future<void> _addRow(BuildContext context) async {
    final sources = Get.find<SourceController>();
    var type = ItemType.manga;
    Source? source;
    final query = TextEditingController();
    List<Source> installed(ItemType t) => switch (t) {
          ItemType.manga => sources.installedMangaExtensions,
          ItemType.anime => sources.installedExtensions,
          ItemType.novel => sources.installedNovelExtensions,
        };
    final row = await showDialog<FeedRow>(
      context: context,
      builder: (dialog) => StatefulBuilder(
        builder: (context, setDialog) {
          final options = installed(type);
          return AlertDialog(
            title: const Text('Add feed row'),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SegmentedButton<ItemType>(
                    segments: [
                      for (final t in [
                        ItemType.manga,
                        ItemType.anime,
                        ItemType.novel
                      ])
                        ButtonSegment(value: t, label: Text(_typeLabel(t))),
                    ],
                    selected: {type},
                    onSelectionChanged: (s) => setDialog(() {
                      type = s.first;
                      source = null;
                    }),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<Source>(
                    initialValue: source,
                    isExpanded: true,
                    hint: Text(options.isEmpty
                        ? 'No ${_typeLabel(type).toLowerCase()} extensions'
                        : 'Source'),
                    items: [
                      for (final s in options)
                        DropdownMenuItem(
                          value: s,
                          child: Text(
                              '${s.name ?? s.id}${(s.lang ?? '').isEmpty ? '' : ' (${s.lang})'}',
                              overflow: TextOverflow.ellipsis),
                        ),
                    ],
                    onChanged: (s) => setDialog(() => source = s),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: query,
                    decoration: const InputDecoration(
                      labelText: 'Saved search (optional)',
                      helperText: 'Leave empty for the source\'s latest titles',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialog),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: source == null
                    ? null
                    : () => Navigator.pop(
                          dialog,
                          FeedRow(
                            id: DateTime.now().microsecondsSinceEpoch.toString(),
                            typeIndex: type.index,
                            sourceId: source!.id ?? '',
                            sourceName: source!.name ?? source!.id ?? '?',
                            query: query.text,
                          ),
                        ),
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
    query.dispose();
    if (row != null && row.sourceId.isNotEmpty) HvFeed.add(row);
  }
}

class _FeedRowView extends StatefulWidget {
  const _FeedRowView({
    super.key,
    required this.row,
    required this.hideLibrary,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
  });

  final FeedRow row;
  final bool hideLibrary;
  final RxMap<String, _Selected> selected;
  final void Function(Source, DMedia) onTap;
  final void Function(Source, DMedia) onLongPress;

  @override
  State<_FeedRowView> createState() => _FeedRowViewState();
}

class _FeedRowViewState extends State<_FeedRowView> {
  late Future<List<DMedia>> _future = HvFeed.load(widget.row);

  ItemType get _type => ItemType.values[widget.row.typeIndex];

  @override
  Widget build(BuildContext context) {
    final row = widget.row;
    final source = HvFeed.sourceOf(row);
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 4, 4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(row.sourceName,
                        style: Theme.of(context).textTheme.titleSmall),
                    Text(
                      '${_typeLabel(_type)} · ${row.isSearch ? 'Search: "${row.query!.trim()}"' : 'Latest'}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (source != null)
                IconButton(
                  tooltip: 'See all',
                  icon: const Icon(Icons.arrow_forward_rounded),
                  onPressed: () => navigate(() => SourceSearchPage(
                        initialTerm: row.query ?? '',
                        type: _type,
                        source: source,
                      )),
                ),
              PopupMenuButton<String>(
                onSelected: (action) {
                  switch (action) {
                    case 'refresh':
                      setState(() =>
                          _future = HvFeed.load(widget.row, refresh: true));
                    case 'up':
                      HvFeed.move(row.id, -1);
                    case 'down':
                      HvFeed.move(row.id, 1);
                    case 'remove':
                      HvFeed.remove(row.id);
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'refresh', child: Text('Refresh')),
                  PopupMenuItem(value: 'up', child: Text('Move up')),
                  PopupMenuItem(value: 'down', child: Text('Move down')),
                  PopupMenuItem(value: 'remove', child: Text('Remove row')),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 210,
          child: FutureBuilder<List<DMedia>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || source == null) {
                return Center(
                  child: TextButton.icon(
                    onPressed: () => setState(() =>
                        _future = HvFeed.load(widget.row, refresh: true)),
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(source == null
                        ? '${row.sourceName} is not installed'
                        : 'Couldn\'t load — tap to retry'),
                  ),
                );
              }
              final library = widget.hideLibrary
                  ? LibraryMembership.idsOfType(widget.row.typeIndex)
                  : const <String>{};
              final items = snapshot.data!
                  .where((m) => !library.contains(m.url))
                  .toList();
              if (items.isEmpty) {
                return const Center(child: Text('Nothing here'));
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final item = items[i];
                  final key =
                      '${widget.row.typeIndex}|${source.id}|${item.url}';
                  return Obx(() => _Cover(
                        title: item.title ?? '?',
                        image: item.cover ?? '',
                        selected: widget.selected.containsKey(key),
                        onTap: () => widget.onTap(source, item),
                        onLongPress: () => widget.onLongPress(source, item),
                      ));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({
    required this.title,
    required this.image,
    required this.onTap,
    this.onLongPress,
    this.selected = false,
    this.subtitle,
  });

  final String title;
  final String image;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: 112,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                image.isEmpty
                    ? Container(
                        width: 112,
                        height: 158,
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image_outlined),
                      )
                    : AnymeXImage(
                        imageUrl: image, width: 112, height: 158, radius: 8),
                if (selected)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.3),
                        border: Border.all(color: colors.primary, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child:
                              Icon(Icons.check_circle, color: colors.primary),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall),
            if (subtitle != null)
              Text(subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: colors.primary)),
          ],
        ),
      ),
    );
  }
}

// ---- Recommended ----------------------------------------------------------

class _RecommendedTab extends StatefulWidget {
  const _RecommendedTab();

  @override
  State<_RecommendedTab> createState() => _RecommendedTabState();
}

class _RecommendedTabState extends State<_RecommendedTab> {
  ItemType _type = ItemType.manga;
  late Future<List<RankedRec>> _future = HvRecommendations.load(_type);

  void _reload({bool refresh = false}) => setState(
      () => _future = HvRecommendations.load(_type, refresh: refresh));

  void _open(RankedRec r) {
    final media = Media(
      id: '${r.mediaId}',
      idMal: '${r.idMal ?? 0}',
      title: r.title,
      poster: r.cover ?? '',
      mediaType: _type,
      serviceType: ServicesType.anilist,
    );
    final tag = 'hv-rec-${r.mediaId}';
    if (_type == ItemType.anime) {
      navigate(() => AnimeDetailsPage(media: media, tag: tag));
    } else {
      navigate(() => MangaDetailsPage(media: media, tag: tag));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 4, 4),
          child: Row(
            children: [
              SegmentedButton<ItemType>(
                segments: const [
                  ButtonSegment(value: ItemType.manga, label: Text('Manga')),
                  ButtonSegment(value: ItemType.anime, label: Text('Anime')),
                ],
                selected: {_type},
                onSelectionChanged: (s) {
                  _type = s.first;
                  _reload();
                },
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Refresh',
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () => _reload(refresh: true),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<RankedRec>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${snapshot.error}'
                              .replaceFirst('Exception: ', ''),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        FilledButton.tonal(
                          onPressed: () => _reload(refresh: true),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              final recs = snapshot.data ?? const <RankedRec>[];
              if (recs.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'No recommendations yet. They come from AniList for the '
                      'titles in your library lists.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 120),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 130,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                ),
                itemCount: recs.length,
                itemBuilder: (context, i) {
                  final r = recs[i];
                  return Tooltip(
                    message: 'Because you like ${r.because.take(3).join(', ')}',
                    child: _Cover(
                      title: r.title,
                      image: r.cover ?? '',
                      subtitle: r.count > 1
                          ? '${r.count} of your titles'
                          : 'From ${r.because.first}',
                      onTap: () => _open(r),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
