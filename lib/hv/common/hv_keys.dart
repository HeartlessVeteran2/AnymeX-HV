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

  // Library
  /// Hidden lists (`"<typeIndex>|<list name>"`).
  hvHiddenLists,
  hvShowHiddenLists,

  // Reader
  /// Columns in the reader's page gallery (2–4).
  hvGalleryColumns,

  // Downloads while reading
  hvDeleteAfterRead,

  /// Read chapters to keep downloaded before deleting (0 = delete the
  /// chapter just finished).
  hvDeleteAfterReadKeep,

  /// Chapters to download ahead while reading; 0 = off.
  hvDownloadAhead,
  hvDownloadAheadWifiOnly,
}
