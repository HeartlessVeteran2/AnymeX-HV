/// Tracks consecutive failures per source during one update run, so a source
/// that is down doesn't get hammered once per library title.
class SourceHealth {
  SourceHealth({this.pauseAfter = 3});

  /// Consecutive failures after which the source is skipped for the rest of
  /// the run.
  final int pauseAfter;

  final Map<String, int> _failures = {};

  bool isPaused(String sourceId) => (_failures[sourceId] ?? 0) >= pauseAfter;

  void recordSuccess(String sourceId) => _failures.remove(sourceId);

  void recordFailure(String sourceId) =>
      _failures[sourceId] = (_failures[sourceId] ?? 0) + 1;

  int failuresOf(String sourceId) => _failures[sourceId] ?? 0;
}
