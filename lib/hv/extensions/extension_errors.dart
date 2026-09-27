/// What the user was doing when an extension call failed.
enum HvExtensionAction {
  install('install'),
  update('update'),
  uninstall('remove');

  final String verb;
  const HvExtensionAction(this.verb);
}

/// Turns an error thrown by the extension bridge into one short message the
/// user can act on.
///
/// The extension list used to catch these and only log them, so tapping
/// install on a CloudStream or Aniyomi extension looked like it did nothing
/// (upstream AnymeX #583, #515). Pure, so it can be tested without the app.
String hvExtensionErrorMessage(
  Object error, {
  required String? sourceName,
  required HvExtensionAction action,
}) {
  final name = (sourceName == null || sourceName.trim().isEmpty)
      ? 'this extension'
      : sourceName.trim();
  final raw = _clean(error.toString());
  final lower = raw.toLowerCase();

  if (_isOffline(lower)) {
    return "Couldn't ${action.verb} $name: no connection. "
        'Check your internet and try again.';
  }
  if (lower.contains('missingpluginexception') ||
      lower.contains('bridge failed to load') ||
      lower.contains('runtime bridge')) {
    return "Couldn't ${action.verb} $name: the extension bridge isn't "
        'running. Set it up from Extensions → Repositories.';
  }
  if (lower.contains('url is required') ||
      lower.contains('missing sourcecodeurl')) {
    return "Couldn't ${action.verb} $name: its repo has no download link. "
        'Refresh the repo, or the extension may have been removed.';
  }
  final http = RegExp(r'http (\d{3})').firstMatch(lower);
  if (http != null) {
    return "Couldn't download $name (HTTP ${http.group(1)}). "
        'The repo may be out of date.';
  }
  if (lower.contains('internal installation failed')) {
    return "Couldn't install $name with internal loading. Try turning "
        'internal loading off in Extension Manager.';
  }
  if (lower.contains('installation failed')) {
    return "Android didn't install $name. Allow AnymeX to install unknown "
        'apps, or turn on internal loading in Extension Manager.';
  }
  if (lower.contains('cancelled by user')) {
    return 'Removing $name was cancelled.';
  }
  return "Couldn't ${action.verb} $name: ${_shorten(raw)}";
}

bool _isOffline(String lower) =>
    lower.contains('socketexception') ||
    lower.contains('failed host lookup') ||
    lower.contains('connection refused') ||
    lower.contains('connection closed') ||
    lower.contains('network is unreachable') ||
    lower.contains('handshakeexception');

String _clean(String message) {
  var m = message.trim();
  for (final prefix in const ['Exception: ', 'Error: ']) {
    while (m.startsWith(prefix)) {
      m = m.substring(prefix.length).trim();
    }
  }
  return m;
}

String _shorten(String message, {int max = 140}) {
  final firstLine = message.split('\n').first.trim();
  if (firstLine.isEmpty) return 'unknown error';
  return firstLine.length <= max
      ? firstLine
      : '${firstLine.substring(0, max - 1)}…';
}

/// The message after "Update all", or null when everything updated.
String? hvUpdateFailuresMessage(List<String> failedNames) {
  if (failedNames.isEmpty) return null;
  const shown = 3;
  final names = failedNames.take(shown).join(', ');
  final more = failedNames.length > shown
      ? ' and ${failedNames.length - shown} more'
      : '';
  final noun = failedNames.length == 1 ? 'extension' : 'extensions';
  return "Couldn't update ${failedNames.length} $noun: $names$more. "
      'Update one on its own to see why.';
}
