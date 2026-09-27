import 'package:anymex/hv/reader/series_settings.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// "Remember for this series" switch in the reader's Reading Mode tab.
class HvSeriesSettingsTile extends StatelessWidget {
  const HvSeriesSettingsTile({super.key, required this.controller});
  final ReaderController controller;

  @override
  Widget build(BuildContext context) {
    final active = HvSeriesSettings.activeFor(controller);
    return Obx(() => AnymeXTile.toggle(
          icon: Icons.bookmark_added_outlined,
          title: 'Remember for this series',
          subtitle: active.value
              ? 'Layout, direction, dual page and crop are saved for this title'
              : 'Use the global reader settings',
          value: active.value,
          onChanged: (v) => HvSeriesSettings.setEnabled(controller, v),
        ));
  }
}
