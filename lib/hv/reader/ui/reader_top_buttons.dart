import 'package:anymex/hv/bookmarks/bookmark_repository.dart';
import 'package:anymex/hv/bookmarks/models/hv_page_bookmark.dart';
import 'package:anymex/hv/bookmarks/reader_bookmarks.dart';
import 'package:anymex/hv/reader/ui/page_gallery_screen.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Round top-bar button in the default reader theme's style.
class HvReaderTopButton extends StatelessWidget {
  const HvReaderTopButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: colors.onSurface.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(icon, color: color ?? colors.onSurface, size: 18),
      ),
    );
  }
}

/// The HV buttons for the default reader top bar.
class HvReaderTopActions extends StatelessWidget {
  const HvReaderTopActions({super.key, required this.controller});
  final ReaderController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HvBookmarkPageButton(
          controller: controller,
          builder: (bookmarked, toggle) => HvReaderTopButton(
            icon: bookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            tooltip: bookmarked ? 'Remove bookmark' : 'Bookmark this page',
            onPressed: toggle,
            color: bookmarked ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
        const SizedBox(width: 6),
        HvReaderTopButton(
          icon: Icons.grid_view_rounded,
          tooltip: 'All pages',
          onPressed: () => HvPageGallery.open(context, controller),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

/// Tracks whether the reader's current page is bookmarked and hands the
/// state and a toggle to [builder] (so each reader theme draws its own
/// button).
class HvBookmarkPageButton extends StatefulWidget {
  const HvBookmarkPageButton({
    super.key,
    required this.controller,
    required this.builder,
  });

  final ReaderController controller;
  final Widget Function(bool bookmarked, VoidCallback toggle) builder;

  @override
  State<HvBookmarkPageButton> createState() => _HvBookmarkPageButtonState();
}

class _HvBookmarkPageButtonState extends State<HvBookmarkPageButton> {
  late final Stream<List<HvPageBookmark>> _stream =
      BookmarkRepository.watchForMedia(
          HvReaderBookmarks.mediaKey(widget.controller));

  Future<void> _toggle() async {
    final added = await HvReaderBookmarks.toggle(widget.controller);
    snackBar(added ? 'Page bookmarked' : 'Bookmark removed', duration: 1200);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HvPageBookmark>>(
      stream: _stream,
      builder: (context, snapshot) {
        final keys = {for (final b in snapshot.data ?? const []) b.bookmarkKey};
        return Obx(() => widget.builder(
              keys.contains(HvReaderBookmarks.currentKey(widget.controller)),
              _toggle,
            ));
      },
    );
  }
}
