/// Numbers repeated loads of the same thing, so only the newest one may apply
/// its result.
///
/// Take a number with [begin] when a load starts, and check [isCurrent] after
/// each await: a load that finishes after a newer one started is stale.
class HvLatestOnly {
  int _latest = 0;

  /// Starts a load and returns its number.
  int begin() => ++_latest;

  /// Whether [load] is still the newest load.
  bool isCurrent(int load) => load == _latest;
}

/// Runs actions one at a time, in the order they were queued. An action that
/// a newer one replaced while it waited is skipped, so the last action queued
/// always runs, and runs last: its result is the one that stays.
class HvLastRunQueue {
  final _runs = HvLatestOnly();
  Future<void> _tail = Future.value();

  /// Queues [action]. Completes when it has run (with its error, if it
  /// failed) or was skipped.
  Future<void> run(Future<void> Function() action) {
    final me = _runs.begin();
    final result = _tail.then((_) async {
      if (_runs.isCurrent(me)) await action();
    });
    _tail = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }
}
