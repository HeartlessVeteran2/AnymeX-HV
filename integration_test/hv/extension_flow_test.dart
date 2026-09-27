// Runs the real app and exercises the extension path end to end: repos,
// installing Mangayomi sources, search -> details -> pages, the saved source
// link, the library update checker and the HV screens.
//
// Two phases share one app data directory, so phase 2 sees what phase 1
// saved (like reopening the app):
//   flutter test integration_test/hv/extension_flow_test.dart -d linux \
//     --dart-define=HV_PHASE=1
//   flutter test integration_test/hv/extension_flow_test.dart -d linux \
//     --dart-define=HV_PHASE=2
// On Linux, run it under xvfb-run. Screenshots (Linux, ImageMagick) go to
// HV_SHOTS when it's set.
//
// integration_test is deliberately not in pubspec.yaml (as a dev dependency
// its Android test libraries break R8 in debug APK builds). Add it for the
// run only: flutter pub add 'dev:integration_test:{"sdk":"flutter"}'
import 'dart:async';
import 'dart:io';

import 'package:anymex/controllers/offline/offline_storage_controller.dart';
import 'package:anymex/hv/bookmarks/ui/bookmarks_screen.dart';
import 'package:anymex/hv/discovery/feed_service.dart';
import 'package:anymex/hv/discovery/ui/discover_screen.dart';
import 'package:anymex/hv/library_update/library_update_service.dart';
import 'package:anymex/hv/library_update/ui/update_errors_screen.dart';
import 'package:anymex/hv/library_update/ui/update_settings_screen.dart';
import 'package:anymex/hv/library_update/ui/updates_screen.dart';
import 'package:anymex/hv/reader/hv_reader_launcher.dart';
import 'package:anymex/hv/source_link/source_link_repository.dart';
import 'package:anymex/main.dart' as app;
import 'package:anymex/screens/settings/sub_settings/settings_extensions.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:wakelock_plus_platform_interface/wakelock_plus_platform_interface.dart';

const _phase = int.fromEnvironment('HV_PHASE', defaultValue: 1);
const _repo = 'https://kodjodevf.github.io/mangayomi-extensions/index.json';

/// Sources to try, Dart (dart_eval) and JavaScript (QuickJS) ones. Each
/// result line says how far a source got; the library, update and reader
/// steps use the first one that got all the way to a chapter's pages.
const _sources = [
  'MangaRead.org', // Dart, Madara
  'MangaDex', // JavaScript, API
  'Mangapill', // JavaScript
  'Weeb Central', // JavaScript
  'Comick', // JavaScript, API
];
const _query = 'one piece';

final _errors = <String>[];

void _log(String line) => debugPrint('HVRESULT $line');

Future<void> _settle(WidgetTester tester, [int ms = 1500]) async {
  for (var i = 0; i < ms ~/ 100; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<bool> _waitFor(WidgetTester tester, bool Function() done,
    {Duration timeout = const Duration(seconds: 60)}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    if (done()) return true;
    await tester.pump(const Duration(milliseconds: 250));
  }
  return done();
}

Future<void> _shot(WidgetTester tester, String name) async {
  await _settle(tester, 800);
  final dir = Platform.environment['HV_SHOTS'];
  if (dir == null || !Platform.isLinux) return;
  await Process.run('import', ['-window', 'root', '$dir/$name.png']);
}

/// Opens [page], checks it builds without errors, screenshots it, closes it.
Future<void> _visit(WidgetTester tester, String name, Widget Function() page,
    {int wait = 2500}) async {
  final before = _errors.length;
  navigate(page);
  await _settle(tester, wait);
  await _shot(tester, name);
  final ok = _errors.length == before;
  _log('screen $name: ${ok ? 'ok' : 'ERRORS ${_errors.sublist(before)}'}');
  Get.back();
  await _settle(tester, 800);
}

Future<T?> _try<T>(String what, Future<T> Function() call,
    {Duration timeout = const Duration(seconds: 60)}) async {
  final sw = Stopwatch()..start();
  try {
    final v = await call().timeout(timeout);
    _log('$what: ok (${sw.elapsedMilliseconds} ms)');
    return v;
  } catch (e) {
    _log('$what: FAILED after ${sw.elapsedMilliseconds} ms: $e');
    return null;
  }
}

/// Keeps the screen awake by doing nothing: the Linux plugin talks to the
/// desktop session over D-Bus, which a headless CI runner doesn't have, and
/// the reader turns it on without awaiting it (fine in the app, whose zone
/// catches the error; a test fails on it).
class _NoWakelock extends WakelockPlusPlatformInterface {
  @override
  Future<void> toggle({required bool enable}) async {}

  @override
  Future<bool> get enabled async => false;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HV extension flow, phase $_phase', (tester) async {
    wakelockPlusPlatformInstance = _NoWakelock();
    app.main(const []);
    // The app installs its own FlutterError handler; wrap it to count errors
    // instead of failing on the first one.
    await _settle(tester, 3000);
    final appHandler = FlutterError.onError;
    FlutterError.onError = (details) {
      _errors.add(details.exceptionAsString().split('\n').first);
      appHandler?.call(details);
    };

    final ready = await _waitFor(
        tester,
        () =>
            Get.isRegistered<ExtensionManager>() &&
            Get.find<ExtensionManager>()
                .managers
                .any((m) => m.id == 'mangayomi'));
    _log('extension managers ready: $ready');
    expect(ready, isTrue);
    final em = Get.find<ExtensionManager>();
    final m = em.managers.firstWhere((m) => m.id == 'mangayomi');
    await _shot(tester, 'p${_phase}_home');

    if (_phase == 2) {
      // Upstream #585: the repo list after reopening the app.
      final repos = m.getReposRx(ItemType.manga).value.map((r) => r.url);
      _log('repos after restart: ${repos.toList()}');
      await _visit(tester, 'p2_repositories', () => const SettingsExtensions());
      final installed = m.getInstalledRx(ItemType.manga).value;
      _log('installed after restart: ${installed.map((s) => s.name)}');
      expect(repos, contains(_repo));
      _log('flutter errors: ${_errors.length} $_errors');
      return;
    }

    // ---- phase 1 ----------------------------------------------------------
    await _try('add repo', () => m.addRepo(_repo, ItemType.manga));
    _log('repos: ${m.getReposRx(ItemType.manga).value.map((r) => r.url)}');
    await _waitFor(tester,
        () => m.getAvailableRx(ItemType.manga).value.isNotEmpty);
    _log('available manga sources: '
        '${m.getAvailableRx(ItemType.manga).value.length}');
    await _visit(tester, 'p1_repositories', () => const SettingsExtensions());

    DMedia? libraryItem;
    Source? librarySource;
    String? firstChapterUrl;
    for (final name in _sources) {
      final src = m.getAvailableRx(ItemType.manga).value.firstWhereOrNull(
              (s) => s.name == name && (s.lang == 'en' || s.lang == 'all')) ??
          m.getInstalledRx(ItemType.manga).value
              .firstWhereOrNull((s) => s.name == name);
      if (src == null) {
        _log('$name: not in the repo');
        continue;
      }
      await _try('$name install', () => src.install());
      await _settle(tester, 500);
      final installed = m
          .getInstalledRx(ItemType.manga)
          .value
          .firstWhereOrNull((s) => s.name == name);
      if (installed == null) {
        _log('$name: not installed');
        continue;
      }
      final pages = await _try('$name search "$_query"',
          () => installed.methods.search(_query, 1, []));
      final results = [...?pages?.list.where((e) => e.url != null)];
      _log('$name results: ${results.length}'
          '${results.isNotEmpty ? ' first: ${results.first.title}' : ''}');
      if (results.isEmpty) continue;
      // The first hit can be an odd entry; try up to three.
      DMedia? first;
      var chapters = const <DEpisode>[];
      for (final candidate in results.take(3)) {
        final detail = await _try('$name details "${candidate.title}"',
            () => installed.methods.getDetail(DMedia.withUrl(candidate.url!)));
        final found = detail?.episodes ?? const <DEpisode>[];
        if (found.isNotEmpty) {
          first = candidate;
          chapters = found;
          break;
        }
      }
      if (first == null) {
        _log('$name chapters: 0');
        continue;
      }
      _log('$name chapters: ${chapters.length}');
      if (chapters.isEmpty) continue;
      final pageList = await _try(
          '$name pages',
          () => installed.methods.getPageList(DEpisode(
              episodeNumber: chapters.last.episodeNumber,
              url: chapters.last.url)));
      _log('$name pages: ${pageList?.length ?? 0}');
      if ((pageList?.isNotEmpty ?? false) && libraryItem == null) {
        libraryItem = first;
        librarySource = installed;
        firstChapterUrl = chapters.last.url;
      }
    }

    if (libraryItem != null && librarySource != null) {
      final item = libraryItem;
      final source = librarySource;
      final media = HvFeed.toMedia(item, source, ItemType.manga);
      // The saved source link and the library update checker. Every type
      // has a "Default" list.
      await _try('add to library "Default"', () async {
        await HvFeed.addToList('Default', [(item, source)], ItemType.manga);
      });
      _log('in library: '
          '${Get.find<OfflineStorageController>().getMediaById(media.id) != null}');
      final link = SourceLinkRepository.get(ItemType.manga.index, media.id);
      _log('saved source link: ${link != null ? '${link.sourceName} '
          '${link.url}' : 'none'}');

      HvFeed.open(item, source, ItemType.manga);
      await _settle(tester, 8000);
      await _shot(tester, 'p1_details');
      Get.back();
      await _settle(tester, 800);

      final result = await _try('library update run',
          () => LibraryUpdateService.to.run(types: {ItemType.manga}),
          timeout: const Duration(minutes: 3));
      _log('update result: checked ${result?.checked} new '
          '${result?.newChapters} failed ${result?.failed} skipped '
          '${result?.skipped}');

      // The reader through the saved link, then its page gallery button.
      unawaited(HvReaderLauncher.openChapter(
          mediaId: media.id,
          mediaTypeIndex: ItemType.manga.index,
          chapterLink: firstChapterUrl));
      await _settle(tester, 12000);
      await _shot(tester, 'p1_reader');
      Get.back();
      await _settle(tester, 1000);
    } else {
      _log('no source completed search -> details -> pages');
    }

    await _visit(tester, 'p1_updates', () => const HvUpdatesScreen());
    await _visit(tester, 'p1_update_errors', () => const HvUpdateErrorsScreen());
    await _visit(tester, 'p1_update_settings',
        () => const HvUpdateSettingsScreen());
    await _visit(tester, 'p1_bookmarks', () => const HvBookmarksScreen());
    await _visit(tester, 'p1_discover', () => const HvDiscoverScreen(),
        wait: 6000);

    _log('flutter errors: ${_errors.length} $_errors');
  }, timeout: const Timeout(Duration(minutes: 15)));
}
