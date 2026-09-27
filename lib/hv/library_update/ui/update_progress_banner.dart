import 'package:anymex/hv/library_update/library_update_service.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Thin progress strip shown while the library update runs.
class HvUpdateProgressBanner extends StatelessWidget {
  const HvUpdateProgressBanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LibraryUpdateService>()) {
      return const SizedBox.shrink();
    }
    final service = LibraryUpdateService.to;
    final colors = Theme.of(context).colorScheme;
    return Obx(() {
      if (!service.running.value) return const SizedBox.shrink();
      final total = service.total.value;
      final done = service.done.value;
      return Material(
        color: colors.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AnymeXText(
                      total == 0
                          ? 'Preparing library update…'
                          : 'Checking $done of $total · ${service.current.value}',
                      size: 13,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: colors.onSecondaryContainer,
                    ),
                  ),
                  TextButton(
                    onPressed: service.cancel,
                    child: const Text('Stop'),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: total == 0 ? null : done / total,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
      );
    });
  }
}
