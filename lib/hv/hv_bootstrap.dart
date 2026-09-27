import 'package:anymex/hv/library_update/library_update_service.dart';
import 'package:anymex/hv/library_update/models/hv_chapter_update.dart';
import 'package:anymex/hv/library_update/models/hv_update_error.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

/// Wiring for the HV features: their Isar collections (added to the
/// `AnymeX` instance in `lib/database/database.dart`) and their services
/// (registered from `lib/main.dart`).
class HvBootstrap {
  HvBootstrap._();

  static List<CollectionSchema<dynamic>> get isarSchemas => [
        HvSourceLinkSchema,
        HvChapterUpdateSchema,
        HvUpdateErrorSchema,
      ];

  static void registerControllers() {
    if (!Get.isRegistered<LibraryUpdateService>()) {
      Get.put(LibraryUpdateService(), permanent: true);
    }
  }
}
