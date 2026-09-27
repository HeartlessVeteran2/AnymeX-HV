enum HvReadFilter { all, unread, read }

/// How one title's chapter list is filtered and ordered on its details page.
class HvChapterListPrefs {
  final HvReadFilter readFilter;
  final bool downloadedOnly;

  /// Newest chapter first instead of the source's oldest-first order.
  final bool newestFirst;

  const HvChapterListPrefs({
    this.readFilter = HvReadFilter.all,
    this.downloadedOnly = false,
    this.newestFirst = false,
  });

  bool get isDefault =>
      readFilter == HvReadFilter.all && !downloadedOnly && !newestFirst;

  HvChapterListPrefs copyWith({
    HvReadFilter? readFilter,
    bool? downloadedOnly,
    bool? newestFirst,
  }) =>
      HvChapterListPrefs(
        readFilter: readFilter ?? this.readFilter,
        downloadedOnly: downloadedOnly ?? this.downloadedOnly,
        newestFirst: newestFirst ?? this.newestFirst,
      );

  Map<String, dynamic> toJson() => {
        'read': readFilter.index,
        'downloaded': downloadedOnly,
        'newest': newestFirst,
      };

  factory HvChapterListPrefs.fromJson(Map<String, dynamic> json) {
    final read = json['read'];
    return HvChapterListPrefs(
      readFilter: read is int && read >= 0 && read < HvReadFilter.values.length
          ? HvReadFilter.values[read]
          : HvReadFilter.all,
      downloadedOnly: json['downloaded'] == true,
      newestFirst: json['newest'] == true,
    );
  }
}

/// Applies [prefs] to [chapters] (given in the source's order).
List<T> applyChapterPrefs<T>(
  List<T> chapters,
  HvChapterListPrefs prefs, {
  required bool Function(T) isRead,
  required bool Function(T) isDownloaded,
}) {
  if (prefs.isDefault) return chapters;
  final result = chapters.where((c) {
    if (prefs.downloadedOnly && !isDownloaded(c)) return false;
    return switch (prefs.readFilter) {
      HvReadFilter.all => true,
      HvReadFilter.unread => !isRead(c),
      HvReadFilter.read => isRead(c),
    };
  }).toList();
  return prefs.newestFirst ? result.reversed.toList() : result;
}
