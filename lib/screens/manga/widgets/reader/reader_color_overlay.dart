import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';

class ReaderContentOverlay extends StatelessWidget {
  const ReaderContentOverlay({super.key, required this.controller});

  final ReaderController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final brightness = controller.customBrightnessValue.value;

      return Stack(
        children: [
          if (brightness < 0)
            IgnorePointer(
              child: Opacity(
                opacity: (brightness.abs() / 100.0).clamp(0.0, 1.0),
                child: Container(color: Colors.black),
              ),
            ),

          // HV: the color filter is applied by ReaderView's ColorFiltered,
          // which honours the blend mode. This overlay painted it again into
          // an empty layer, where every blend mode acts as a flat tint.
        ],
      );
    });
  }

  // HV: unused since the color tint moved to ReaderView (kept for upstream)
  // ignore: unused_element
  static BlendMode _blendModeFromIndex(int index) {
    const modes = [
      BlendMode.srcOver,
      BlendMode.multiply,
      BlendMode.screen,
      BlendMode.overlay,
      BlendMode.darken,
      BlendMode.lighten,
      BlendMode.colorDodge,
      BlendMode.colorBurn,
      BlendMode.hardLight,
      BlendMode.softLight,
      BlendMode.difference,
      BlendMode.exclusion,
      BlendMode.hue,
      BlendMode.saturation,
      BlendMode.color,
      BlendMode.luminosity,
    ];
    if (index >= 0 && index < modes.length) return modes[index];
    return BlendMode.srcOver;
  }
}

// HV: unused, see above (kept for upstream)
// ignore: unused_element
class _ColorOverlayPainter extends CustomPainter {
  const _ColorOverlayPainter({required this.color, required this.blendMode});

  final Color color;
  final BlendMode blendMode;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = color
        ..blendMode = blendMode,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ColorOverlayPainter old) =>
      old.color != color || old.blendMode != blendMode;
}
