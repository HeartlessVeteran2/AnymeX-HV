import 'dart:async';

import 'package:anymex/hv/extensions/source_calls.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('passes the result through when the source answers in time', () async {
    final v = await hvWithTimeout(Future.value(3),
        action: 'Search', limit: const Duration(seconds: 1));
    expect(v, 3);
  });

  test('keeps the source error instead of hiding it', () async {
    await expectLater(
      hvWithTimeout<int>(Future.error(StateError('blocked')),
          action: 'Search', limit: const Duration(seconds: 1)),
      throwsA(isA<StateError>()),
    );
  });

  test('a source that never answers fails instead of hanging', () async {
    await expectLater(
      hvWithTimeout(Completer<int>().future,
          action: 'Search', limit: const Duration(milliseconds: 50)),
      throwsA(isA<HvSourceTimeoutException>()),
    );
  });

  test('the timeout message says what took too long', () {
    expect(
      const HvSourceTimeoutException('Loading pages', HvSourceTimeouts.pages)
          .toString(),
      startsWith('Loading pages took longer than 60 seconds.'),
    );
  });

  test('a missing source is a readable error, not a null check', () {
    expect(hvActiveSource<String>('src'), 'src');
    expect(() => hvActiveSource<String>(null),
        throwsA(isA<HvNoSourceException>()));
  });
}
