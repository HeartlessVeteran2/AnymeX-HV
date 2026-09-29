/// AnymeX's rule for "this chapter is read": the saved page reached the last
/// or second-to-last page, or 95% of the chapter (see `chapter_list_builder`
/// and `ReaderController`).
bool hvIsPageComplete(int? page, int? total) {
  if (page == null || total == null || total <= 0) return false;
  return page >= total || page >= total - 1 || page / total >= 0.95;
}

/// Minimal view of a saved chapter for [hvIsChapterRead].
typedef HvSavedChapter = ({String? link, double? number, int? page, int? total});

/// Whether a chapter (by link, else by number) is read in [saved].
bool hvIsChapterRead(
  List<HvSavedChapter> saved, {
  String? link,
  double? number,
}) {
  HvSavedChapter? match;
  if (link != null && link.isNotEmpty) {
    for (final c in saved) {
      if (c.link == link) {
        match = c;
        break;
      }
    }
  }
  if (match == null && number != null) {
    for (final c in saved) {
      if (c.number == number) {
        match = c;
        break;
      }
    }
  }
  return match != null && hvIsPageComplete(match.page, match.total);
}

/// Whether any copy of chapter [number] in [chapters] is finished.
///
/// A chapter can appear several times (one entry per source or scanlation,
/// the saved progress and the reader's own list); one copy that is behind,
/// such as an older visit's saved progress, doesn't make it unread.
bool hvIsNumberRead(Iterable<HvSavedChapter> chapters, double number) =>
    chapters
        .any((c) => c.number == number && hvIsPageComplete(c.page, c.total));
