import 'package:isar_community/isar.dart';

part 'hv_bookmark_collection.g.dart';

/// A named group of page bookmarks.
@collection
class HvBookmarkCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: false)
  late String name;

  late int createdAt;
}
