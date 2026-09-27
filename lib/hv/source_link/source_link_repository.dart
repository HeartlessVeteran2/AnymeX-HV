import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';
import 'package:anymex/main.dart' show isar;
import 'package:isar_community/isar.dart';

class SourceLinkRepository {
  SourceLinkRepository._();

  static HvSourceLink? get(int mediaTypeIndex, String mediaId) =>
      isar.hvSourceLinks.getByLinkKeySync(hvMediaKey(mediaTypeIndex, mediaId));

  static List<HvSourceLink> ofType(int mediaTypeIndex) => isar.hvSourceLinks
      .filter()
      .mediaTypeIndexEqualTo(mediaTypeIndex)
      .findAllSync();

  static Future<void> save(HvSourceLink link) async {
    link.linkKey = hvMediaKey(link.mediaTypeIndex, link.mediaId);
    await isar.writeTxn(() => isar.hvSourceLinks.putByLinkKey(link));
  }

  static Future<void> remove(int mediaTypeIndex, String mediaId) async {
    await isar.writeTxn(() => isar.hvSourceLinks
        .deleteByLinkKey(hvMediaKey(mediaTypeIndex, mediaId)));
  }
}
