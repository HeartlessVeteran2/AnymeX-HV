import 'package:anymex/controllers/offline/offline_storage_controller.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/common/read_state.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/library_update/core/update_grouping.dart';
import 'package:anymex/hv/library_update/library_update_service.dart';
import 'package:anymex/hv/library_update/models/hv_chapter_update.dart';
import 'package:anymex/hv/library_update/models/hv_update_error.dart';
import 'package:anymex/hv/library_update/ui/update_progress_banner.dart';
import 'package:anymex/hv/library_update/update_repository.dart';
import 'package:anymex/hv/reader/hv_reader_launcher.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_image.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_text.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// New chapters found in the library, grouped by day and title (Komikku's
/// Updates tab).
class HvUpdatesScreen extends StatelessWidget {
  const HvUpdatesScreen({super.key});

  Future<void> _runUpdate() async {
    final result = await LibraryUpdateService.to.run();
    if (result == null) return;
    final parts = <String>[
      result.newChapters == 0
          ? 'No new chapters'
          : '${result.newChapters} new chapter${result.newChapters == 1 ? '' : 's'}',
      if (result.failed + result.skipped > 0)
        '${result.failed + result.skipped} couldn\'t be checked',
    ];
    snackBar(parts.join(' · '));
  }

  @override
  Widget build(BuildContext context) {
    final service = LibraryUpdateService.to;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates'),
        actions: [
          StreamBuilder<List<HvUpdateError>>(
            stream: UpdateRepository.watchErrors(),
            builder: (context, snapshot) {
              final errors = snapshot.data ?? const <HvUpdateError>[];
              if (errors.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Update errors',
                onPressed: () => _showErrors(context, errors),
                icon: Badge(
                  label: Text('${errors.length}'),
                  child: const Icon(Icons.error_outline_rounded),
                ),
              );
            },
          ),
          Obx(() => IconButton(
                tooltip: service.running.value ? 'Stop' : 'Check for updates',
                onPressed:
                    service.running.value ? service.cancel : () => _runUpdate(),
                icon: Icon(service.running.value
                    ? Icons.stop_circle_outlined
                    : Icons.refresh_rounded),
              )),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'clear') await UpdateRepository.dismissAll();
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'clear', child: Text('Clear all')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const HvUpdateProgressBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _runUpdate,
              child: StreamBuilder<List<HvChapterUpdate>>(
                stream: UpdateRepository.watchVisible(),
                builder: (context, snapshot) {
                  final updates = snapshot.data ?? const <HvChapterUpdate>[];
                  if (updates.isEmpty) return const _EmptyUpdates();
                  final days = groupUpdates<HvChapterUpdate>(
                    updates,
                    foundAt: (u) => u.foundAt,
                    mediaKey: (u) => u.mediaKey,
                    chapterNumber: (u) => u.chapterNumber,
                  );
                  return GetBuilder<OfflineStorageController>(
                    builder: (storage) => ListView(
                      padding: const EdgeInsets.only(bottom: 120),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        for (final day in days) ...[
                          _DayHeader(day.day),
                          for (final title in day.titles)
                            _TitleUpdates(
                              updates: title.items,
                              saved: LibraryMembership.media(
                                  title.items.first.mediaTypeIndex,
                                  title.items.first.mediaId),
                            ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrors(BuildContext context, List<HvUpdateError> errors) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (context, controller) => Column(
          children: [
            ListTile(
              title: Text('${errors.length} titles couldn\'t be checked'),
              trailing: TextButton(
                onPressed: () async {
                  await UpdateRepository.clearErrors(errors.map((e) => e.id));
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Clear'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: errors.length,
                itemBuilder: (context, i) {
                  final error = errors[i];
                  return ListTile(
                    leading: _Poster(error.poster, size: 40),
                    title: Text(error.mediaTitle ?? error.mediaId,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(
                      [
                        if (error.sourceName != null) error.sourceName!,
                        error.message,
                      ].join(' · '),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyUpdates extends StatelessWidget {
  const _EmptyUpdates();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final lastRun = HvKeys.hvLastUpdateRunAt.get<int>(0);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(32),
      children: [
        const SizedBox(height: 80),
        Icon(Icons.new_releases_outlined,
            size: 64, color: colors.onSurface.withValues(alpha: 0.25)),
        const SizedBox(height: 16),
        const AnymeXText('No new chapters',
            size: 16, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        AnymeXText(
          'Pull down to check your manga and novel library for new chapters.'
          '${lastRun > 0 ? '\nLast checked ${DateFormat.yMMMd().add_jm().format(DateTime.fromMillisecondsSinceEpoch(lastRun))}.' : ''}',
          size: 13,
          textAlign: TextAlign.center,
          color: colors.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader(this.day);
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final label = day == today
        ? 'Today'
        : day == today.subtract(const Duration(days: 1))
            ? 'Yesterday'
            : DateFormat.yMMMMd().format(day);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: AnymeXText(
        label,
        size: 13,
        variant: TextVariant.semiBold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _TitleUpdates extends StatelessWidget {
  const _TitleUpdates({required this.updates, required this.saved});

  final List<HvChapterUpdate> updates;
  final OfflineMedia? saved;

  @override
  Widget build(BuildContext context) {
    final first = updates.first;
    final colors = Theme.of(context).colorScheme;
    final savedChapters = <HvSavedChapter>[
      for (final c in saved?.readChapters ?? const [])
        (link: c.link, number: c.number, page: c.pageNumber, total: c.totalPages),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Poster(first.poster ?? saved?.poster, size: 56),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnymeXText(
                      first.mediaTitle ?? saved?.displayTitle ?? '?',
                      size: 14,
                      variant: TextVariant.semiBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (first.sourceName != null)
                      AnymeXText(first.sourceName!,
                          size: 11,
                          color: colors.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(height: 4),
                    for (final update in updates)
                      _ChapterRow(
                        update: update,
                        read: hvIsChapterRead(savedChapters,
                            link: update.chapterLink,
                            number: update.chapterNumber),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChapterRow extends StatelessWidget {
  const _ChapterRow({required this.update, required this.read});

  final HvChapterUpdate update;
  final bool read;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final number = update.chapterNumber;
    final label = [
      if (number != null)
        'Chapter ${number % 1 == 0 ? number.toInt() : number}',
      if ((update.chapterTitle ?? '').isNotEmpty) update.chapterTitle!,
    ].join(' · ');
    return Dismissible(
      key: ValueKey(update.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 12),
        color: colors.errorContainer,
        child: Icon(Icons.visibility_off_outlined,
            color: colors.onErrorContainer),
      ),
      onDismissed: (_) => UpdateRepository.dismiss([update.id]),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => HvReaderLauncher.openChapter(
          mediaId: update.mediaId,
          mediaTypeIndex: update.mediaTypeIndex,
          chapterLink: update.chapterLink,
          chapterNumber: update.chapterNumber,
          fallbackTitle: update.mediaTitle,
          fallbackPoster: update.poster,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: AnymeXText(
                  label.isEmpty ? 'New chapter' : label,
                  size: 13,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: read
                      ? colors.onSurface.withValues(alpha: 0.45)
                      : colors.onSurface,
                ),
              ),
              if (read)
                Icon(Icons.done_rounded,
                    size: 16, color: colors.onSurface.withValues(alpha: 0.45)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster(this.url, {required this.size});
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    final image = url ?? '';
    if (image.isEmpty || image == '?') {
      return SizedBox(
        width: size,
        height: size * 1.4,
        child: const Icon(Icons.image_not_supported_outlined),
      );
    }
    return AnymeXImage(
      imageUrl: image,
      width: size,
      height: size * 1.4,
      radius: 6,
    );
  }
}
