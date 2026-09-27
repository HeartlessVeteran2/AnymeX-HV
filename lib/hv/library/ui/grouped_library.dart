import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/hv/library/core/library_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The library grid split into collapsible sections (Komikku's library
/// grouping). Cards come from the library's own builder, so they look and
/// behave exactly like the ungrouped grid.
class HvGroupedLibrary extends StatelessWidget {
  const HvGroupedLibrary({
    super.key,
    required this.groups,
    required this.gridDelegate,
    required this.itemBuilder,
  });

  final List<HvLibraryGroup<OfflineMedia>> groups;
  final SliverGridDelegate gridDelegate;

  /// Builds the card for `items[index]` of one group.
  final Widget Function(
      BuildContext context, List<OfflineMedia> items, int index) itemBuilder;

  static final RxSet<String> _collapsed = <String>{}.obs;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 130),
      sliver: Obx(() {
        final collapsed = _collapsed.toSet();
        return SliverMainAxisGroup(
          slivers: [
            for (final group in groups) ...[
              SliverToBoxAdapter(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => collapsed.contains(group.label)
                      ? _collapsed.remove(group.label)
                      : _collapsed.add(group.label),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 16, 4, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            group.label,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: colors.primary),
                          ),
                        ),
                        Text('${group.items.length}',
                            style: Theme.of(context).textTheme.labelLarge),
                        Icon(collapsed.contains(group.label)
                            ? Icons.expand_more_rounded
                            : Icons.expand_less_rounded),
                      ],
                    ),
                  ),
                ),
              ),
              if (!collapsed.contains(group.label))
                SliverGrid(
                  gridDelegate: gridDelegate,
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => itemBuilder(context, group.items, i),
                    childCount: group.items.length,
                  ),
                ),
            ],
          ],
        );
      }),
    );
  }
}
