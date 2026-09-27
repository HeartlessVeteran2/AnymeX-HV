import 'package:anymex/hv/library_update/library_update_service.dart';
import 'package:anymex/hv/library_update/models/hv_chapter_update.dart';
import 'package:anymex/hv/library_update/ui/updates_screen.dart';
import 'package:anymex/hv/library_update/update_repository.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex/widgets/header/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Library header button that opens the Updates screen, with a badge for
/// new chapters and a small spinner while an update runs.
class HvLibraryUpdatesButton extends StatelessWidget {
  const HvLibraryUpdatesButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LibraryUpdateService>()) {
      return const SizedBox.shrink();
    }
    final service = LibraryUpdateService.to;
    final colors = Theme.of(context).colorScheme;
    return StreamBuilder<List<HvChapterUpdate>>(
      stream: UpdateRepository.watchVisible(),
      builder: (context, snapshot) {
        final count = snapshot.data?.length ?? 0;
        return Obx(() {
          Widget? badge;
          if (service.running.value) {
            badge = const SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(strokeWidth: 1.5),
            );
          } else if (count > 0) {
            badge = Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: colors.error,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: TextStyle(fontSize: 9, color: colors.onError),
              ),
            );
          }
          return HeaderActionButton(
            icon: Icons.new_releases_outlined,
            onTap: () => navigate(() => const HvUpdatesScreen()),
            badge: badge,
          );
        });
      },
    );
  }
}
