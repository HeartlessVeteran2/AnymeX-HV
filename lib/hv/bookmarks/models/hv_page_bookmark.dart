import 'package:isar_community/isar.dart';

part 'hv_page_bookmark.g.dart';

/// A bookmarked page (Otaku Reader's page bookmarks).
@collection
class HvPageBookmark {
  Id id = Isar.autoIncrement;

  /// `mediaKey|chapterKey|pageNumber` — one bookmark per page.
  @Index(unique: true, replace: true)
  late String bookmarkKey;

  @Index()
  late String mediaKey;

  late String mediaId;
  late int mediaTypeIndex;
  String? mediaTitle;
  String? poster;

  /// The chapter's link (or local path), used to reopen it.
  late String chapterKey;
  double? chapterNumber;
  String? chapterTitle;

  /// 1-based page number within the chapter.
  late int pageNumber;

  /// The page image, for the thumbnail.
  String? pageUrl;
  List<String>? headerKeys;
  List<String>? headerValues;

  String? note;

  /// `HvBookmarkCollection.id`, or null when not in a collection.
  int? collectionId;

  @Index()
  late int createdAt;

  @ignore
  Map<String, String> get headers {
    final keys = headerKeys ?? const [];
    final values = headerValues ?? const [];
    return {
      for (var i = 0; i < keys.length && i < values.length; i++)
        keys[i]: values[i],
    };
  }
}
