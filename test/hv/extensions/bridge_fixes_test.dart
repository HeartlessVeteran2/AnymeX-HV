// Fixes in our bridge fork (AnymeXExtensionRuntimeBridge-HV). The fork
// ignores its own test/ folder, so they're checked here.
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:anymex_extension_runtime_bridge/Services/Aniyomi/AniyomiExtensions.dart';
import 'package:anymex_extension_runtime_bridge/Services/Aniyomi/Models/Source.dart';
import 'package:anymex_extension_runtime_bridge/Services/Mangayomi/MangayomiExtensions.dart';
import 'package:anymex_extension_runtime_bridge/Services/Mangayomi/MangayomiSourceMethods.dart';
import 'package:anymex_extension_runtime_bridge/Settings/KvStore.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:isar_community/isar.dart';

/// The Isar core library shipped with isar_community_flutter_libs, or null
/// on a platform this test doesn't set up.
String? _isarLibrary() {
  if (!Platform.isLinux) return null;
  // Tests run from the project root, next to the package config.
  final config = File('.dart_tool/package_config.json');
  if (!config.existsSync()) return null;
  final packages = (jsonDecode(config.readAsStringSync())
      as Map<String, dynamic>)['packages'] as List<dynamic>;
  final package = packages.cast<Map<String, dynamic>>().where(
      (p) => p['name'] == 'isar_community_flutter_libs');
  if (package.isEmpty) return null;
  final root = config.absolute.uri.resolve('${package.first['rootUri']}/');
  final path = root.resolve('linux/libisar.so').toFilePath();
  return File(path).existsSync() ? path : null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  late Directory dir;
  String? skip;

  setUpAll(() async {
    final library = _isarLibrary();
    if (library == null) {
      skip = 'needs the Linux Isar library';
      return;
    }
    await Isar.initializeIsarCore(libraries: {Abi.current(): library});
    dir = Directory.systemTemp.createTempSync('hv_bridge');
    final isar = await Isar.open([KvEntrySchema],
        directory: dir.path, name: 'hv_bridge_test');
    AnymeXExtensionBridge.context = BridgeContext(
      isar: isar,
      // Every request fails, so nothing here reaches the network.
      http: MockClient((_) async => http.Response('', 404)),
      getDirectory: ({subPath, useCustomPath = false, useSystemPath = false})
          async => dir,
    );
  });

  tearDownAll(() {
    if (skip == null) dir.deleteSync(recursive: true);
  });

  test('Mangayomi shows its saved repos again after a restart', () async {
    if (skip != null) return markTestSkipped(skip!);
    setVal('mangayomimangaRepos', [
      jsonEncode(Repo(url: 'https://example.org/index.json',
              managerId: 'mangayomi')
          .toJson()),
      // An entry saved without its manager, which removing it looks up.
      jsonEncode({'url': 'https://example.org/old.json'}),
    ]);

    // A new manager, as after a restart: nothing on screen yet.
    final manager = MangayomiExtensions();
    expect(manager.getReposRx(ItemType.manga).value, isEmpty);

    await manager.fetchMangaExtensions();

    final repos = manager.getReposRx(ItemType.manga).value;
    expect(repos.map((r) => r.url),
        ['https://example.org/index.json', 'https://example.org/old.json']);
    expect(repos.map((r) => r.managerId), everyElement('mangayomi'));
  });

  test('Aniyomi installs and removals run one at a time', () async {
    if (skip != null) return markTestSkipped(skip!);
    final started = <String>[];
    final firstDone = Completer<void>();
    messenger.setMockMethodCallHandler(
        const MethodChannel('aniyomiExtensionBridge'), (call) async {
      if (call.method == 'uninstallSourceInternal') {
        final pkg = (call.arguments as Map)['packageName'] as String;
        started.add(pkg);
        if (pkg == 'first') await firstDone.future;
        return true;
      }
      return <dynamic>[]; // the installed-extensions lists
    });
    // Not installed as a system app, so no uninstall dialog.
    messenger.setMockMethodCallHandler(
        const MethodChannel('g123k/device_apps'), (_) async => false);
    addTearDown(() {
      messenger.setMockMethodCallHandler(
          const MethodChannel('aniyomiExtensionBridge'), null);
      messenger.setMockMethodCallHandler(
          const MethodChannel('g123k/device_apps'), null);
    });

    final manager = AniyomiExtensions();
    ASource source(String pkg) =>
        ASource(id: pkg, pkgName: pkg, itemType: ItemType.manga);
    final first = manager.uninstallSource(source('first'));
    final second = manager.uninstallSource(source('second'));

    await pumpEventQueue();
    expect(started, ['first'], reason: 'the second waits for the first');

    firstDone.complete();
    await Future.wait([first, second]);
    expect(started, ['first', 'second']);
  });

  test('Mangayomi getPageList reports why it failed', () async {
    if (skip != null) return markTestSkipped(skip!);
    // Source code that can't run: loading its pages fails.
    final source = MSource(
      id: '1',
      name: 'Broken',
      itemType: ItemType.manga,
      sourceCode: 'this is not a source',
      sourceCodeLanguage: SourceCodeLanguage.dart,
    );

    // It used to return an empty list, which the reader could only show as
    // "No pages found".
    await expectLater(
      MangayomiSourceMethods(source)
          .getPageList(DEpisode(episodeNumber: '1', url: '/chapter/1')),
      throwsA(anything),
    );
  });
}
