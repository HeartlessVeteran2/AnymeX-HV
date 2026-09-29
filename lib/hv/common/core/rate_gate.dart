/// Lets an action through at most once per [window] for each key.
class HvRateGate {
  HvRateGate(this.window, {DateTime Function()? now})
      : _now = now ?? DateTime.now;

  final Duration window;
  final DateTime Function() _now;
  final Map<String, DateTime> _last = {};

  /// Whether [key] may go through now (and records that it did).
  bool allow(String key) {
    final now = _now();
    final last = _last[key];
    if (last != null && now.difference(last) < window) return false;
    _last[key] = now;
    return true;
  }
}
