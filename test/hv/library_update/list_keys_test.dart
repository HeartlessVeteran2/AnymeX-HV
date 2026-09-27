import 'package:anymex/hv/library_update/core/list_keys.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('renaming a chosen list keeps it chosen under its new name', () {
    expect(hvRenameListKey({'0|Reading', '0|Done'}, '0|Reading', '0|Current'),
        {'0|Current', '0|Done'});
  });

  test('renaming a list that was not chosen changes nothing', () {
    final keys = {'0|Done'};
    expect(identical(hvRenameListKey(keys, '0|Reading', '0|Current'), keys),
        isTrue);
  });

  test('a same-named list of another type is not renamed', () {
    expect(hvRenameListKey({'1|Reading'}, '0|Reading', '0|Current'),
        {'1|Reading'});
  });

  test('deleted lists are dropped', () {
    expect(hvPruneListKeys({'0|Gone', '0|Here'}, {'0|Here', '1|Other'}),
        {'0|Here'});
    expect(hvPruneListKeys({'0|Gone'}, {'0|Here'}), isEmpty);
  });
}
