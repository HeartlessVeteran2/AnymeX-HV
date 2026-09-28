import 'package:anymex/hv/library_update/core/unread.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hvUnreadEstimate', () {
    test('unknown until the source has been checked', () {
      expect(hvUnreadEstimate(null, [1, 2, 3]), isNull);
    });

    test('counts by chapter number, not by list length', () {
      // A source listing 3 scanlations of chapters 1-100 has 300 entries;
      // having finished 100 means nothing is left.
      expect(hvUnreadEstimate(100, [for (var i = 1; i <= 100; i++) i * 1.0]),
          0);
    });

    test('behind by the gap to the furthest finished chapter', () {
      expect(hvUnreadEstimate(52, [1, 2, 50]), 2);
      expect(hvUnreadEstimate(10, []), 10);
    });

    test('a fractional latest chapter rounds up', () {
      expect(hvUnreadEstimate(50.5, [50]), 1);
    });

    test('reading past the source (another source ahead) is not negative', () {
      expect(hvUnreadEstimate(40, [45]), 0);
    });
  });

  test('hvLatestNumber ignores chapters without a number', () {
    expect(hvLatestNumber([1, null, 12.5, 3]), 12.5);
    expect(hvLatestNumber([null]), isNull);
  });
}
