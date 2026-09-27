/// Arrow keys the reader handles.
enum HvArrow { up, down, left, right }

/// Which reader turn an arrow key asks for: `navigateForward` /
/// `navigateBackward`, the same calls the tap zones and mouse wheel use.
enum HvTurn { forward, backward }

/// The turn for [arrow] in a paged layout.
///
/// Right and left follow the screen, like the tap zones: right is
/// `navigateForward`, left is `navigateBackward`. Down and up follow reading
/// order: down is the next page and up the previous one, which in a reversed
/// direction are the opposite turns. This keeps the meaning the arrows always
/// had, but pages by spread instead of by page number, so in two-page mode
/// one press is one spread (upstream AnymeX #494).
HvTurn hvPagedArrowTurn(HvArrow arrow, {required bool reversed}) =>
    switch (arrow) {
      HvArrow.right => HvTurn.forward,
      HvArrow.left => HvTurn.backward,
      HvArrow.down => reversed ? HvTurn.backward : HvTurn.forward,
      HvArrow.up => reversed ? HvTurn.forward : HvTurn.backward,
    };
