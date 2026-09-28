import 'package:anymex/hv/common/core/safe_kv_writer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<String> sync;
  late List<String> async;
  late bool syncFails;

  HvSafeKvWriter writer() => HvSafeKvWriter(
        writeSync: (v) {
          if (syncFails) throw StateError('async write in progress');
          sync.add(v);
        },
        writeAsync: (v) async => async.add(v),
        retryDelay: Duration.zero,
      );

  setUp(() {
    sync = [];
    async = [];
    syncFails = false;
  });

  test('writes synchronously when it can', () async {
    final w = writer()..write('a');
    await w.idle;
    expect(sync, ['a']);
    expect(async, isEmpty);
  });

  test('does not throw and saves later when a sync write fails', () async {
    syncFails = true;
    final w = writer();
    expect(() => w.write('a'), returnsNormally);
    await w.idle;
    expect(async, ['a']);
  });

  test('the last value wins while a write is queued', () async {
    syncFails = true;
    final w = writer()..write('a');
    syncFails = false;
    // Written straight away, this would be overwritten by the queued 'a'.
    w
      ..write('b')
      ..write('c');
    await w.idle;
    expect(sync, isEmpty);
    expect(async, ['c']);

    w.write('d');
    expect(sync, ['d']);
  });

  test('a failed async write keeps the writer usable', () async {
    var calls = 0;
    final w = HvSafeKvWriter(
      writeSync: (_) => throw StateError('busy'),
      writeAsync: (_) async {
        calls++;
        throw StateError('disk full');
      },
      retryDelay: Duration.zero,
    )..write('a');
    await w.idle;
    expect(calls, 3); // gives up after maxAttempts
    w.write('b');
    await w.idle;
    expect(calls, 6);
  });

  test('a failed async write is retried', () async {
    var failuresLeft = 2;
    final saved = <String>[];
    final w = HvSafeKvWriter(
      writeSync: (_) => throw StateError('busy'),
      writeAsync: (v) async {
        if (failuresLeft-- > 0) throw StateError('busy');
        saved.add(v);
      },
      retryDelay: Duration.zero,
    )..write('a');
    await w.idle;
    expect(saved, ['a']);
  });

  test('a retry saves the newest value', () async {
    var failed = false;
    final saved = <String>[];
    late HvSafeKvWriter w;
    w = HvSafeKvWriter(
      writeSync: (_) => throw StateError('busy'),
      writeAsync: (v) async {
        if (!failed) {
          failed = true;
          w.write('b'); // a newer value arrives while the first write fails
          throw StateError('busy');
        }
        saved.add(v);
      },
      retryDelay: Duration.zero,
    )..write('a');
    await w.idle;
    expect(saved, ['b']);
  });
}
