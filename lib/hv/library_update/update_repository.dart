import 'package:anymex/hv/library_update/models/hv_chapter_update.dart';
import 'package:anymex/hv/library_update/models/hv_update_error.dart';
import 'package:anymex/main.dart' show isar;
import 'package:isar_community/isar.dart';

class UpdateRepository {
  UpdateRepository._();

  /// Updates older than this are pruned after each run.
  static const Duration keepFor = Duration(days: 90);

  /// Saves [updates] and returns the ones that were actually new.
  static Future<List<HvChapterUpdate>> addUpdates(
      List<HvChapterUpdate> updates) async {
    if (updates.isEmpty) return const [];
    final added = <HvChapterUpdate>[];
    await isar.writeTxn(() async {
      for (final update in updates) {
        // A chapter already recorded (e.g. by a details refresh) keeps its
        // original date and dismissed state.
        final existing =
            await isar.hvChapterUpdates.getByUpdateKey(update.updateKey);
        if (existing != null) continue;
        await isar.hvChapterUpdates.put(update);
        added.add(update);
      }
    });
    return added;
  }

  /// Visible (not dismissed) updates, newest first; re-emits on every change.
  static Stream<List<HvChapterUpdate>> watchVisible() => isar.hvChapterUpdates
      .filter()
      .dismissedEqualTo(false)
      .sortByFoundAtDesc()
      .watch(fireImmediately: true);

  static int visibleCount() =>
      isar.hvChapterUpdates.filter().dismissedEqualTo(false).countSync();

  static Future<void> dismiss(Iterable<int> ids) async {
    await isar.writeTxn(() async {
      for (final id in ids) {
        final update = await isar.hvChapterUpdates.get(id);
        if (update == null) continue;
        update.dismissed = true;
        await isar.hvChapterUpdates.put(update);
      }
    });
  }

  static Future<void> dismissAll() async {
    final ids = await isar.hvChapterUpdates
        .filter()
        .dismissedEqualTo(false)
        .idProperty()
        .findAll();
    await dismiss(ids);
  }

  static Future<void> prune() async {
    final cutoff = DateTime.now().subtract(keepFor).millisecondsSinceEpoch;
    await isar.writeTxn(() =>
        isar.hvChapterUpdates.filter().foundAtLessThan(cutoff).deleteAll());
  }

  static Future<void> setError(HvUpdateError error) async {
    await isar.writeTxn(() => isar.hvUpdateErrors.putByMediaKey(error));
  }

  static Future<void> clearError(String mediaKey) async {
    await isar.writeTxn(() => isar.hvUpdateErrors.deleteByMediaKey(mediaKey));
  }

  static Stream<List<HvUpdateError>> watchErrors() => isar.hvUpdateErrors
      .where()
      .sortByTimestampDesc()
      .watch(fireImmediately: true);

  static Future<void> clearErrors(Iterable<int> ids) async {
    await isar.writeTxn(() => isar.hvUpdateErrors.deleteAll(ids.toList()));
  }
}
