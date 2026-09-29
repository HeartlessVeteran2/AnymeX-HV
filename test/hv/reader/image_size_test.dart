import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:anymex/hv/reader/image_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

// A 3x2 PNG.
final _png = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAMAAAACCAYAAACddGYaAAAAEUlEQVR4nGP4z8DwH4YZkDkAm34L9XKwuTwAAAAASUVORK5CYII=');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory dir;
  setUp(() {
    dir = Directory.systemTemp.createTempSync('hv_image_size');
    imageCache
      ..clear()
      ..clearLiveImages();
  });
  tearDown(() => dir.deleteSync(recursive: true));

  FileImage image(String name, List<int> bytes) =>
      FileImage(File('${dir.path}/$name')..writeAsBytesSync(bytes));

  // Each test clears the image cache before counting live images: the cache
  // lets an image go, and a listener left on its stream still keeps it.
  test('reports the size once, then no longer keeps the image alive',
      () async {
    final sizes = <Size>[];
    final done = Completer<void>();
    hvReportImageSize(image('a.png', _png), (w, h) {
      sizes.add(Size(w, h));
      done.complete();
    });
    await done.future.timeout(const Duration(seconds: 10));

    expect(sizes, [const Size(3, 2)]);
    imageCache.clear();
    expect(imageCache.liveImageCount, 0);
  });

  test('a listener left on the stream keeps the image alive (the leak)',
      () async {
    final done = Completer<void>();
    image('b.png', _png)
        .resolve(ImageConfiguration.empty)
        .addListener(ImageStreamListener((_, __) {
      if (!done.isCompleted) done.complete();
    }));
    await done.future.timeout(const Duration(seconds: 10));

    imageCache.clear();
    expect(imageCache.liveImageCount, 1);
  });

  test('an image that fails to decode is still reported, and let go',
      () async {
    final errors = <FlutterErrorDetails>[];
    final previous = FlutterError.onError;
    FlutterError.onError = errors.add;
    addTearDown(() => FlutterError.onError = previous);

    var reported = false;
    hvReportImageSize(image('bad.png', [1, 2, 3, 4]), (_, __) => reported = true);
    for (var i = 0; i < 200 && errors.isEmpty; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }

    expect(reported, isFalse);
    expect(errors, hasLength(1));
    // A failed image stays pending in the cache; clearing it drops the
    // cache's own listener, so only a leaked listener could keep it alive.
    imageCache.clear();
    expect(imageCache.liveImageCount, 0);
  });
}
