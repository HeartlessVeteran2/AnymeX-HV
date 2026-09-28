import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/library_update/core/list_keys.dart';
import 'package:anymex/hv/library_update/core/update_filter.dart';
import 'package:anymex/main.dart' show isar;
import 'package:isar_community/isar.dart';

/// Library update settings, read from and written to the settings store.
class LibraryUpdateSettings {
  LibraryUpdateSettings._();

  static const List<int> intervalChoices = [0, 6, 12, 24, 48, 168];

  static int get autoHours => HvKeys.hvAutoUpdateHours.get<int>(24);
  static set autoHours(int v) => HvKeys.hvAutoUpdateHours.set(v);

  static bool get wifiOnly => HvKeys.hvUpdateWifiOnly.get<bool>(false);
  static set wifiOnly(bool v) => HvKeys.hvUpdateWifiOnly.set(v);

  static bool get skipUnread => HvKeys.hvUpdateSkipUnread.get<bool>(false);
  static set skipUnread(bool v) => HvKeys.hvUpdateSkipUnread.set(v);

  static bool get skipCompleted =>
      HvKeys.hvUpdateSkipCompleted.get<bool>(true);
  static set skipCompleted(bool v) => HvKeys.hvUpdateSkipCompleted.set(v);

  static bool get skipNotStarted =>
      HvKeys.hvUpdateSkipNotStarted.get<bool>(false);
  static set skipNotStarted(bool v) => HvKeys.hvUpdateSkipNotStarted.set(v);

  static Set<String> get includeLists =>
      HvKeys.hvUpdateIncludeLists.get<List<String>>(const []).toSet();
  static set includeLists(Set<String> v) =>
      HvKeys.hvUpdateIncludeLists.set(v.toList());

  static Set<String> get excludeLists =>
      HvKeys.hvUpdateExcludeLists.get<List<String>>(const []).toSet();
  static set excludeLists(Set<String> v) =>
      HvKeys.hvUpdateExcludeLists.set(v.toList());

  static bool get manga => HvKeys.hvUpdateManga.get<bool>(true);
  static set manga(bool v) => HvKeys.hvUpdateManga.set(v);

  static bool get novel => HvKeys.hvUpdateNovel.get<bool>(true);
  static set novel(bool v) => HvKeys.hvUpdateNovel.set(v);

  static bool get anime => HvKeys.hvUpdateAnime.get<bool>(false);
  static set anime(bool v) => HvKeys.hvUpdateAnime.set(v);

  static bool get notify => HvKeys.hvUpdateNotify.get<bool>(true);
  static set notify(bool v) => HvKeys.hvUpdateNotify.set(v);

  static bool get autoDownload => HvKeys.hvAutoDownloadNew.get<bool>(false);
  static set autoDownload(bool v) => HvKeys.hvAutoDownloadNew.set(v);

  static Set<String> get autoDownloadLists =>
      HvKeys.hvAutoDownloadLists.get<List<String>>(const []).toSet();
  static set autoDownloadLists(Set<String> v) =>
      HvKeys.hvAutoDownloadLists.set(v.toList());

  /// [autoDownloadLists] without lists that were deleted since. A deleted
  /// list left selected would match no title and stop every auto-download,
  /// while the settings screen (which only shows existing lists) shows none
  /// selected.
  static Set<String> get activeAutoDownloadLists =>
      hvPruneListKeys(autoDownloadLists, _existingListKeys());

  /// The skip rules for a run. Included lists that were deleted are
  /// dropped, so a deleted list can't leave the run checking nothing.
  static UpdateFilterSettings get filter => UpdateFilterSettings(
        skipWithUnread: skipUnread,
        skipCompleted: skipCompleted,
        skipNotStarted: skipNotStarted,
        includeLists: hvPruneListKeys(includeLists, _existingListKeys()),
        excludeLists: excludeLists,
      );

  /// Keeps the list choices pointing at a list after it's renamed.
  static void renameList(int typeIndex, String oldName, String newName) {
    final from = listKey(typeIndex, oldName), to = listKey(typeIndex, newName);
    includeLists = hvRenameListKey(includeLists, from, to);
    excludeLists = hvRenameListKey(excludeLists, from, to);
    autoDownloadLists = hvRenameListKey(autoDownloadLists, from, to);
  }

  static Set<String> _existingListKeys() => {
        for (final l in isar.customLists.where().findAllSync())
          if (l.listName != null) listKey(l.mediaTypeIndex, l.listName!),
      };
}
