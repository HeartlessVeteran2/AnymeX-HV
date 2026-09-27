import 'package:anymex/hv/bookmarks/models/hv_bookmark_collection.dart';
import 'package:anymex/hv/bookmarks/models/hv_page_bookmark.dart';
import 'package:anymex/hv/bookmarks/models/hv_reader_note.dart';
import 'package:anymex/main.dart' show isar;
import 'package:isar_community/isar.dart';

String hvBookmarkKey(String mediaKey, String chapterKey, int pageNumber) =>
    '$mediaKey|$chapterKey|$pageNumber';

String hvNoteKey(String mediaKey, String? chapterKey) =>
    '$mediaKey|${chapterKey ?? ''}';

class BookmarkRepository {
  BookmarkRepository._();

  // ---- bookmarks ----------------------------------------------------------

  static bool isBookmarked(String key) =>
      isar.hvPageBookmarks.getByBookmarkKeySync(key) != null;

  /// Adds the bookmark, or removes it when that page is already bookmarked.
  /// Returns true when the page is bookmarked afterwards.
  static Future<bool> toggle(HvPageBookmark bookmark) async {
    var added = false;
    await isar.writeTxn(() async {
      final existing =
          await isar.hvPageBookmarks.getByBookmarkKey(bookmark.bookmarkKey);
      if (existing != null) {
        await isar.hvPageBookmarks.delete(existing.id);
      } else {
        await isar.hvPageBookmarks.put(bookmark);
        added = true;
      }
    });
    return added;
  }

  static Stream<List<HvPageBookmark>> watchAll() => isar.hvPageBookmarks
      .where()
      .sortByCreatedAtDesc()
      .watch(fireImmediately: true);

  static Stream<List<HvPageBookmark>> watchForMedia(String mediaKey) => isar
      .hvPageBookmarks
      .filter()
      .mediaKeyEqualTo(mediaKey)
      .watch(fireImmediately: true);

  static Future<void> delete(Iterable<int> ids) async {
    await isar.writeTxn(() => isar.hvPageBookmarks.deleteAll(ids.toList()));
  }

  static Future<void> setNote(int id, String? note) async {
    await isar.writeTxn(() async {
      final b = await isar.hvPageBookmarks.get(id);
      if (b == null) return;
      b.note = (note ?? '').trim().isEmpty ? null : note!.trim();
      await isar.hvPageBookmarks.put(b);
    });
  }

  static Future<void> setCollection(Iterable<int> ids, int? collectionId) async {
    await isar.writeTxn(() async {
      for (final id in ids) {
        final b = await isar.hvPageBookmarks.get(id);
        if (b == null) continue;
        b.collectionId = collectionId;
        await isar.hvPageBookmarks.put(b);
      }
    });
  }

  // ---- collections --------------------------------------------------------

  static Stream<List<HvBookmarkCollection>> watchCollections() => isar
      .hvBookmarkCollections
      .where()
      .sortByName()
      .watch(fireImmediately: true);

  /// Returns the collection with [name], creating it when missing.
  static Future<HvBookmarkCollection> createCollection(String name) async {
    final trimmed = name.trim();
    late HvBookmarkCollection result;
    await isar.writeTxn(() async {
      final existing = await isar.hvBookmarkCollections.getByName(trimmed);
      if (existing != null) {
        result = existing;
        return;
      }
      result = HvBookmarkCollection()
        ..name = trimmed
        ..createdAt = DateTime.now().millisecondsSinceEpoch;
      result.id = await isar.hvBookmarkCollections.put(result);
    });
    return result;
  }

  /// Deletes a collection; its bookmarks stay, outside any collection.
  static Future<void> deleteCollection(int id) async {
    await isar.writeTxn(() async {
      final members = await isar.hvPageBookmarks
          .filter()
          .collectionIdEqualTo(id)
          .findAll();
      for (final b in members) {
        b.collectionId = null;
      }
      await isar.hvPageBookmarks.putAll(members);
      await isar.hvBookmarkCollections.delete(id);
    });
  }

  // ---- notes --------------------------------------------------------------

  static String noteText(String noteKey) =>
      isar.hvReaderNotes.getByNoteKeySync(noteKey)?.text ?? '';

  /// Saves a note; an empty note is deleted.
  static Future<void> saveNote({
    required String mediaKey,
    String? chapterKey,
    double? chapterNumber,
    required String text,
  }) async {
    final key = hvNoteKey(mediaKey, chapterKey);
    final trimmed = text.trim();
    await isar.writeTxn(() async {
      if (trimmed.isEmpty) {
        await isar.hvReaderNotes.deleteByNoteKey(key);
        return;
      }
      await isar.hvReaderNotes.putByNoteKey(HvReaderNote()
        ..noteKey = key
        ..mediaKey = mediaKey
        ..chapterKey = chapterKey
        ..chapterNumber = chapterNumber
        ..text = trimmed
        ..updatedAt = DateTime.now().millisecondsSinceEpoch);
    });
  }
}
