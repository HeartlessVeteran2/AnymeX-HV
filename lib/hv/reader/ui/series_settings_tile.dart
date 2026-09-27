import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/reader/core/reader_downloads.dart';
import 'package:anymex/hv/reader/reader_downloads_service.dart';
import 'package:anymex/hv/reader/series_settings.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Per-series options at the top of the reader's Reading Mode tab.
class HvSeriesSettingsTile extends StatefulWidget {
  const HvSeriesSettingsTile({super.key, required this.controller});
  final ReaderController controller;

  @override
  State<HvSeriesSettingsTile> createState() => _HvSeriesSettingsTileState();
}

class _HvSeriesSettingsTileState extends State<HvSeriesSettingsTile> {
  late HvDeleteAfterReadMode _deleteMode =
      HvReaderDownloads.modeFor(widget.controller.media);

  @override
  Widget build(BuildContext context) {
    final active = HvSeriesSettings.activeFor(widget.controller);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => AnymeXTile.toggle(
              icon: Icons.bookmark_added_outlined,
              title: 'Remember for this series',
              subtitle: active.value
                  ? 'Layout, direction, dual page and crop are saved for this title'
                  : 'Use the global reader settings',
              value: active.value,
              onChanged: (v) =>
                  HvSeriesSettings.setEnabled(widget.controller, v),
            )),
        Obx(() {
          if (widget.controller.dualPageMode.value == DualPageMode.off) {
            return const SizedBox.shrink();
          }
          return AnymeXTile.toggle(
            icon: Icons.auto_stories_outlined,
            title: 'Dual page: first page alone',
            subtitle: 'Show the cover by itself so spreads line up',
            value: HvKeys.hvDualPageShift.get<bool>(false),
            onChanged: (v) {
              HvKeys.hvDualPageShift.set(v);
              // Re-pairs the pages with the new setting.
              widget.controller
                  .toggleDualPageMode(widget.controller.dualPageMode.value);
              setState(() {});
            },
          );
        }),
        AnymeXTile.segmented<HvDeleteAfterReadMode>(
          icon: Icons.auto_delete_outlined,
          title: 'Delete downloads after reading',
          subtitle: 'For this series',
          value: _deleteMode,
          options: HvDeleteAfterReadMode.values,
          optionLabelTransformer: (m) => switch (m) {
            HvDeleteAfterReadMode.inherit => 'Default',
            HvDeleteAfterReadMode.enabled => 'On',
            HvDeleteAfterReadMode.disabled => 'Off',
          },
          onChanged: (m) {
            HvReaderDownloads.setMode(widget.controller.media, m);
            setState(() => _deleteMode = m);
          },
        ),
      ],
    );
  }
}
