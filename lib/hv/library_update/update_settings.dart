import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/library_update/core/update_filter.dart';

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

  static UpdateFilterSettings get filter => UpdateFilterSettings(
        skipWithUnread: skipUnread,
        skipCompleted: skipCompleted,
        skipNotStarted: skipNotStarted,
        includeLists: includeLists,
        excludeLists: excludeLists,
      );
}
