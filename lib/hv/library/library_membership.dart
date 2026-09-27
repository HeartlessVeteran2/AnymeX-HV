import 'package:anymex/database/isar_models/custom_list.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/main.dart' show isar;
import 'package:isar_community/isar.dart';

/// Which titles are "in the library": AnymeX keeps every opened title as an
/// `OfflineMedia` row (that's also the history), and a title is in the
/// library when it belongs to at least one custom list of its type.
class LibraryMembership {
  LibraryMembership._();

  static Set<String> idsOfType(int mediaTypeIndex) {
    final lists = isar.customLists
        .filter()
        .mediaTypeIndexEqualTo(mediaTypeIndex)
        .findAllSync();
    return {
      for (final list in lists)
        for (final id in list.mediaIds ?? const <String>[])
          if (id.isNotEmpty) id,
    };
  }

  static bool contains(int mediaTypeIndex, String mediaId) =>
      idsOfType(mediaTypeIndex).contains(mediaId);

  /// The stored title of this type and id. `OfflineStorageController`'s
  /// `getMediaById` ignores the type, and MAL anime and manga ids overlap.
  static OfflineMedia? media(int mediaTypeIndex, String mediaId) =>
      isar.offlineMedias
          .where()
          .mediaTypeIndexMediaIdEqualTo(mediaTypeIndex, mediaId)
          .findFirstSync();
}
