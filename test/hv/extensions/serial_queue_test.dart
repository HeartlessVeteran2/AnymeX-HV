import 'package:anymex/hv/extensions/core/serial_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('runs actions one at a time, in order', () async {
    final queue = HvSerialQueue();
    final log = <String>[];
    var running = 0;
    Future<int> action(int n, Duration d) async {
      running++;
      expect(running, 1, reason: 'actions overlapped');
      log.add('start $n');
      await Future<void>.delayed(d);
      log.add('end $n');
      running--;
      return n;
    }

    final results = await Future.wait([
      queue.run(() => action(1, const Duration(milliseconds: 30))),
      queue.run(() => action(2, const Duration(milliseconds: 1))),
      queue.run(() => action(3, const Duration(milliseconds: 10))),
    ]);

    expect(results, [1, 2, 3]);
    expect(log, [
      'start 1', 'end 1', 'start 2', 'end 2', 'start 3', 'end 3', //
    ]);
  });

  test('a failure goes to its caller and the next action still runs', () async {
    final queue = HvSerialQueue();
    final failed = queue.run<void>(() async => throw StateError('install'));
    final next = queue.run(() async => 'ok');

    await expectLater(failed, throwsStateError);
    expect(await next, 'ok');
  });

  test('an action that throws before its first await is also contained',
      () async {
    final queue = HvSerialQueue();
    final failed = queue.run<void>(() => throw StateError('sync'));
    await expectLater(failed, throwsStateError);
    expect(await queue.run(() async => 1), 1);
  });
}
