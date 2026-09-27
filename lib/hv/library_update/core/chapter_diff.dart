/// Stable identity of a chapter on its source: its URL, or number + title when
/// a source gives no URL.
String chapterKey({String? link, double? number, String? title}) {
  final url = link?.trim() ?? '';
  if (url.isNotEmpty) return url;
  return 'n:${number ?? ''}|${title?.trim() ?? ''}';
}

enum ChapterDiffKind {
  /// First check of this title: remember what's there, report nothing.
  baseline,

  /// Normal check: [ChapterDiff.newIndexes] are the new chapters.
  changes,

  /// Most of the list changed at once (the source changed its URLs, or the
  /// link now points somewhere else): remember the new list, report nothing
  /// rather than flooding the Updates screen.
  rebaseline,

  /// The source returned no chapters; treated as a failed check.
  empty,
}

class ChapterDiff {
  final ChapterDiffKind kind;

  /// Indexes into the `current` list of the chapters that are new.
  final List<int> newIndexes;

  /// Keys to store as known after this check.
  final List<String> knownAfter;

  const ChapterDiff(this.kind, this.newIndexes, this.knownAfter);
}

/// More new chapters than this, making up more than half of the list, is
/// treated as a rebaseline rather than real news.
const int kMassChangeMinimum = 10;

/// Compares the chapter keys a source returned now with the ones seen before.
///
/// Known keys are kept as a union, so a chapter that briefly disappears from a
/// source and comes back isn't reported as new twice.
ChapterDiff diffChapters(List<String> known, List<String> current) {
  if (current.isEmpty) {
    return ChapterDiff(ChapterDiffKind.empty, const [], known);
  }
  final union = <String>{...known, ...current}.toList();
  if (known.isEmpty) {
    return ChapterDiff(ChapterDiffKind.baseline, const [], union);
  }

  final knownSet = known.toSet();
  final seen = <String>{};
  final newIndexes = <int>[];
  for (var i = 0; i < current.length; i++) {
    final key = current[i];
    if (!knownSet.contains(key) && seen.add(key)) newIndexes.add(i);
  }

  if (newIndexes.length > kMassChangeMinimum &&
      newIndexes.length * 2 > current.length) {
    return ChapterDiff(ChapterDiffKind.rebaseline, const [], union);
  }
  return ChapterDiff(ChapterDiffKind.changes, newIndexes, union);
}
