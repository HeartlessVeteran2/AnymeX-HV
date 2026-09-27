import 'package:isar_community/isar.dart';

part 'hv_update_error.g.dart';

/// The latest failed update check for a library title. Replaced on the next
/// failure and removed when the title updates successfully.
@collection
class HvUpdateError {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String mediaKey;

  late String mediaId;
  late int mediaTypeIndex;

  String? mediaTitle;
  String? poster;
  String? sourceId;
  String? sourceName;

  late String message;

  late int timestamp;
}
