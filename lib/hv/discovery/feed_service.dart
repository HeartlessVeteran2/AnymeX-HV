import 'package:anymex/controllers/offline/offline_storage_controller.dart';
import 'package:anymex/controllers/source/source_controller.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/discovery/core/feed_rows.dart';
import 'package:anymex/hv/source_link/details_hooks.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/screens/anime/details_page.dart';
import 'package:anymex/screens/manga/details_page.dart';
import 'package:anymex/screens/novel/details/details_view.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:get/get.dart';

/// Feed rows (Komikku's Feed / saved searches) and what they show.
class HvFeed {
  HvFeed._();

  static final RxList<FeedRow> rows = <FeedRow>[].obs;
  static final Map<String, Future<List<DMedia>>> _cache = {};
  static bool _loaded = false;

  static void ensureLoaded() {
    if (_loaded) return;
    _loaded = true;
    rows.assignAll(decodeFeedRows(KvHelper.get<List<dynamic>>(
        HvKeys.hvFeedRows.name,
        defaultVal: const [])));
  }

  static void _save() =>
      HvKeys.hvFeedRows.set([for (final r in rows) r.toJson()]);

  static void add(FeedRow row) {
    ensureLoaded();
    rows.assignAll(addFeedRow(rows, row));
    _save();
  }

  static void remove(String id) {
    rows.removeWhere((r) => r.id == id);
    _cache.remove(id);
    _save();
  }

  static void move(String id, int delta) {
    rows.assignAll(moveFeedRow(rows, id, delta));
    _save();
  }

  static Source? sourceOf(FeedRow row) => Get.find<SourceController>()
      .findSourceById(row.sourceId, ItemType.values[row.typeIndex]);

  /// Titles for a row: the saved search, or the source's latest updates
  /// (popular when it has no "latest"). Cached for the session.
  static Future<List<DMedia>> load(FeedRow row, {bool refresh = false}) {
    if (refresh) _cache.remove(row.id);
    return _cache.putIfAbsent(row.id, () async {
      final source = sourceOf(row);
      if (source == null) {
        throw Exception('${row.sourceName} is not installed');
      }
      if (row.isSearch) {
        return (await source.methods.search(row.query!.trim(), 1, [])).list;
      }
      if (source.supportsLatest != false) {
        try {
          final latest = (await source.methods.getLatestUpdates(1)).list;
          if (latest.isNotEmpty) return latest;
        } catch (_) {}
      }
      return (await source.methods.getPopular(1)).list;
    });
  }

  static Media toMedia(DMedia item, Source source, ItemType type) =>
      Media.froDMedia(item, type)..sourceId = source.id;

  /// Opens a feed title's details page on its source.
  static void open(DMedia item, Source source, ItemType type) {
    final media = toMedia(item, source, type);
    Get.find<SourceController>().setActiveSource(source);
    final tag = 'hv-feed-${source.id}-${item.url}';
    switch (type) {
      case ItemType.manga:
        navigate(() => MangaDetailsPage(media: media, tag: tag));
      case ItemType.anime:
        navigate(() => AnimeDetailsPage(media: media, tag: tag));
      case ItemType.novel:
        navigate(
            () => NovelDetailsPage(media: media, tag: tag, source: source));
    }
  }

  /// Adds titles to a library list and links each to its source, so the
  /// update checker can follow them right away.
  static Future<void> addToList(
      String listName, List<(DMedia, Source)> items, ItemType type) async {
    final storage = Get.find<OfflineStorageController>();
    for (final (item, source) in items) {
      final media = toMedia(item, source, type);
      if (media.id.isEmpty) continue;
      await storage.addMedia(listName, media);
      await HvDetailsHooks.onDetailFetched(
          media: media, source: source, mapped: media, userConfirmed: true);
    }
  }
}
