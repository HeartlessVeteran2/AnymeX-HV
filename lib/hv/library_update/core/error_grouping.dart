/// Failed titles sharing one (normalized) error message.
class ErrorGroup<T> {
  final String message;
  final List<T> items;
  ErrorGroup(this.message, this.items);
}

/// Makes messages that differ only in URLs or ids comparable, so "HTTP 403
/// for https://a/1" and "HTTP 403 for https://a/2" land in one group.
/// Three-digit numbers (HTTP status codes) are kept.
String normalizeErrorMessage(String message) {
  var s = message.trim();
  s = s.replaceAll(RegExp(r'https?://\S+'), '<url>');
  s = s.replaceAll(RegExp(r'\b[0-9a-fA-F]{8,}\b'), '<id>');
  s = s.replaceAll(RegExp(r'\b\d{4,}\b'), '<n>');
  s = s.replaceAll(RegExp(r'\s+'), ' ');
  return s.isEmpty ? 'Unknown error' : s;
}

/// Groups by normalized message; biggest group first, then the group with
/// the newest error.
List<ErrorGroup<T>> groupErrors<T>(
  List<T> items, {
  required String Function(T) message,
  required int Function(T) timestamp,
}) {
  final groups = <String, List<T>>{};
  for (final item in items) {
    groups.putIfAbsent(normalizeErrorMessage(message(item)), () => []).add(item);
  }
  int newest(List<T> list) =>
      list.map(timestamp).fold(0, (a, b) => a > b ? a : b);
  final result = [
    for (final entry in groups.entries)
      ErrorGroup<T>(entry.key,
          entry.value..sort((a, b) => timestamp(b).compareTo(timestamp(a)))),
  ];
  result.sort((a, b) {
    final bySize = b.items.length.compareTo(a.items.length);
    return bySize != 0 ? bySize : newest(b.items).compareTo(newest(a.items));
  });
  return result;
}
