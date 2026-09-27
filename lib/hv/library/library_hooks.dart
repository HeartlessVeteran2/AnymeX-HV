import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/common/read_state.dart';
import 'package:anymex/hv/library/core/library_filter.dart';
import 'package:anymex/hv/library/core/library_search.dart';
import 'package:anymex/hv/library/selection/library_selection.dart';
import 'package:anymex/hv/library_update/core/update_filter.dart';
import 'package:anymex/hv/library_update/models/hv_chapter_update.dart';
import 'package:anymex/hv/library_update/update_settings.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';
import 'package:anymex/hv/source_link/source_link_repository.dart';
import 'package:anymex/main.dart' show isar;
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

/// Hooks for the library screen: search syntax, filters, grouping and
/// hidden lists.
class HvLibraryHooks {
  HvLibraryHooks._();

  static final Map<int, Rx<HvLibraryPrefs>> _prefs = {};

  /// Bumped when hidden lists change, so the library re-reads its lists.
  static final RxInt listsVersion = 0.obs;

  static Worker? _listsWorker;
  static Worker? _selectionWorker;

  /// Called from `LibraryController.onInit`: re-read the lists when hidden
  /// lists change, and drop a selection when the shown list changes.
  static void attach(void Function() rereadLists, RxInt selectedListIndex) {
    _listsWorker?.dispose();
    _selectionWorker?.dispose();
    _listsWorker = ever(listsVersion, (_) => rereadLists());
    _selectionWorker =
        ever(selectedListIndex, (_) => HvLibrarySelection.clear());
  }

  static Rx<HvLibraryPrefs> prefsFor(ItemType type) =>
      _prefs.putIfAbsent(type.index, () {
        final json = KvHelper.get<Map<String, dynamic>>(
            'hvLibraryPrefs_${type.index}',
            defaultVal: const {});
        return HvLibraryPrefs.fromJson(json).obs;
      });

  static void setPrefs(ItemType type, HvLibraryPrefs prefs) {
    prefsFor(type).value = prefs;
    KvHelper.set('hvLibraryPrefs_${type.index}', prefs.toJson());
  }

  // ---- hidden lists -------------------------------------------------------

  static Set<String> get hiddenLists =>
      HvKeys.hvHiddenLists.get<List<String>>(const []).toSet();

  static bool get showHidden => HvKeys.hvShowHiddenLists.get<bool>(false);

  static bool isHidden(ItemType type, String listName) =>
      hiddenLists.contains(listKey(type.index, listName));

  static void setHidden(ItemType type, String listName, bool hidden) {
    final set = hiddenLists;
    final key = listKey(type.index, listName);
    hidden ? set.add(key) : set.remove(key);
    HvKeys.hvHiddenLists.set(set.toList());
    listsVersion.value++;
  }

  static void setShowHidden(bool value) {
    HvKeys.hvShowHiddenLists.set(value);
    listsVersion.value++;
  }

  /// The lists the library shows as tabs.
  static List<CustomList> visibleLists(List<CustomList> lists, ItemType type) {
    if (showHidden) return lists;
    final hidden = hiddenLists;
    if (hidden.isEmpty) return lists;
    return lists
        .where((l) => !hidden.contains(listKey(type.index, l.listName ?? '')))
        .toList();
  }

  /// Keeps a hidden list hidden, and the update and auto-download list
  /// choices pointing at it, after it's renamed.
  static void onListRenamed(ItemType type, String oldName, String newName) {
    LibraryUpdateSettings.renameList(type.index, oldName, newName);
    final set = hiddenLists;
    if (set.remove(listKey(type.index, oldName))) {
      set.add(listKey(type.index, newName));
      HvKeys.hvHiddenLists.set(set.toList());
    }
  }

  // ---- search + filters ---------------------------------------------------

  /// Search (with the extended syntax) and filters for the shown items.
  static List<OfflineMedia> process(
    List<OfflineMedia> raw,
    String query,
    ItemType type,
  ) {
    final prefs = prefsFor(type).value; // subscribes the caller's Obx
    var items = raw;

    final parsed = LibrarySearchQuery.parse(query);
    Map<String, HvSourceLink>? links;
    Map<String, HvSourceLink> linksOf() =>
        links ??= {for (final l in SourceLinkRepository.ofType(type.index)) l.mediaId: l};

    if (!parsed.isEmpty) {
      items = items
          .where((m) => parsed.matches(LibrarySearchFields(
                titles: [
                  for (final t in [m.name, m.english, m.jname, m.japanese])
                    if (t != null && t.isNotEmpty) t,
                ],
                source: sourceNameOf(m, linksOf()[m.mediaId]),
                status: m.status,
                genres: m.genres ?? const [],
              )))
          .toList();
    }

    if (prefs.hasFilters) {
      final updated = prefs.updates == HvTriState.off
          ? const <String>{}
          : _titlesWithUpdates(type);
      items = items
          .where((m) => passesLibraryFilters(
                facts(m, type, linksOf()[m.mediaId], updated),
                prefs,
              ))
          .toList();
    }
    return items;
  }

  static Set<String> _titlesWithUpdates(ItemType type) => {
        for (final u in isar.hvChapterUpdates
            .filter()
            .dismissedEqualTo(false)
            .mediaTypeIndexEqualTo(type.index)
            .findAllSync())
          u.mediaKey,
      };

  static String? sourceNameOf(OfflineMedia m, HvSourceLink? link) =>
      link?.sourceName ??
      m.currentChapter?.sourceName ??
      m.currentEpisode?.source;

  static HvLibraryFacts facts(OfflineMedia m, ItemType type, HvSourceLink? link,
      Set<String> titlesWithUpdates) {
    final isAnime = type == ItemType.anime;
    final started = isAnime
        ? (m.watchedEpisodes ?? const []).isNotEmpty ||
            m.currentEpisode != null
        : (m.readChapters ?? const []).isNotEmpty;
    var unread = 0;
    if (!isAnime && link != null && link.knownChapterKeys.isNotEmpty) {
      final read = (m.readChapters ?? const [])
          .where((c) => hvIsPageComplete(c.pageNumber, c.totalPages))
          .length;
      unread = link.knownChapterKeys.length - read;
    }
    return HvLibraryFacts(
      unreadCount: unread < 0 ? 0 : unread,
      started: started,
      completed: isCompletedStatus(m.status),
      hasUpdates:
          titlesWithUpdates.contains(hvMediaKey(type.index, m.mediaId ?? '')),
    );
  }

  // ---- grouping -----------------------------------------------------------

  static HvLibraryGroupBy groupBy(ItemType type) => prefsFor(type).value.groupBy;

  static List<HvLibraryGroup<OfflineMedia>> group(
      List<OfflineMedia> items, ItemType type) {
    final by = groupBy(type);
    switch (by) {
      case HvLibraryGroupBy.none:
        return [HvLibraryGroup('', items)];
      case HvLibraryGroupBy.status:
        return groupLibrary(items,
            keyOf: (m) => _prettyStatus(m.status),
            order: const [
              'Releasing',
              'Not yet released',
              'Hiatus',
              'Finished',
              'Cancelled',
            ]);
      case HvLibraryGroupBy.source:
        final links = {
          for (final l in SourceLinkRepository.ofType(type.index)) l.mediaId: l
        };
        return groupLibrary(items,
            keyOf: (m) => sourceNameOf(m, links[m.mediaId]),
            unknownLabel: 'No source');
      case HvLibraryGroupBy.trackerStatus:
        final handler = Get.find<ServiceHandler>();
        final tracked = type == ItemType.anime
            ? handler.animeList
            : handler.mangaList;
        final statusById = {
          for (final t in tracked)
            if (t.id != null) t.id!: normalizeTrackerStatus(t.watchingStatus),
        };
        final groups = groupLibrary(items,
            keyOf: (m) => statusById[m.mediaId],
            unknownLabel: 'Not on your list',
            order: kTrackerStatusOrder);
        return [
          for (final g in groups)
            HvLibraryGroup(trackerStatusLabel(g.label, type), g.items),
        ];
    }
  }

  static String trackerStatusLabel(String status, ItemType type) {
    final anime = type == ItemType.anime;
    return switch (status) {
      'CURRENT' => anime ? 'Watching' : 'Reading',
      'REPEATING' => anime ? 'Rewatching' : 'Rereading',
      'PLANNING' => 'Planning',
      'PAUSED' => 'Paused',
      'COMPLETED' => 'Completed',
      'DROPPED' => 'Dropped',
      _ => status,
    };
  }

  static String? _prettyStatus(String? status) {
    final s = (status ?? '').trim();
    if (s.isEmpty || s.startsWith('?')) return null;
    final upper = s.toUpperCase().replaceAll(' ', '_');
    return switch (upper) {
      'RELEASING' || 'ONGOING' || 'CURRENTLY_AIRING' || 'PUBLISHING' =>
        'Releasing',
      'NOT_YET_RELEASED' || 'NOT_YET_AIRED' || 'UPCOMING' => 'Not yet released',
      'HIATUS' || 'ON_HIATUS' => 'Hiatus',
      'FINISHED' || 'COMPLETED' || 'FINISHED_AIRING' || 'ENDED' => 'Finished',
      'CANCELLED' || 'DISCONTINUED' => 'Cancelled',
      _ => s[0].toUpperCase() + s.substring(1).toLowerCase(),
    };
  }
}
