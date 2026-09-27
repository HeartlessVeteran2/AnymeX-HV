/// Settings for the HV features, stored through `KvHelper` like every other
/// AnymeX setting (`HvKeys.x.get<T>(default)` / `.set(v)`).
///
/// The stored key is the enum value's `name`, so every name carries the `hv`
/// prefix to stay clear of upstream keys.
enum HvKeys {
  /// Epoch millis of the last finished library update run.
  hvLastUpdateRunAt,

  // Library updates
  /// Hours between automatic checks while the app is open; 0 = off.
  hvAutoUpdateHours,
  hvUpdateWifiOnly,
  hvUpdateSkipUnread,
  hvUpdateSkipCompleted,
  hvUpdateSkipNotStarted,

  /// Lists (`"<typeIndex>|<list name>"`) to limit updates to; empty = all.
  hvUpdateIncludeLists,

  /// Lists (`"<typeIndex>|<list name>"`) never updated.
  hvUpdateExcludeLists,
  hvUpdateManga,
  hvUpdateNovel,
  hvUpdateAnime,
  hvUpdateNotify,

  // Auto-download of new chapters
  hvAutoDownloadNew,

  /// Lists (`"<typeIndex>|<list name>"`) whose new chapters are downloaded;
  /// empty = whole library.
  hvAutoDownloadLists,
}
