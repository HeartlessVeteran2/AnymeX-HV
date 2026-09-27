/// Three-state library filter: ignore, only matching, or only not matching.
enum HvTriState { off, include, exclude }

extension HvTriStateNext on HvTriState {
  HvTriState get next =>
      HvTriState.values[(index + 1) % HvTriState.values.length];
}

enum HvLibraryGroupBy { none, status, source, trackerStatus }

class HvLibraryPrefs {
  final HvTriState unread;
  final HvTriState started;
  final HvTriState completed;
  final HvTriState updates;
  final HvLibraryGroupBy groupBy;

  const HvLibraryPrefs({
    this.unread = HvTriState.off,
    this.started = HvTriState.off,
    this.completed = HvTriState.off,
    this.updates = HvTriState.off,
    this.groupBy = HvLibraryGroupBy.none,
  });

  bool get hasFilters =>
      unread != HvTriState.off ||
      started != HvTriState.off ||
      completed != HvTriState.off ||
      updates != HvTriState.off;

  HvLibraryPrefs copyWith({
    HvTriState? unread,
    HvTriState? started,
    HvTriState? completed,
    HvTriState? updates,
    HvLibraryGroupBy? groupBy,
  }) =>
      HvLibraryPrefs(
        unread: unread ?? this.unread,
        started: started ?? this.started,
        completed: completed ?? this.completed,
        updates: updates ?? this.updates,
        groupBy: groupBy ?? this.groupBy,
      );

  Map<String, dynamic> toJson() => {
        'unread': unread.index,
        'started': started.index,
        'completed': completed.index,
        'updates': updates.index,
        'groupBy': groupBy.index,
      };

  factory HvLibraryPrefs.fromJson(Map<String, dynamic> json) {
    T pick<T>(List<T> values, Object? i, T fallback) =>
        i is int && i >= 0 && i < values.length ? values[i] : fallback;
    return HvLibraryPrefs(
      unread: pick(HvTriState.values, json['unread'], HvTriState.off),
      started: pick(HvTriState.values, json['started'], HvTriState.off),
      completed: pick(HvTriState.values, json['completed'], HvTriState.off),
      updates: pick(HvTriState.values, json['updates'], HvTriState.off),
      groupBy:
          pick(HvLibraryGroupBy.values, json['groupBy'], HvLibraryGroupBy.none),
    );
  }
}

/// What the filters need to know about one library title.
class HvLibraryFacts {
  final int unreadCount;
  final bool started;
  final bool completed;
  final bool hasUpdates;

  const HvLibraryFacts({
    this.unreadCount = 0,
    this.started = false,
    this.completed = false,
    this.hasUpdates = false,
  });
}

bool passesLibraryFilters(HvLibraryFacts f, HvLibraryPrefs p) {
  bool check(HvTriState state, bool value) => switch (state) {
        HvTriState.off => true,
        HvTriState.include => value,
        HvTriState.exclude => !value,
      };
  return check(p.unread, f.unreadCount > 0) &&
      check(p.started, f.started) &&
      check(p.completed, f.completed) &&
      check(p.updates, f.hasUpdates);
}

/// One section of a grouped library.
class HvLibraryGroup<T> {
  final String label;
  final List<T> items;
  HvLibraryGroup(this.label, this.items);
}

/// Tracker list statuses in reading order (AniList names; MAL/Simkl
/// statuses are mapped onto them before grouping).
const List<String> kTrackerStatusOrder = [
  'CURRENT',
  'REPEATING',
  'PLANNING',
  'PAUSED',
  'COMPLETED',
  'DROPPED',
];

/// Groups [items] by [keyOf]; groups are ordered by [order] when given,
/// otherwise alphabetically, with [unknownLabel] always last. Item order
/// within a group is kept.
List<HvLibraryGroup<T>> groupLibrary<T>(
  List<T> items, {
  required String? Function(T) keyOf,
  String unknownLabel = 'Unknown',
  List<String>? order,
}) {
  final groups = <String, List<T>>{};
  for (final item in items) {
    final raw = keyOf(item)?.trim() ?? '';
    groups.putIfAbsent(raw.isEmpty ? unknownLabel : raw, () => []).add(item);
  }
  int rank(String label) {
    if (label == unknownLabel) return 1 << 20;
    if (order == null) return 0;
    final i = order.indexOf(label);
    return i == -1 ? order.length : i;
  }

  final labels = groups.keys.toList()
    ..sort((a, b) {
      final byRank = rank(a).compareTo(rank(b));
      return byRank != 0 ? byRank : a.toLowerCase().compareTo(b.toLowerCase());
    });
  return [for (final l in labels) HvLibraryGroup<T>(l, groups[l]!)];
}

/// Maps a tracker's own status name to the AniList-style names above.
String? normalizeTrackerStatus(String? status) {
  final s = (status ?? '').trim().toUpperCase().replaceAll(' ', '_');
  if (s.isEmpty) return null;
  return switch (s) {
    'CURRENT' || 'READING' || 'WATCHING' => 'CURRENT',
    'REPEATING' || 'REREADING' || 'REWATCHING' => 'REPEATING',
    'PLANNING' || 'PLAN_TO_READ' || 'PLAN_TO_WATCH' || 'PLANTOWATCH' =>
      'PLANNING',
    'PAUSED' || 'ON_HOLD' || 'HOLD' => 'PAUSED',
    'COMPLETED' || 'COMPLETED_' => 'COMPLETED',
    'DROPPED' => 'DROPPED',
    _ => s,
  };
}
