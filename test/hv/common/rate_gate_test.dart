import 'package:anymex/hv/common/core/rate_gate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lets a key through once per window, each key on its own', () {
    var now = DateTime(2026, 1, 1, 12);
    final gate = HvRateGate(const Duration(minutes: 1), now: () => now);

    expect(gate.allow('a.com'), isTrue);
    expect(gate.allow('a.com'), isFalse);
    expect(gate.allow('b.com'), isTrue);

    now = now.add(const Duration(seconds: 59));
    expect(gate.allow('a.com'), isFalse);

    now = now.add(const Duration(seconds: 1));
    expect(gate.allow('a.com'), isTrue);
    expect(gate.allow('a.com'), isFalse);
  });
}
