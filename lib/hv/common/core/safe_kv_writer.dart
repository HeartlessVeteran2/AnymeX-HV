/// Writes one value that is saved often (e.g. the cookie jar) without ever
/// throwing at the caller.
///
/// A synchronous Isar write fails while an asynchronous one is running in the
/// same isolate ("An async write transaction is already in progress"). The
/// HTTP cookie interceptor saved the jar synchronously on every request, so a
/// request made while the reader was saving progress failed, and the reader
/// showed "No pages found for this chapter" until Retry.
///
/// [write] tries [writeSync]; if that fails, it queues [writeAsync], which Isar
/// runs after the transaction in progress. The last value written always wins:
/// while a write is queued, new values only replace what it will store.
/// Pure, so it can be tested without Isar.
class HvSafeKvWriter {
  HvSafeKvWriter({required this.writeSync, required this.writeAsync});

  final void Function(String value) writeSync;
  final Future<void> Function(String value) writeAsync;

  String? _latest;
  Future<void>? _queued;

  /// Completes when a queued write (if any) has finished.
  Future<void> get idle => _queued ?? Future.value();

  void write(String value) {
    _latest = value;
    // A sync write now would be overwritten by the older value queued before.
    if (_queued != null) return;
    try {
      writeSync(value);
    } catch (_) {
      _queued = _flush();
    }
  }

  Future<void> _flush() async {
    await Future<void>.delayed(Duration.zero);
    String? written;
    try {
      while (_latest != written) {
        written = _latest;
        await writeAsync(written!);
      }
    } catch (_) {
      // Still in memory; the next write saves it.
    } finally {
      _queued = null;
    }
  }
}
