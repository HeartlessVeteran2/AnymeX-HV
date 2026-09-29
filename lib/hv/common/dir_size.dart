import 'dart:io';
import 'dart:isolate';

/// Total size in bytes of the files under [path] (0 when it doesn't exist),
/// counted on a background isolate.
///
/// The image cache is measured at every startup (to enforce its size limit).
/// Walking it with an await per file ran tens of thousands of file lookups
/// through the UI isolate while the home screen was loading.
Future<int> hvDirectorySize(String path) =>
    Isolate.run(() => hvDirectorySizeSync(path));

/// [hvDirectorySize] on the calling isolate. A folder that can't be read
/// is skipped; the rest are still counted.
int hvDirectorySizeSync(String path) {
  var total = 0;
  final pending = [Directory(path)];
  while (pending.isNotEmpty) {
    final List<FileSystemEntity> entries;
    try {
      entries = pending.removeLast().listSync(followLinks: false);
    } catch (_) {
      continue; // missing or unreadable
    }
    for (final entity in entries) {
      if (entity is Directory) {
        pending.add(entity);
      } else if (entity is File) {
        try {
          total += entity.lengthSync();
        } catch (_) {}
      }
    }
  }
  return total;
}
