import 'package:anymex/database/isar_models/chapter.dart';

/// New `readChapters` list after marking [targets] read or unread.
///
/// AnymeX keys read progress by chapter number (see
/// `OfflineStorageController.addOrUpdateReadChapter`). Marking read keeps an
/// existing entry's page count and moves it to the last page; a chapter
/// never opened gets a 1/1 entry. Marking unread removes the entry.
List<Chapter> planReadChapters(
  List<Chapter> existing,
  List<Chapter> targets, {
  required bool read,
}) {
  bool same(Chapter a, Chapter b) =>
      (a.number != null && a.number == b.number) ||
      (a.number == null &&
          (a.link ?? '').isNotEmpty &&
          a.link == b.link);

  final result = List<Chapter>.from(existing);
  for (final target in targets) {
    final index = result.indexWhere((c) => same(c, target));
    if (!read) {
      if (index != -1) result.removeAt(index);
      continue;
    }
    if (index != -1) {
      final entry = result[index];
      final total = (entry.totalPages ?? 0) > 0 ? entry.totalPages! : 1;
      entry
        ..totalPages = total
        ..pageNumber = total;
      continue;
    }
    result.add(Chapter(
      link: target.link,
      title: target.title,
      number: target.number,
      scanlator: target.scanlator,
      releaseDate: target.releaseDate,
      sourceName: target.sourceName,
      pageNumber: 1,
      totalPages: 1,
    ));
  }
  return result;
}

/// The chapters up to and including [chapter] in reading order (by number),
/// for "mark previous as read".
List<Chapter> chaptersUpTo(List<Chapter> all, Chapter chapter) {
  final limit = chapter.number;
  if (limit == null) return [chapter];
  return all.where((c) => c.number != null && c.number! <= limit).toList();
}
