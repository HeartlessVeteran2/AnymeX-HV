import 'package:anymex/hv/reader/core/dual_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('plain pairing', () {
    expect(pairPages([1, 2, 3, 4, 5]), [(1, 2), (3, 4), (5, null)]);
    expect(pairPages(<int>[]), isEmpty);
  });

  test('first page alone shifts the rest', () {
    expect(pairPages([1, 2, 3, 4, 5], shiftFirst: true),
        [(1, null), (2, 3), (4, 5)]);
  });

  test('wide pages stand alone and pairing restarts after them', () {
    expect(pairPages([1, 2, 3, 4, 5, 6], isWide: (p) => p == 3),
        [(1, 2), (3, null), (4, 5), (6, null)]);
    // A wide page right after an unpaired page keeps that page alone.
    expect(pairPages([1, 2, 3], isWide: (p) => p == 2),
        [(1, null), (2, null), (3, null)]);
  });
}
