import 'package:anymex/hv/reader/core/key_navigation.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:flutter/services.dart';

/// Keyboard paging for the reader.
class HvReaderKeys {
  HvReaderKeys._();

  static HvArrow? _arrow(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.arrowUp) return HvArrow.up;
    if (key == LogicalKeyboardKey.arrowDown) return HvArrow.down;
    if (key == LogicalKeyboardKey.arrowLeft) return HvArrow.left;
    if (key == LogicalKeyboardKey.arrowRight) return HvArrow.right;
    return null;
  }

  /// Handles an arrow key in the paged layout; returns false (leaving the key
  /// to the reader's own handler) for other keys and the continuous layout.
  ///
  /// The reader's handler stepped by page number (`navigateToPage`), which in
  /// two-page mode often lands inside the spread already on screen, so the
  /// keys seemed stuck or bounced between spreads.
  static bool handle(ReaderController controller, LogicalKeyboardKey key) {
    if (controller.readingLayout.value != MangaPageViewMode.paged) {
      return false;
    }
    final arrow = _arrow(key);
    if (arrow == null) return false;
    switch (hvPagedArrowTurn(arrow,
        reversed: controller.readingDirection.value.reversed)) {
      case HvTurn.forward:
        controller.navigateForward();
      case HvTurn.backward:
        controller.navigateBackward();
    }
    return true;
  }
}
