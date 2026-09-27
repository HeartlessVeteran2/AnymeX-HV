import 'package:isar_community/isar.dart';

part 'hv_reader_note.g.dart';

/// A private note on a chapter or on a whole series.
@collection
class HvReaderNote {
  Id id = Isar.autoIncrement;

  /// `mediaKey|chapterKey`, or `mediaKey|` for the series note.
  @Index(unique: true, replace: true)
  late String noteKey;

  @Index()
  late String mediaKey;

  String? chapterKey;
  double? chapterNumber;

  late String text;
  late int updatedAt;
}
