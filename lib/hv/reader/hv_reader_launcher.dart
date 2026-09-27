import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/controllers/source/source_controller.dart';
import 'package:anymex/controllers/track/track_binding_controller.dart';
import 'package:anymex/database/data_keys/keys.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/source_link/source_link_repository.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/screens/manga/reading_page.dart';
import 'package:anymex/screens/manga/widgets/track_dialog.dart' as manga_track;
import 'package:anymex/screens/novel/reader/novel_reader.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex/widgets/anymex_widgets/anymex_progress.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Opens a chapter of a library title in the manga or novel reader, fetching
/// the chapter list from the title's saved source link.
class HvReaderLauncher {
  HvReaderLauncher._();

  static Future<void> openChapter({
    required String mediaId,
    required int mediaTypeIndex,
    String? chapterLink,
    double? chapterNumber,
    String? fallbackTitle,
    String? fallbackPoster,
  }) async {
    final type = ItemType.values[mediaTypeIndex];
    final link = SourceLinkRepository.get(mediaTypeIndex, mediaId);
    if (link == null) {
      snackBar('This title isn\'t linked to a source yet. Open it once first.');
      return;
    }
    final sources = Get.find<SourceController>();
    final source = sources.findSourceById(link.sourceId, type);
    if (source == null) {
      snackBar('Install ${link.sourceName ?? 'the source'} to read this.');
      return;
    }

    List<Chapter> chapters = const [];
    Get.dialog(
      const Center(child: AnymeXProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final detail =
          await source.methods.getDetail(DMedia.withUrl(link.url));
      chapters = Media.fromDManga(detail, type).altMediaContent ?? const [];
    } catch (e) {
      Logger.e('HV: fetching chapters failed: $e');
    } finally {
      if (Get.isDialogOpen == true) Get.back();
    }
    if (chapters.isEmpty) {
      snackBar('Couldn\'t load chapters from ${source.name}.');
      return;
    }

    final chapter = chapters.firstWhereOrNull(
            (c) => chapterLink != null && c.link == chapterLink) ??
        chapters.firstWhereOrNull(
            (c) => chapterNumber != null && c.number == chapterNumber);
    if (chapter == null) {
      snackBar('That chapter is no longer on ${source.name}.');
      return;
    }

    final offline = LibraryMembership.media(mediaTypeIndex, mediaId);
    final media = offline != null
        ? convertOfflineToMedia(offline)
        : Media(
            id: mediaId,
            title: fallbackTitle ?? '?',
            poster: fallbackPoster ?? '',
            serviceType: ServicesType.values[link.serviceIndex],
          );
    media.mediaType = type;
    // The saved link knows which service the title was opened from; the
    // stored OfflineMedia may not.
    media.serviceType = ServicesType.values[link.serviceIndex];

    // The readers fetch pages through the globally active source.
    sources.setActiveSource(source);

    if (type == ItemType.novel) {
      navigate(() => NovelReader(
            chapter: chapter,
            chapters: chapters,
            media: media,
            source: source,
          ));
      return;
    }

    final shouldTrack = await _shouldTrack(media);
    if (shouldTrack == null) return;
    navigate(() => ReadingPage(
          anilistData: media,
          chapterList: chapters,
          currentChapter: chapter,
          shouldTrack: shouldTrack,
        ));
  }

  /// Same decision the History screen makes before opening the reader.
  static Future<bool?> _shouldTrack(Media media) async {
    final dbId = '${media.id}_${media.serviceType.name}_${media.type}';
    final saved = DynamicKeys.trackingPermission.get<bool?>(dbId);
    if (saved != null) return saved;

    final isExtension = media.serviceType == ServicesType.extensions;
    if (isExtension) {
      return Get.isRegistered<TrackBindingController>() &&
          Get.find<TrackBindingController>().hasAnyBinding(media.id);
    }
    if (General.shouldAskForTrack.get(true) == false) return true;
    if (Get.context != null) {
      return manga_track.showTrackingDialog(Get.context!, dbId: dbId);
    }
    return true;
  }
}
