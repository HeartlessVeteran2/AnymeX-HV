/// Per-title choice for deleting downloads after reading.
enum HvDeleteAfterReadMode { inherit, enabled, disabled }

/// Whether downloads are deleted after reading for a title: its own choice,
/// or the global switch when it has none.
bool shouldDeleteAfterRead(HvDeleteAfterReadMode title, bool global) =>
    switch (title) {
      HvDeleteAfterReadMode.inherit => global,
      HvDeleteAfterReadMode.enabled => true,
      HvDeleteAfterReadMode.disabled => false,
    };

/// Which chapter to delete once [justRead] is finished (Otaku Reader's
/// "keep last N"): with [keep] = 0 the chapter just read, otherwise the one
/// [keep] chapters before it, so the last [keep] read chapters stay.
/// Returns null when there's nothing to delete.
double? chapterToDeleteAfterRead(
    List<double> chapterNumbers, double justRead, int keep) {
  final sorted = chapterNumbers.toSet().toList()..sort();
  final i = sorted.indexOf(justRead);
  if (i == -1) return null;
  final target = i - keep.clamp(0, 1 << 20);
  return target >= 0 ? sorted[target] : null;
}

/// How far into a chapter the next chapters start downloading.
const double kDownloadAheadAt = 0.8;

/// The next [count] chapters after [current] (by number) that aren't
/// downloaded yet, once reading passed [kDownloadAheadAt] of the chapter.
List<double> chaptersToDownloadAhead({
  required List<double> chapterNumbers,
  required double current,
  required double progress,
  required int count,
  required bool Function(double number) isDownloaded,
}) {
  if (count <= 0 || progress < kDownloadAheadAt) return const [];
  final after = chapterNumbers.where((n) => n > current).toSet().toList()
    ..sort();
  return after.take(count).where((n) => !isDownloaded(n)).toList();
}
