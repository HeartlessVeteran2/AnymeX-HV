/// Runs actions one at a time, in the order they were queued. A failed
/// action is reported to its caller and doesn't stop the ones after it.
class HvSerialQueue {
  Future<void> _last = Future.value();

  Future<T> run<T>(Future<T> Function() action) {
    final result = _last.then((_) => action());
    _last = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }
}
