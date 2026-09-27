import 'package:anymex/hv/reader/reader_hooks.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/screens/manga/widgets/reader/reader_chapter_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Full-screen chapter transition (finished / next chapter, missing
/// chapters warning) shown before changing chapter with the buttons.
class HvTransitionOverlay extends StatelessWidget {
  const HvTransitionOverlay({super.key, required this.controller});
  final ReaderController controller;

  @override
  Widget build(BuildContext context) {
    // Positioned must be the Stack's direct child, so it wraps the Obx.
    return Positioned.fill(
      child: Obx(() {
        final current = controller.currentChapter.value;
        if (!controller.showingTransition.value || current == null) {
          return const SizedBox.shrink();
        }
        final next = controller.transitionIsNext.value;
        final target = controller.transitionTargetChapter.value;
        return Material(
          color: Theme.of(context).colorScheme.surface,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ReaderChapterTransition(
                    isNext: next,
                    currentChapter: current,
                    targetChapter: target,
                    posterUrl: controller.media.poster,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              HvReaderHooks.cancelTransition(controller),
                          child: const Text('Stay'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: target == null
                              ? null
                              : () =>
                                  HvReaderHooks.continueTransition(controller),
                          child:
                              Text(next ? 'Next chapter' : 'Previous chapter'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
