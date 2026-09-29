import 'dart:async';

import 'package:anymex/hv/common/core/latest_only.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a load is current until a newer one starts', () {
    final loads = HvLatestOnly();
    final first = loads.begin();
    expect(loads.isCurrent(first), isTrue);

    final second = loads.begin();
    expect(loads.isCurrent(first), isFalse);
    expect(loads.isCurrent(second), isTrue);
  });

  test('a slow load that finishes last does not apply its result', () async {
    // Chapter A's pages are slow; the user opens chapter B meanwhile, which
    // loads first. A's late result must not replace B's.
    final loads = HvLatestOnly();
    String? shown;
    final slow = Completer<String>();

    Future<void> load(Future<String> pages) async {
      final me = loads.begin();
      final result = await pages;
      if (loads.isCurrent(me)) shown = result;
    }

    final a = load(slow.future);
    await load(Future.value('chapter B'));
    slow.complete('chapter A');
    await a;

    expect(shown, 'chapter B');
  });

  group('HvLastRunQueue', () {
    test('runs one at a time and skips a run a newer one replaced', () async {
      // The setting is flipped three times while the first reload is slow:
      // the second reload is out of date before it starts, the third runs
      // after the first, so the latest value is the one that stays.
      final queue = HvLastRunQueue();
      final ran = <String>[];
      final slow = Completer<void>();

      final a = queue.run(() async {
        ran.add('a');
        await slow.future;
        ran.add('a done');
      });
      await Future<void>.delayed(Duration.zero);
      expect(ran, ['a']);

      final b = queue.run(() async => ran.add('b'));
      final c = queue.run(() async => ran.add('c'));
      await Future<void>.delayed(Duration.zero);
      expect(ran, ['a'], reason: 'c waits for a');

      slow.complete();
      await Future.wait([a, b, c]);
      expect(ran, ['a', 'a done', 'c']);
    });

    test('runs queued in the same instant: only the last one runs', () async {
      final queue = HvLastRunQueue();
      final ran = <String>[];
      await Future.wait([
        queue.run(() async => ran.add('a')),
        queue.run(() async => ran.add('b')),
      ]);
      expect(ran, ['b']);
    });

    test('a failed run reports its error and does not stop the next', () async {
      final queue = HvLastRunQueue();
      await expectLater(
          queue.run(() async => throw StateError('offline')), throwsStateError);

      var ran = false;
      await queue.run(() async => ran = true);
      expect(ran, isTrue);
    });
  });
}
