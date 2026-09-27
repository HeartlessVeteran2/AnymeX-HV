import 'package:isar_community/isar.dart';

part 'hv_chapter_update.g.dart';

/// A chapter the library update checker (or a details page refresh) found
/// that wasn't on the source before. Shown on the Updates screen.
@collection
class HvChapterUpdate {
  Id id = Isar.autoIncrement;

  /// `mediaKey|chapterKey` — one row per new chapter.
  @Index(unique: true, replace: true)
  late String updateKey;

  @Index()
  late String mediaKey;

  late String mediaId;
  late int mediaTypeIndex;

  String? mediaTitle;
  String? poster;

  late String sourceId;
  String? sourceName;

  String? chapterTitle;
  double? chapterNumber;
  String? chapterLink;
  String? scanlator;
  String? releaseDate;

  @Index()
  late int foundAt;

  /// Hidden from the Updates screen by the user.
  bool dismissed = false;
}
