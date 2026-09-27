import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/controllers/source/source_controller.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/hv/source_link/source_link_repository.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/screens/anime/details_page.dart';
import 'package:anymex/screens/manga/details_page.dart';
import 'package:anymex/screens/novel/details/details_view.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:get/get.dart';

class HvNavigation {
  HvNavigation._();

  /// Opens a stored title's details page, the way the library does.
  static void openDetails(OfflineMedia item, ItemType type) {
    final tag = 'hv-${type.index}-${item.mediaId}';
    final media = Media.fromOfflineMedia(item, type);
    final link = SourceLinkRepository.get(type.index, item.mediaId ?? '');
    if (link != null) {
      // The link knows which service the title was opened from.
      media.serviceType = ServicesType.values[link.serviceIndex];
    }
    switch (type) {
      case ItemType.anime:
        navigate(() => AnimeDetailsPage(media: media, tag: tag));
      case ItemType.manga:
        navigate(() => MangaDetailsPage(media: media, tag: tag));
      case ItemType.novel:
        final sources = Get.find<SourceController>();
        final source = (link != null
                ? sources.findSourceById(link.sourceId, ItemType.novel)
                : null) ??
            ((item.season ?? '').isNotEmpty
                ? sources.getNovelExtensionByName(item.season!)
                : null);
        navigate(
            () => NovelDetailsPage(source: source, media: media, tag: tag));
    }
  }
}
