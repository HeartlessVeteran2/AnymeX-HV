import 'dart:math' as math;

import 'package:anymex/hv/source_link/models/hv_source_link.dart';

/// Folds [saved] into [link] when both point at the same entry.
///
/// Used when another fetch saved the same link while [link] was being
/// prepared: saving [link] as is would drop what that fetch recorded (a
/// match the user confirmed, chapters it saw). Nothing it knew is lost; what
/// [link] fetched just now wins where the two can't be combined.
void hvMergeSavedLink(HvSourceLink link, HvSourceLink saved) {
  link
    ..userConfirmed = link.userConfirmed || saved.userConfirmed
    ..matchScore = math.max(link.matchScore, saved.matchScore)
    ..knownChapterKeys =
        {...saved.knownChapterKeys, ...link.knownChapterKeys}.toList()
    ..linkedAt = saved.linkedAt > 0 &&
            (link.linkedAt <= 0 || saved.linkedAt < link.linkedAt)
        ? saved.linkedAt
        : link.linkedAt
    ..lastCheckedAt = _later(link.lastCheckedAt, saved.lastCheckedAt)
    ..lastNewChapterAt = _later(link.lastNewChapterAt, saved.lastNewChapterAt)
    ..latestChapterNumber =
        link.latestChapterNumber ?? saved.latestChapterNumber;
}

int? _later(int? a, int? b) => a == null ? b : (b == null ? a : math.max(a, b));
