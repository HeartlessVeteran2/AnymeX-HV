import 'package:anymex/controllers/offline/offline_storage_controller.dart';
import 'package:anymex/controllers/service_handler/params.dart';
import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/controllers/track/track_binding_controller.dart';
import 'package:anymex/database/data_keys/keys.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/chapters/core/mark_read_planner.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/main.dart' show isar;
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:get/get.dart';

/// Manual read/unread marking for manga and novel chapters.
///
/// Writes `OfflineMedia.readChapters` directly: marking isn't reading, so it
/// doesn't touch the continue-reading chapter or the reading stats.
class HvChapterState {
  HvChapterState._();

  static Future<void> setRead(
    Media media,
    List<Chapter> targets, {
    required bool read,
    List<Chapter>? allChapters,
  }) async {
    if (targets.isEmpty || media.id.isEmpty) return;
    final storage = Get.find<OfflineStorageController>();
    var entry = LibraryMembership.media(media.mediaType.index, media.id);
    if (entry == null) {
      if (!read) return;
      // First time this title is stored: create it the usual way.
      await storage.addOrUpdateManga(media, allChapters, null);
      entry = LibraryMembership.media(media.mediaType.index, media.id);
      if (entry == null) return;
    }
    final stored = entry;
    stored.readChapters =
        planReadChapters(stored.readChapters ?? const [], targets, read: read);
    await isar.writeTxn(() => isar.offlineMedias.put(stored));
    storage.update();
  }

  /// Whether the title is on the user's tracker list (or bound to a tracker
  /// for extension titles).
  static bool isTracked(Media media) {
    if (media.serviceType == ServicesType.extensions) {
      return Get.isRegistered<TrackBindingController>() &&
          Get.find<TrackBindingController>().hasAnyBinding(media.id);
    }
    final auth = Get.find<ServiceHandler>();
    if (!auth.isLoggedIn.value ||
        auth.serviceType.value == ServicesType.extensions) {
      return false;
    }
    return auth.onlineService.mangaList.any((m) => m.id == media.id);
  }

  /// Sets tracker progress to [chapter] the way the reader does after
  /// finishing a chapter — only forward, never backward.
  static Future<bool> pushTrackerProgress(Media media, int chapter) async {
    try {
      final dbId = '${media.id}_${media.serviceType.name}_${media.type}';
      if (DynamicKeys.trackingPermission.get<bool>(dbId, true) == false) {
        return false;
      }
      if (media.serviceType == ServicesType.extensions) {
        if (!isTracked(media)) return false;
        await Get.find<TrackBindingController>()
            .pushProgress(media.id, chapter, isAnime: false, status: 'CURRENT');
        return true;
      }
      final auth = Get.find<ServiceHandler>();
      final item =
          auth.onlineService.mangaList.firstWhereOrNull((m) => m.id == media.id);
      final current = int.tryParse(item?.episodeCount ?? '') ?? 0;
      if (chapter <= current) return false;
      await auth.onlineService.updateListEntry(UpdateListEntryParams(
        listId: media.id,
        status: 'CURRENT',
        progress: chapter,
        syncIds: [media.idMal],
        isAnime: false,
      ));
      return true;
    } catch (e) {
      Logger.e('HV: tracker progress update failed: $e');
      return false;
    }
  }

  /// Read state for display, matching the chapter list's own rule.
  static OfflineMedia? stored(Media media) =>
      LibraryMembership.media(media.mediaType.index, media.id);
}
