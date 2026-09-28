import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/hv/library_update/progress.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a manga with an opened chapter has been started', () {
    final opened = OfflineMedia(currentChapter: Chapter(number: 1));
    expect(HvProgress.of(opened, ItemType.manga).started, isTrue);
    // Nothing finished yet, so nothing counts as read.
    expect(HvProgress.of(opened, ItemType.manga).finishedNumbers, isEmpty);
  });

  test('a manga never opened has not been started', () {
    expect(HvProgress.of(OfflineMedia(), ItemType.manga).started, isFalse);
  });
}
