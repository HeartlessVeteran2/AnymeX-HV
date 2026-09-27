import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/hv/library/core/library_filter.dart';
import 'package:anymex/hv/library/library_hooks.dart';
import 'package:anymex/main.dart' show isar;
import 'package:anymex/widgets/header/header.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

/// Library header button for filters, grouping and hidden lists.
class HvLibraryFilterButton extends StatelessWidget {
  const HvLibraryFilterButton({super.key, required this.type});

  final Rx<ItemType> type;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Obx(() {
      final prefs = HvLibraryHooks.prefsFor(type.value).value;
      final active =
          prefs.hasFilters || prefs.groupBy != HvLibraryGroupBy.none;
      return HeaderActionButton(
        icon: Icons.filter_list_rounded,
        onTap: () => showHvLibraryFilterSheet(context, type.value),
        badge: active
            ? Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: colors.primary, shape: BoxShape.circle),
              )
            : null,
      );
    });
  }
}

void showHvLibraryFilterSheet(BuildContext context, ItemType type) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheet) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scroll) => _FilterSheet(type: type, scroll: scroll),
    ),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.type, required this.scroll});
  final ItemType type;
  final ScrollController scroll;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  ItemType get type => widget.type;

  Widget _triState(String label, HvTriState state,
      HvLibraryPrefs Function(HvTriState) update) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      onTap: () => HvLibraryHooks.setPrefs(type, update(state.next)),
      leading: Icon(
        switch (state) {
          HvTriState.off => Icons.check_box_outline_blank_rounded,
          HvTriState.include => Icons.check_box_rounded,
          HvTriState.exclude => Icons.disabled_by_default_rounded,
        },
        color: state == HvTriState.off ? null : colors.primary,
      ),
      title: Text(label),
      subtitle: switch (state) {
        HvTriState.off => null,
        HvTriState.include => const Text('Only these'),
        HvTriState.exclude => const Text('Hide these'),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lists = isar.customLists
        .filter()
        .mediaTypeIndexEqualTo(type.index)
        .findAllSync()
        .where((l) => (l.listName ?? '').isNotEmpty)
        .toList();
    final isAnime = type == ItemType.anime;
    return Obx(() {
      final prefs = HvLibraryHooks.prefsFor(type).value;
      HvLibraryHooks.listsVersion.value; // rebuild on hidden-list changes
      return ListView(
        controller: widget.scroll,
        children: [
          const _Header('Filter'),
          if (!isAnime)
            _triState('Unread chapters', prefs.unread,
                (s) => prefs.copyWith(unread: s)),
          _triState(isAnime ? 'Started watching' : 'Started reading',
              prefs.started, (s) => prefs.copyWith(started: s)),
          _triState('Completed (publishing)', prefs.completed,
              (s) => prefs.copyWith(completed: s)),
          _triState('New chapters in Updates', prefs.updates,
              (s) => prefs.copyWith(updates: s)),
          const _Header('Group by'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: [
                for (final g in HvLibraryGroupBy.values)
                  ChoiceChip(
                    label: Text(switch (g) {
                      HvLibraryGroupBy.none => 'None',
                      HvLibraryGroupBy.status => 'Publishing status',
                      HvLibraryGroupBy.source => 'Source',
                      HvLibraryGroupBy.trackerStatus => 'Tracker status',
                    }),
                    selected: prefs.groupBy == g,
                    onSelected: (_) =>
                        HvLibraryHooks.setPrefs(type, prefs.copyWith(groupBy: g)),
                  ),
              ],
            ),
          ),
          const _Header('Lists'),
          SwitchListTile(
            title: const Text('Show hidden lists'),
            value: HvLibraryHooks.showHidden,
            onChanged: HvLibraryHooks.setShowHidden,
          ),
          for (final list in lists)
            ListTile(
              title: Text(list.listName!),
              subtitle: Text('${list.mediaIds?.length ?? 0} titles'),
              trailing: IconButton(
                tooltip: HvLibraryHooks.isHidden(type, list.listName!)
                    ? 'Show list'
                    : 'Hide list',
                icon: Icon(HvLibraryHooks.isHidden(type, list.listName!)
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () => HvLibraryHooks.setHidden(type, list.listName!,
                    !HvLibraryHooks.isHidden(type, list.listName!)),
              ),
            ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Text(
              'Search tips: -word hides matches, "exact phrase", '
              'src:name, status:releasing, genre:action.',
            ),
          ),
        ],
      );
    });
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).colorScheme.primary)),
      );
}
