import 'package:anymex/hv/reader/core/series_override.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('json round trip', () {
    const o = HvSeriesOverride(layout: 1, direction: 2, dualPage: 0, crop: true);
    final back = HvSeriesOverride.fromJson(o.toJson())!;
    expect(back.layout, 1);
    expect(back.direction, 2);
    expect(back.dualPage, 0);
    expect(back.crop, isTrue);
  });

  test('missing or malformed values mean no override', () {
    expect(HvSeriesOverride.fromJson(null), isNull);
    expect(HvSeriesOverride.fromJson(const {}), isNull);
    expect(HvSeriesOverride.fromJson({'layout': 'x', 'direction': 1, 'dualPage': 0}),
        isNull);
  });

  test('indexes are clamped to the current enums', () {
    const o = HvSeriesOverride(layout: 9, direction: -1, dualPage: 5, crop: false);
    final c = o.clamped(layouts: 2, directions: 4, dualModes: 3);
    expect([c.layout, c.direction, c.dualPage], [1, 0, 2]);
  });
}
