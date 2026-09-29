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
