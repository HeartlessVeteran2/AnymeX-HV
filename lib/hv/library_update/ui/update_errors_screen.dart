import 'package:anymex/hv/common/hv_navigation.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/library_update/core/error_grouping.dart';
import 'package:anymex/hv/library_update/library_update_service.dart';
import 'package:anymex/hv/library_update/models/hv_update_error.dart';
import 'package:anymex/hv/library_update/update_repository.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_image.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_text.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Titles the last library updates couldn't check, grouped by error (Komikku
/// / Otaku Reader "Update errors"). Tap a title to open it — picking the
/// right entry with "Wrong title?" there fixes a bad link — or select titles
/// to retry or dismiss them.
class HvUpdateErrorsScreen extends StatefulWidget {
  const HvUpdateErrorsScreen({super.key});

  @override
  State<HvUpdateErrorsScreen> createState() => _HvUpdateErrorsScreenState();
}

class _HvUpdateErrorsScreenState extends State<HvUpdateErrorsScreen> {
  final Set<int> _selected = {};

  bool get _selecting => _selected.isNotEmpty;

  void _toggle(HvUpdateError e) => setState(() {
        if (!_selected.remove(e.id)) _selected.add(e.id);
      });

  Future<void> _retry(List<HvUpdateError> all) async {
    final keys = {
      for (final e in all)
        if (_selected.isEmpty || _selected.contains(e.id)) e.mediaKey,
    };
    setState(_selected.clear);
    final result = await LibraryUpdateService.to.run(
      types: ItemType.values.toSet(),
      onlyMediaKeys: keys,
    );
    if (result == null) {
      snackBar('An update is already running');
      return;
    }
    snackBar(result.failed == 0
        ? 'All ${result.checked} titles checked'
        : '${result.failed} still failing');
  }

  Future<void> _dismiss(List<HvUpdateError> all) async {
    final ids = _selected.isEmpty ? all.map((e) => e.id) : _selected.toList();
    await UpdateRepository.clearErrors(ids);
    setState(_selected.clear);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HvUpdateError>>(
      stream: UpdateRepository.watchErrors(),
      builder: (context, snapshot) {
        final errors = snapshot.data ?? const <HvUpdateError>[];
        _selected.retainAll(errors.map((e) => e.id));
        final groups = groupErrors<HvUpdateError>(
          errors,
          message: (e) => e.message,
          timestamp: (e) => e.timestamp,
        );
        return Scaffold(
          appBar: AppBar(
            leading: _selecting
                ? IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => setState(_selected.clear),
                  )
                : null,
            title: Text(_selecting
                ? '${_selected.length} selected'
                : 'Update errors'),
            actions: [
              if (_selecting)
                IconButton(
                  tooltip: 'Select all',
                  icon: const Icon(Icons.select_all_rounded),
                  onPressed: () =>
                      setState(() => _selected.addAll(errors.map((e) => e.id))),
                ),
              if (errors.isNotEmpty) ...[
                IconButton(
                  tooltip: _selecting ? 'Retry selected' : 'Retry all',
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: () => _retry(errors),
                ),
                IconButton(
                  tooltip: _selecting ? 'Dismiss selected' : 'Dismiss all',
                  icon: const Icon(Icons.delete_sweep_outlined),
                  onPressed: () => _dismiss(errors),
                ),
              ],
            ],
          ),
          body: errors.isEmpty
              ? const Center(
                  child: AnymeXText('No update errors', size: 15),
                )
              : ListView(
                  padding: const EdgeInsets.only(bottom: 96),
                  children: [
                    for (final group in groups) ...[
                      _GroupHeader(group: group),
                      for (final error in group.items)
                        _ErrorTile(
                          error: error,
                          selected: _selected.contains(error.id),
                          onTap: _selecting
                              ? () => _toggle(error)
                              : () => _open(error),
                          onLongPress: () => _toggle(error),
                        ),
                    ],
                  ],
                ),
        );
      },
    );
  }

  void _open(HvUpdateError error) {
    final media = LibraryMembership.media(error.mediaTypeIndex, error.mediaId);
    if (media == null) {
      snackBar('This title is no longer in your library');
      return;
    }
    HvNavigation.openDetails(media, ItemType.values[error.mediaTypeIndex]);
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.group});
  final ErrorGroup<HvUpdateError> group;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.errorContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: colors.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: AnymeXText(group.message,
                size: 13, maxLines: 4, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          AnymeXText('${group.items.length}',
              size: 13, variant: TextVariant.bold, color: colors.error),
        ],
      ),
    );
  }
}

class _ErrorTile extends StatelessWidget {
  const _ErrorTile({
    required this.error,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
  });

  final HvUpdateError error;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final poster = error.poster ?? '';
    return ListTile(
      selected: selected,
      selectedTileColor: colors.primaryContainer.withValues(alpha: 0.4),
      onTap: onTap,
      onLongPress: onLongPress,
      leading: SizedBox(
        width: 40,
        height: 56,
        child: poster.isEmpty || poster == '?'
            ? const Icon(Icons.image_not_supported_outlined)
            : AnymeXImage(imageUrl: poster, width: 40, height: 56, radius: 6),
      ),
      title: Text(error.mediaTitle ?? error.mediaId,
          maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text([
        if (error.sourceName != null) error.sourceName!,
        DateFormat.yMMMd()
            .add_jm()
            .format(DateTime.fromMillisecondsSinceEpoch(error.timestamp)),
      ].join(' · ')),
      trailing: selected ? Icon(Icons.check_circle, color: colors.primary) : null,
    );
  }
}
