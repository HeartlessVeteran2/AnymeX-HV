import 'package:isar_community/isar.dart';

part 'hv_source_link.g.dart';

/// Which extension source (and which entry on it) a library title reads from.
///
/// AnymeX re-searches the source every time a details page opens and only
/// remembers the source id and, after a manual pick, the matched title. This
/// record keeps the resolved URL so the details page can skip the search and
/// the library update checker can fetch chapters without the UI.
///
/// One link per title (`linkKey` = media type + media id): the source the
/// title was last opened with.
@collection
class HvSourceLink {
  Id id = Isar.autoIncrement;

  /// `hvMediaKey(mediaTypeIndex, mediaId)`.
  @Index(unique: true, replace: true)
  late String linkKey;

  @Index()
  late String mediaId;

  late int mediaTypeIndex;

  /// `ServicesType.index` of the media when it was linked (the service the
  /// details page showed it from).
  late int serviceIndex;

  late String sourceId;
  String? sourceName;

  /// The entry's URL on the source, as passed to `getDetail`.
  late String url;

  /// The entry's title on the source.
  String? title;

  /// True when the user picked this entry themselves (wrong-title sheet) or the
  /// title was opened straight from the source.
  bool userConfirmed = false;

  /// Title-match score when the link came from an automatic search (0..1).
  double matchScore = 0;

  int linkedAt = 0;

  /// Chapter keys seen on the source so far (see `chapterKey`). Empty until
  /// the first check, which records the baseline.
  List<String> knownChapterKeys = [];

  int? lastCheckedAt;

  /// Highest chapter (or episode) number on the source at the last check.
  /// Used to tell how far behind the reader is: [knownChapterKeys] is a
  /// union of every URL ever seen, across scanlators, so its length isn't a
  /// chapter count.
  double? latestChapterNumber;
  int? lastNewChapterAt;

  /// Whether the details page and the update checker may use this link
  /// without searching again.
  @ignore
  bool get isTrusted => userConfirmed || matchScore >= 0.7;
}
