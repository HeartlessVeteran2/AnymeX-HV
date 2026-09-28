import 'package:anymex/hv/reader/core/key_navigation.dart';
import 'package:flutter_test/flutter_test.dart';

/// The reading-order step the reader's old handler took for each key:
/// down = next, up = previous, right = next unless reversed, left the
/// opposite.
int oldStep(HvArrow a, bool reversed) => switch (a) {
      HvArrow.down => 1,
      HvArrow.up => -1,
      HvArrow.right => reversed ? -1 : 1,
      HvArrow.left => reversed ? 1 : -1,
    };

/// The reading-order step a turn takes: navigateForward is nextPage, or
/// previousPage when the direction is reversed (and navigateBackward the
/// opposite).
int turnStep(HvTurn t, bool reversed) =>
    (t == HvTurn.forward ? 1 : -1) * (reversed ? -1 : 1);

void main() {
  test('every arrow keeps the direction it always had', () {
    for (final reversed in [false, true]) {
      for (final a in HvArrow.values) {
        expect(turnStep(hvPagedArrowTurn(a, reversed: reversed), reversed),
            oldStep(a, reversed),
            reason: '$a, reversed: $reversed');
      }
    }
  });

  test('left to right: right and down go forward', () {
    expect(hvPagedArrowTurn(HvArrow.right, reversed: false), HvTurn.forward);
    expect(hvPagedArrowTurn(HvArrow.down, reversed: false), HvTurn.forward);
    expect(hvPagedArrowTurn(HvArrow.left, reversed: false), HvTurn.backward);
    expect(hvPagedArrowTurn(HvArrow.up, reversed: false), HvTurn.backward);
  });

  test('right to left: left and down move on through the book', () {
    // In a reversed layout navigateBackward is the next page.
    expect(hvPagedArrowTurn(HvArrow.left, reversed: true), HvTurn.backward);
    expect(hvPagedArrowTurn(HvArrow.down, reversed: true), HvTurn.backward);
    expect(hvPagedArrowTurn(HvArrow.right, reversed: true), HvTurn.forward);
    expect(hvPagedArrowTurn(HvArrow.up, reversed: true), HvTurn.forward);
  });
}
