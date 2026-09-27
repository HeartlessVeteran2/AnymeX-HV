import 'package:anymex/controllers/offline/offline_storage_controller.dart';
import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/library_update/library_update_service.dart';
import 'package:anymex/main.dart' show isar;
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

/// Multi-select on the library grid: long-press a title to start, tap to
/// add or remove more.
class HvLibrarySelection {
  HvLibrarySelection._();

  static final RxSet<String> selected = <String>{}.obs;
  static ItemType? _type;

  static bool get active => selected.isNotEmpty;

  /// Whether a selection of [type] titles is in progress. A selection made
  /// on another media type doesn't count: ids are per type, so acting on it
  /// here would add the wrong titles to this type's lists.
  static bool activeFor(ItemType type) => active && _type == type;

  /// Selects every title in [items].
  static void selectAll(Iterable<OfflineMedia> items, ItemType type) {
    if (_type != type) {
      selected.clear();
      _type = type;
    }
    selected.addAll([
      for (final m in items)
        if ((m.mediaId ?? '').isNotEmpty) m.mediaId!,
    ]);
  }

  static void toggle(OfflineMedia item, ItemType type) {
    final id = item.mediaId;
    if (id == null || id.isEmpty) return;
    if (_type != type) {
      selected.clear();
      _type = type;
    }
    if (!selected.remove(id)) selected.add(id);
  }

  static void clear() => selected.clear();

  /// Tap on a card: toggles while selecting, otherwise opens the title.
  static void onTap(OfflineMedia item, ItemType type, VoidCallback open) {
    if (activeFor(type)) {
      toggle(item, type);
    } else {
      open();
    }
  }

  static void onLongPress(OfflineMedia item, ItemType type) =>
      toggle(item, type);
}

/// Card overlay showing the selection state.
class HvSelectableCard extends StatelessWidget {
  const HvSelectableCard({super.key, required this.item, required this.child});

  final OfflineMedia item;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Obx(() {
      final isSelected = HvLibrarySelection.selected.contains(item.mediaId) &&
          HvLibrarySelection._type?.index == item.mediaTypeIndex;
      if (!isSelected) return child;
      return Stack(
        children: [
          child,
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.25),
                  border: Border.all(color: colors.primary, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(Icons.check_circle, color: colors.primary),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

/// Bottom action bar while titles are selected.
class HvLibrarySelectionBar extends StatelessWidget {
  const HvLibrarySelectionBar({
    super.key,
    required this.type,
    required this.currentListName,
    required this.visibleItems,
  });

  final ItemType Function() type;

  /// Name of the list being shown, or null for History.
  final String? Function() currentListName;
  final List<OfflineMedia> Function() visibleItems;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // Positioned must be the Stack's direct child, so it wraps the Obx.
    return Positioned(
      left: 12,
      right: 12,
      bottom: MediaQuery.paddingOf(context).bottom + 96,
      child: Obx(() {
        if (!HvLibrarySelection.activeFor(type())) {
          return const SizedBox.shrink();
        }
        final count = HvLibrarySelection.selected.length;
        final listName = currentListName();
        return Material(
          elevation: 6,
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                const IconButton(
                  tooltip: 'Cancel',
                  icon: Icon(Icons.close_rounded),
                  onPressed: HvLibrarySelection.clear,
                ),
                Expanded(child: Text('$count selected')),
                IconButton(
                  tooltip: 'Select all',
                  icon: const Icon(Icons.select_all_rounded),
                  onPressed: () =>
                      HvLibrarySelection.selectAll(visibleItems(), type()),
                ),
                IconButton(
                  tooltip: 'Add to list',
                  icon: const Icon(Icons.playlist_add_rounded),
                  onPressed: () => _addToList(context, move: false),
                ),
                if (listName != null)
                  IconButton(
                    tooltip: 'Move to list',
                    icon: const Icon(Icons.drive_file_move_outline),
                    onPressed: () =>
                        _addToList(context, move: true, from: listName),
                  ),
                if (listName != null)
                  IconButton(
                    tooltip: 'Remove from "$listName"',
                    icon: const Icon(Icons.playlist_remove_rounded),
                    onPressed: () => _removeFrom(listName),
                  ),
                if (type() != ItemType.anime)
                  IconButton(
                    tooltip: 'Check for new chapters',
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: _update,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _addToList(BuildContext context,
      {required bool move, String? from}) async {
    final t = type();
    final names = isar.customLists
        .filter()
        .mediaTypeIndexEqualTo(t.index)
        .findAllSync()
        .map((l) => l.listName ?? '')
        .where((n) => n.isNotEmpty && n != from)
        .toList();
    if (names.isEmpty) {
      snackBar('No other lists');
      return;
    }
    final target = await showDialog<String>(
      context: context,
      builder: (dialog) => SimpleDialog(
        title: Text(move ? 'Move to list' : 'Add to list'),
        children: [
          for (final name in names)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(dialog, name),
              child: Text(name),
            ),
        ],
      ),
    );
    if (target == null) return;
    final storage = Get.find<OfflineStorageController>();
    final ids = HvLibrarySelection.selected.toList();
    for (final id in ids) {
      await storage.addMediaToList(target, id, mediaType: t);
      if (move && from != null) {
        await storage.removeMediaFromList(from, id, mediaType: t);
      }
    }
    HvLibrarySelection.clear();
    snackBar('${move ? 'Moved' : 'Added'} ${ids.length} to "$target"');
  }

  Future<void> _removeFrom(String listName) async {
    final t = type();
    final storage = Get.find<OfflineStorageController>();
    final ids = HvLibrarySelection.selected.toList();
    for (final id in ids) {
      await storage.removeMediaFromList(listName, id, mediaType: t);
    }
    HvLibrarySelection.clear();
    snackBar('Removed ${ids.length} from "$listName"');
  }

  Future<void> _update() async {
    final t = type();
    final keys = {
      for (final id in HvLibrarySelection.selected) hvMediaKey(t.index, id)
    };
    HvLibrarySelection.clear();
    final result =
        await LibraryUpdateService.to.run(types: {t}, onlyMediaKeys: keys);
    if (result == null) {
      snackBar('An update is already running');
      return;
    }
    snackBar(result.newChapters == 0
        ? 'No new chapters'
        : '${result.newChapters} new chapters — see Updates');
  }
}
