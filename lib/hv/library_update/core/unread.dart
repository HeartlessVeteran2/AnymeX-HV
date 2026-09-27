/// How many chapters a title is behind: the source's highest chapter number
/// minus the highest one the user finished, or null when the source hasn't
/// been checked yet.
///
/// Counted by number, not by list length, because a source lists every
/// scanlation of a chapter and the saved chapter keys are a union of every
/// URL ever seen. Fractional chapters (10.5) round up to a whole chapter.
int? hvUnreadEstimate(double? latestNumber, Iterable<double> finishedNumbers) {
  if (latestNumber == null) return null;
  var furthest = 0.0;
  for (final n in finishedNumbers) {
    if (n > furthest) furthest = n;
  }
  final behind = latestNumber - furthest;
  return behind <= 0 ? 0 : behind.ceil();
}

/// The highest chapter number in [numbers], or null when none has one.
double? hvLatestNumber(Iterable<double?> numbers) {
  double? latest;
  for (final n in numbers) {
    if (n != null && (latest == null || n > latest)) latest = n;
  }
  return latest;
}
