/// Updates of one title found on one day.
class UpdateTitleGroup<T> {
  final String mediaKey;
  final List<T> items;
  UpdateTitleGroup(this.mediaKey, this.items);
}

/// All updates found on one calendar day (local time), titles in order of
/// their newest update.
class UpdateDayGroup<T> {
  final DateTime day;
  final List<UpdateTitleGroup<T>> titles;
  UpdateDayGroup(this.day, this.titles);
}

/// Groups updates by day and then by title, newest first — the layout of
/// Komikku's Updates tab.
List<UpdateDayGroup<T>> groupUpdates<T>(
  List<T> items, {
  required int Function(T) foundAt,
  required String Function(T) mediaKey,
  double? Function(T)? chapterNumber,
}) {
  final sorted = [...items]..sort((a, b) => foundAt(b).compareTo(foundAt(a)));
  final days = <UpdateDayGroup<T>>[];
  for (final item in sorted) {
    final time = DateTime.fromMillisecondsSinceEpoch(foundAt(item));
    final day = DateTime(time.year, time.month, time.day);
    if (days.isEmpty || days.last.day != day) {
      days.add(UpdateDayGroup<T>(day, []));
    }
    final titles = days.last.titles;
    final key = mediaKey(item);
    final group = titles.where((g) => g.mediaKey == key).firstOrNull;
    if (group == null) {
      titles.add(UpdateTitleGroup<T>(key, [item]));
    } else {
      group.items.add(item);
    }
  }
  if (chapterNumber != null) {
    for (final day in days) {
      for (final title in day.titles) {
        title.items.sort((a, b) =>
            (chapterNumber(b) ?? -1).compareTo(chapterNumber(a) ?? -1));
      }
    }
  }
  return days;
}
