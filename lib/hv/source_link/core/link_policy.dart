/// Whether a newly fetched match may replace a title's saved source link.
///
/// The saved link is what the details page opens directly and what the
/// library update checker follows, so it only moves when the new match is
/// at least as good:
/// - a match the user picked always wins;
/// - an automatic match never replaces one the user picked;
/// - an automatic match only replaces another when it's trusted itself, so a
///   weak guess on some other source can't displace a good link.
bool hvShouldReplaceLink({
  required bool existingConfirmed,
  required bool existingTrusted,
  required bool newConfirmed,
  required bool newTrusted,
}) {
  if (newConfirmed) return true;
  if (existingConfirmed) return false;
  return newTrusted || !existingTrusted;
}
