import 'dart:async';

/// How long a call to an extension source may take before the app gives up
/// and shows an error.
///
/// Source calls had no limit, so a source that never answered (a dead site,
/// a Cloudflare page the extension can't get past, a hung runtime) left the
/// search or reader spinning forever (upstream AnymeX #524, #591).
class HvSourceTimeouts {
  HvSourceTimeouts._();

  /// One source's row in the all-sources search.
  static const perSourceSearch = Duration(seconds: 30);

  /// Search, popular and latest on a single source.
  static const browse = Duration(seconds: 45);

  /// A chapter's page list.
  static const pages = Duration(seconds: 60);
}

/// Thrown when a source call runs past its limit.
class HvSourceTimeoutException implements Exception {
  final String action;
  final Duration limit;

  const HvSourceTimeoutException(this.action, this.limit);

  @override
  String toString() =>
      '$action took longer than ${limit.inSeconds} seconds. The source may '
      'be down or blocked. Try again, or use another source.';
}

/// [call], failing with [HvSourceTimeoutException] after [limit].
///
/// The underlying request isn't cancelled; its late result is ignored.
Future<T> hvWithTimeout<T>(
  Future<T> call, {
  required String action,
  required Duration limit,
}) =>
    call.timeout(limit,
        onTimeout: () => throw HvSourceTimeoutException(action, limit));

/// Thrown when the reader has no source to load pages from.
class HvNoSourceException implements Exception {
  const HvNoSourceException();

  @override
  String toString() => 'No source is selected for this title. Open it from '
      'its details page and pick a source, then try again.';
}

/// [source], or a readable error when there is none (instead of a null
/// check failure).
T hvActiveSource<T extends Object>(T? source) =>
    source ?? (throw const HvNoSourceException());
