import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/hv/common/read_state.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';

/// What the user has read (manga, novels) or watched (anime) of a title.
///
/// Anime progress lives in `watchedEpisodes` / `currentEpisode`, not in
/// `readChapters`, so reading only `readChapters` made every anime look
/// never started and always behind.
class HvProgress {
  final bool started;

  /// Numbers of the chapters finished, or episodes watched.
  final List<double> finishedNumbers;

  const HvProgress(this.started, this.finishedNumbers);

  factory HvProgress.of(OfflineMedia m, ItemType type) {
    if (type == ItemType.anime) {
      final watched = m.watchedEpisodes ?? const [];
      return HvProgress(
        watched.isNotEmpty || m.currentEpisode != null,
        [
          for (final e in watched)
            if (double.tryParse(e.number.trim()) case final double n) n,
        ],
      );
    }
    final read = m.readChapters ?? const [];
    return HvProgress(read.isNotEmpty || m.currentChapter != null, [
      for (final c in read)
        if (c.number != null && hvIsPageComplete(c.pageNumber, c.totalPages))
          c.number!,
    ]);
  }
}
