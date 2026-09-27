/// Which library titles an update run checks (Mihon's "smart update"
/// restrictions plus list include/exclude).
class UpdateFilterSettings {
  final bool skipWithUnread;
  final bool skipCompleted;
  final bool skipNotStarted;

  /// List keys (`"<typeIndex>|<name>"`); empty means every list.
  final Set<String> includeLists;
  final Set<String> excludeLists;

  const UpdateFilterSettings({
    this.skipWithUnread = false,
    this.skipCompleted = false,
    this.skipNotStarted = false,
    this.includeLists = const {},
    this.excludeLists = const {},
  });
}

/// What the filter needs to know about one library title.
class UpdateCandidate {
  /// List keys (`"<typeIndex>|<name>"`) the title is in.
  final Set<String> lists;

  /// Chapters on the source that aren't read; null when unknown (never
  /// checked), which never causes a skip.
  final int? unreadCount;

  /// Publishing status as stored (AniList `FINISHED`, sources' free text...).
  final String? status;

  /// Whether any chapter was opened.
  final bool started;

  const UpdateCandidate({
    required this.lists,
    this.unreadCount,
    this.status,
    this.started = true,
  });
}

String listKey(int typeIndex, String listName) => '$typeIndex|$listName';

bool isCompletedStatus(String? status) {
  final s = (status ?? '').toLowerCase();
  return s.contains('finish') ||
      s.contains('complet') ||
      s == 'ended' ||
      s.contains('cancel');
}

/// Why [c] is skipped, or null when it should be checked. An excluded list
/// always wins over an included one.
String? updateSkipReason(UpdateCandidate c, UpdateFilterSettings s) {
  if (c.lists.any(s.excludeLists.contains)) return 'In an excluded list';
  if (s.includeLists.isNotEmpty && !c.lists.any(s.includeLists.contains)) {
    return 'Not in an included list';
  }
  if (s.skipCompleted && isCompletedStatus(c.status)) return 'Completed';
  if (s.skipNotStarted && !c.started) return 'Not started';
  if (s.skipWithUnread && (c.unreadCount ?? 0) > 0) return 'Has unread chapters';
  return null;
}

/// Whether an automatic run is due.
bool isAutoUpdateDue({
  required int intervalHours,
  required int lastRunAt,
  required int now,
}) {
  if (intervalHours <= 0) return false;
  return now - lastRunAt >= Duration(hours: intervalHours).inMilliseconds;
}
