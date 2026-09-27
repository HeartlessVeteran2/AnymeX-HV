import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/library_update/core/update_filter.dart';
import 'package:anymex/hv/library_update/update_settings.dart';
import 'package:anymex/hv/notifications/hv_notifications.dart';
import 'package:anymex/main.dart' show isar;
import 'package:anymex/widgets/anymex_widgets/anymex_section_builder.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_tile.dart';
import 'package:anymex/widgets/common/anymex_scaffold.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';

/// Settings for the library update checker and auto-download.
class HvUpdateSettingsScreen extends StatefulWidget {
  const HvUpdateSettingsScreen({super.key});

  @override
  State<HvUpdateSettingsScreen> createState() => _HvUpdateSettingsScreenState();
}

class _HvUpdateSettingsScreenState extends State<HvUpdateSettingsScreen> {
  static String _intervalLabel(int hours) => switch (hours) {
        0 => 'Off',
        168 => 'Weekly',
        48 => 'Every 2 days',
        24 => 'Daily',
        _ => 'Every $hours h',
      };

  static String _typeLabel(int typeIndex) => switch (ItemType.values[typeIndex]) {
        ItemType.manga => 'Manga',
        ItemType.novel => 'Novel',
        ItemType.anime => 'Anime',
      };

  List<String> _allListKeys() {
    final lists = isar.customLists.where().findAllSync();
    final keys = [
      for (final list in lists)
        if ((list.listName ?? '').isNotEmpty)
          listKey(list.mediaTypeIndex, list.listName!),
    ];
    keys.sort();
    return keys;
  }

  String _listLabel(String key) {
    final sep = key.indexOf('|');
    final type = int.tryParse(key.substring(0, sep)) ?? 0;
    return '${key.substring(sep + 1)} (${_typeLabel(type)})';
  }

  Future<void> _pickLists({
    required String title,
    required String hint,
    required Set<String> current,
    required ValueChanged<Set<String>> onSave,
  }) async {
    final all = _allListKeys();
    final chosen = {...current};
    final result = await showDialog<Set<String>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: 400,
            child: all.isEmpty
                ? const Text('You have no lists yet.')
                : ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(hint,
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      for (final key in all)
                        CheckboxListTile(
                          value: chosen.contains(key),
                          title: Text(_listLabel(key)),
                          onChanged: (v) => setDialogState(() {
                            if (v == true) {
                              chosen.add(key);
                            } else {
                              chosen.remove(key);
                            }
                          }),
                        ),
                    ],
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, chosen),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (result != null) setState(() => onSave(result));
  }

  String _listsSummary(Set<String> keys, String emptyText) => keys.isEmpty
      ? emptyText
      : keys.map(_listLabel).join(', ');

  @override
  Widget build(BuildContext context) {
    return AnymeXScaffold(
      showHeader: true,
      headerTitle: 'Updates & Downloads',
      body: Builder(
        builder: (ctx) => SingleChildScrollView(
          padding:
              EdgeInsets.fromLTRB(16.0, AnymeXHeaderScope.of(ctx), 16.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnymeXSectionBuilder(
                title: 'Automatic checks',
                children: [
                  AnymeXTile.segmented<int>(
                    icon: Icons.update_rounded,
                    title: 'Check for new chapters',
                    subtitle: 'While the app is open',
                    value: LibraryUpdateSettings.intervalChoices
                            .contains(LibraryUpdateSettings.autoHours)
                        ? LibraryUpdateSettings.autoHours
                        : 24,
                    options: LibraryUpdateSettings.intervalChoices,
                    optionLabelTransformer: _intervalLabel,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.autoHours = v),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.wifi_rounded,
                    title: 'Only on Wi-Fi',
                    subtitle: 'Automatic checks wait for Wi-Fi or Ethernet',
                    value: LibraryUpdateSettings.wifiOnly,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.wifiOnly = v),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.notifications_active_outlined,
                    title: 'Notify about new chapters',
                    subtitle: HvNotifications.supported
                        ? 'After automatic checks'
                        : 'Shown inside the app on this platform',
                    value: LibraryUpdateSettings.notify,
                    onChanged: (v) async {
                      setState(() => LibraryUpdateSettings.notify = v);
                      if (v && !await HvNotifications.requestPermission() &&
                          HvNotifications.supported) {
                        snackBar('Notifications are turned off for AnymeX');
                      }
                    },
                  ),
                ],
              ),
              AnymeXSectionBuilder(
                title: 'What to check',
                children: [
                  AnymeXTile.toggle(
                    icon: Icons.menu_book_rounded,
                    title: 'Manga',
                    value: LibraryUpdateSettings.manga,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.manga = v),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.chrome_reader_mode_outlined,
                    title: 'Novels',
                    value: LibraryUpdateSettings.novel,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.novel = v),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.movie_outlined,
                    title: 'Anime',
                    subtitle: 'New episodes on the linked extension source',
                    value: LibraryUpdateSettings.anime,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.anime = v),
                  ),
                  AnymeXTile(
                    icon: Icons.playlist_add_check_rounded,
                    title: 'Only these lists',
                    subtitle: _listsSummary(
                        LibraryUpdateSettings.includeLists, 'All lists'),
                    onTap: () => _pickLists(
                      title: 'Only these lists',
                      hint: 'Leave empty to check every list.',
                      current: LibraryUpdateSettings.includeLists,
                      onSave: (v) => LibraryUpdateSettings.includeLists = v,
                    ),
                  ),
                  AnymeXTile(
                    icon: Icons.playlist_remove_rounded,
                    title: 'Never these lists',
                    subtitle:
                        _listsSummary(LibraryUpdateSettings.excludeLists, 'None'),
                    onTap: () => _pickLists(
                      title: 'Never these lists',
                      hint: 'Titles in these lists are never checked.',
                      current: LibraryUpdateSettings.excludeLists,
                      onSave: (v) => LibraryUpdateSettings.excludeLists = v,
                    ),
                  ),
                ],
              ),
              AnymeXSectionBuilder(
                title: 'Skip titles that are',
                children: [
                  AnymeXTile.toggle(
                    icon: Icons.done_all_rounded,
                    title: 'Completed',
                    value: LibraryUpdateSettings.skipCompleted,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.skipCompleted = v),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.bookmark_border_rounded,
                    title: 'Not started',
                    value: LibraryUpdateSettings.skipNotStarted,
                    onChanged: (v) => setState(
                        () => LibraryUpdateSettings.skipNotStarted = v),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.mark_email_unread_outlined,
                    title: 'Behind (have unread chapters)',
                    value: LibraryUpdateSettings.skipUnread,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.skipUnread = v),
                  ),
                ],
              ),
              AnymeXSectionBuilder(
                title: 'Downloads',
                children: [
                  AnymeXTile.toggle(
                    icon: Icons.download_for_offline_outlined,
                    title: 'Download new chapters',
                    subtitle: 'Manga only, up to 5 per title per check',
                    value: LibraryUpdateSettings.autoDownload,
                    onChanged: (v) =>
                        setState(() => LibraryUpdateSettings.autoDownload = v),
                  ),
                  if (LibraryUpdateSettings.autoDownload)
                    AnymeXTile(
                      icon: Icons.playlist_play_rounded,
                      title: 'Download from these lists',
                      subtitle: _listsSummary(
                          LibraryUpdateSettings.autoDownloadLists,
                          'Whole library'),
                      onTap: () => _pickLists(
                        title: 'Download from these lists',
                        hint: 'Leave empty to download for the whole library.',
                        current: LibraryUpdateSettings.autoDownloadLists,
                        onSave: (v) =>
                            LibraryUpdateSettings.autoDownloadLists = v,
                      ),
                    ),
                ],
              ),
              AnymeXSectionBuilder(
                title: 'While reading',
                children: [
                  AnymeXTile.segmented<int>(
                    icon: Icons.downloading_rounded,
                    title: 'Download ahead',
                    subtitle: 'Next chapters to download once you are 80% '
                        'through a chapter',
                    value: HvKeys.hvDownloadAhead.get<int>(0).clamp(0, 5),
                    options: const [0, 1, 2, 3, 5],
                    optionLabelTransformer: (v) => v == 0 ? 'Off' : '$v',
                    onChanged: (v) =>
                        setState(() => HvKeys.hvDownloadAhead.set(v)),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.wifi_rounded,
                    title: 'Download ahead only on Wi-Fi',
                    value: HvKeys.hvDownloadAheadWifiOnly.get<bool>(true),
                    onChanged: (v) => setState(
                        () => HvKeys.hvDownloadAheadWifiOnly.set(v)),
                  ),
                  AnymeXTile.toggle(
                    icon: Icons.auto_delete_outlined,
                    title: 'Delete downloads after reading',
                    subtitle: 'Titles can override this in the reader settings',
                    value: HvKeys.hvDeleteAfterRead.get<bool>(false),
                    onChanged: (v) =>
                        setState(() => HvKeys.hvDeleteAfterRead.set(v)),
                  ),
                  if (HvKeys.hvDeleteAfterRead.get<bool>(false))
                    AnymeXTile.segmented<int>(
                      icon: Icons.history_rounded,
                      title: 'Keep the last read chapters',
                      subtitle: 'Read chapters to keep before deleting',
                      value: HvKeys.hvDeleteAfterReadKeep.get<int>(0).clamp(0, 4),
                      options: const [0, 1, 2, 3, 4],
                      onChanged: (v) =>
                          setState(() => HvKeys.hvDeleteAfterReadKeep.set(v)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
