import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/chapters/chapter_state_repository.dart';
import 'package:anymex/hv/chapters/core/chapter_filters.dart';
import 'package:anymex/hv/chapters/core/mark_read_planner.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/common/read_state.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Hooks for the manga/novel chapter list (`chapter_list_builder.dart`):
/// read/downloaded filters and order, and long-press chapter actions.
class HvChapterListHooks {
  HvChapterListHooks._();

  static final Map<String, Rx<HvChapterListPrefs>> _prefs = {};

  static String _key(Media media) =>
      hvMediaKey(media.mediaType.index, media.id);

  /// Per-title list preferences; reading `.value` inside an `Obx` rebuilds
  /// the list when they change.
  static Rx<HvChapterListPrefs> prefsFor(Media media) {
    final key = _key(media);
    return _prefs.putIfAbsent(key, () {
      final json = KvHelper.get<Map<String, dynamic>>('hvChapterPrefs_$key',
          defaultVal: const {});
      return HvChapterListPrefs.fromJson(json).obs;
    });
  }

  static void setPrefs(Media media, HvChapterListPrefs prefs) {
    prefsFor(media).value = prefs;
    KvHelper.set('hvChapterPrefs_${_key(media)}', prefs.toJson());
  }

  /// Same rule the chapter tiles use: the saved page is complete, or the
  /// tracker's progress is at or past the chapter.
  static bool isRead(Chapter c, OfflineMedia? saved, int? onlineProgress) {
    if (onlineProgress != null &&
        c.number != null &&
        c.number! <= onlineProgress) {
      return true;
    }
    return hvIsChapterRead(
      [
        for (final r in saved?.readChapters ?? const <Chapter>[])
          (link: r.link, number: r.number, page: r.pageNumber, total: r.totalPages),
      ],
      link: c.link,
      number: c.number,
    );
  }

  /// Filters and orders the (scanlator-filtered) chapter list.
  static List<Chapter> apply(
    Media? media,
    List<Chapter> chapters, {
    OfflineMedia? saved,
    int? onlineProgress,
    Set<double?> downloadedNumbers = const {},
  }) {
    if (media == null) return chapters;
    return applyChapterPrefs<Chapter>(
      chapters,
      prefsFor(media).value,
      isRead: (c) => isRead(c, saved, onlineProgress),
      isDownloaded: (c) => downloadedNumbers.contains(c.number),
    );
  }

  /// Wraps a chapter tile so a long press opens the chapter actions.
  static Widget wrap({
    required BuildContext context,
    required Media? media,
    required Chapter chapter,
    required List<Chapter> allChapters,
    required int? onlineProgress,
    required VoidCallback onDownload,
    required Widget child,
  }) {
    if (media == null) return child;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () => _showActions(
          context, media, chapter, allChapters, onlineProgress, onDownload),
      child: child,
    );
  }

  static void _showActions(
    BuildContext context,
    Media media,
    Chapter chapter,
    List<Chapter> all,
    int? onlineProgress,
    VoidCallback onDownload,
  ) {
    final read = isRead(chapter, HvChapterState.stored(media), onlineProgress);
    final number = chapter.number;
    final label = number == null
        ? (chapter.title ?? 'Chapter')
        : 'Chapter ${chapter.formattedNumber}';
    final tracked = HvChapterState.isTracked(media);
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: (chapter.title ?? '').isNotEmpty && number != null
                  ? Text(chapter.title!,
                      maxLines: 1, overflow: TextOverflow.ellipsis)
                  : null,
            ),
            const Divider(height: 1),
            ListTile(
              leading: Icon(read
                  ? Icons.remove_done_rounded
                  : Icons.done_rounded),
              title: Text(read ? 'Mark as unread' : 'Mark as read'),
              subtitle: read &&
                      onlineProgress != null &&
                      number != null &&
                      number <= onlineProgress
                  ? const Text('Your tracker progress still counts it as read')
                  : null,
              onTap: () async {
                Navigator.pop(sheet);
                await HvChapterState.setRead(media, [chapter],
                    read: !read, allChapters: all);
              },
            ),
            if (number != null)
              ListTile(
                leading: const Icon(Icons.done_all_rounded),
                title: const Text('Mark this and previous as read'),
                onTap: () async {
                  Navigator.pop(sheet);
                  await HvChapterState.setRead(
                      media, chaptersUpTo(all, chapter),
                      read: true, allChapters: all);
                },
              ),
            if (number != null && tracked)
              ListTile(
                leading: const Icon(Icons.sync_rounded),
                title: Text('Set tracker progress to ${number.toInt()}'),
                onTap: () async {
                  Navigator.pop(sheet);
                  final pushed = await HvChapterState.pushTrackerProgress(
                      media, number.toInt());
                  snackBar(pushed
                      ? 'Tracker updated'
                      : 'Tracker is already at or past this chapter');
                },
              ),
            ListTile(
              leading: const Icon(Icons.file_download_outlined),
              title: const Text('Download'),
              onTap: () {
                Navigator.pop(sheet);
                onDownload();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Header button next to the download button: filters, order and bulk
/// marking for the whole chapter list.
class HvChapterFilterButton extends StatelessWidget {
  const HvChapterFilterButton({
    super.key,
    required this.media,
    required this.chapters,
  });

  final Media? media;
  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    final media = this.media;
    if (media == null) return const SizedBox.shrink();
    final colors = Theme.of(context).colorScheme;
    return Obx(() {
      final active = !HvChapterListHooks.prefsFor(media).value.isDefault;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showSheet(context, media),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: active
                  ? colors.primaryContainer
                  : colors.surfaceContainerHighest.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.outline.withValues(alpha: 0.15)),
            ),
            child: Icon(Icons.filter_list_rounded,
                size: 16, color: colors.primary),
          ),
        ),
      );
    });
  }

  void _showSheet(BuildContext context, Media media) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheet) => SafeArea(
        child: Obx(() {
          final prefs = HvChapterListHooks.prefsFor(media).value;
          void set(HvChapterListPrefs p) => HvChapterListHooks.setPrefs(media, p);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SegmentedButton<HvReadFilter>(
                  segments: const [
                    ButtonSegment(value: HvReadFilter.all, label: Text('All')),
                    ButtonSegment(
                        value: HvReadFilter.unread, label: Text('Unread')),
                    ButtonSegment(value: HvReadFilter.read, label: Text('Read')),
                  ],
                  selected: {prefs.readFilter},
                  onSelectionChanged: (s) =>
                      set(prefs.copyWith(readFilter: s.first)),
                ),
              ),
              SwitchListTile(
                title: const Text('Downloaded only'),
                value: prefs.downloadedOnly,
                onChanged: (v) => set(prefs.copyWith(downloadedOnly: v)),
              ),
              SwitchListTile(
                title: const Text('Newest first'),
                value: prefs.newestFirst,
                onChanged: (v) => set(prefs.copyWith(newestFirst: v)),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.done_all_rounded),
                title: const Text('Mark all as read'),
                onTap: () async {
                  Navigator.pop(sheet);
                  await HvChapterState.setRead(media, chapters,
                      read: true, allChapters: chapters);
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_done_rounded),
                title: const Text('Mark all as unread'),
                onTap: () async {
                  Navigator.pop(sheet);
                  await HvChapterState.setRead(media, chapters,
                      read: false, allChapters: chapters);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
