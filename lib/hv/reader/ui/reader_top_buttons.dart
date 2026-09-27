import 'package:anymex/hv/reader/ui/page_gallery_screen.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:flutter/material.dart';

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
