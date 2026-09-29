import 'dart:io';

import 'package:anymex/hv/common/dir_size.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds up the files in every subfolder', () async {
    final dir = Directory.systemTemp.createTempSync('hv_dir_size');
    addTearDown(() => dir.deleteSync(recursive: true));
    File('${dir.path}/a.bin').writeAsBytesSync(List.filled(100, 1));
    Directory('${dir.path}/sub/deeper').createSync(recursive: true);
    File('${dir.path}/sub/b.bin').writeAsBytesSync(List.filled(20, 1));
    File('${dir.path}/sub/deeper/c.bin').writeAsBytesSync(List.filled(3, 1));

    expect(hvDirectorySizeSync(dir.path), 123);
    expect(await hvDirectorySize(dir.path), 123);
  });

  test('a missing folder is 0', () async {
    expect(await hvDirectorySize('/no/such/folder/hv'), 0);
  });
}
