import 'dart:async';

import 'package:anymex/controllers/source/source_controller.dart';
import 'package:anymex/database/data_keys/keys.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/hv/common/hv_keys.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/library_update/chapter_recorder.dart';
import 'package:anymex/hv/library_update/core/chapter_diff.dart';
import 'package:anymex/hv/library_update/core/source_health.dart';
import 'package:anymex/hv/library_update/models/hv_update_error.dart';
import 'package:anymex/hv/library_update/update_repository.dart';
import 'package:anymex/hv/matching/title_matcher.dart';
import 'package:anymex/hv/matching/title_normalizer.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';
import 'package:anymex/hv/source_link/source_link_repository.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:get/get.dart';

/// Summary of one library update run.
class LibraryUpdateResult {
  final int checked;
  final int newChapters;
  final int failed;
  final int skipped;
  final DateTime finishedAt;

  const LibraryUpdateResult({
    required this.checked,
    required this.newChapters,
    required this.failed,
    required this.skipped,
    required this.finishedAt,
  });
}

class _Job {
  final OfflineMedia media;
  final ItemType type;
  final Source source;
  HvSourceLink? link;

  _Job(this.media, this.type, this.source, this.link);

  String get mediaId => media.mediaId ?? '';
  String get mediaKey => hvMediaKey(type.index, mediaId);
  String get title => media.displayTitle;
}

/// Checks library titles on their sources for new chapters (Komikku/Mihon
/// "library update").
///
/// Runs in the app, on the main isolate (extension sources can only be called
/// from there). Gentle on sources: a few sources at a time, one request per
/// source at a time with a short pause between them, a timeout per request,
/// and a source that keeps failing is skipped for the rest of the run. It
/// never writes `OfflineMedia`, so the library UI isn't rebuilt while it runs.
class LibraryUpdateService extends GetxService {
  static LibraryUpdateService get to => Get.find<LibraryUpdateService>();

  static const int sourceConcurrency = 3;
  static const Duration requestTimeout = Duration(seconds: 60);
  static const Duration pauseBetweenRequests = Duration(seconds: 1);

  /// A title found by search is linked automatically only at this score.
  static const double autoLinkScore = 0.9;

  final RxBool running = false.obs;
  final RxInt done = 0.obs;
  final RxInt total = 0.obs;
  final RxString current = ''.obs;
  final Rxn<LibraryUpdateResult> lastResult = Rxn<LibraryUpdateResult>();

  bool _cancelled = false;
  final Map<String, Source> _activeTokens = {};

  /// Checks every library title of [types]. Returns null when a run is
  /// already in progress.
  Future<LibraryUpdateResult?> run({
    Set<ItemType> types = const {ItemType.manga, ItemType.novel},
  }) async {
    if (running.value) return null;
    running.value = true;
    _cancelled = false;
    done.value = 0;
    total.value = 0;
    current.value = '';

    var checked = 0, newChapters = 0, failed = 0, skipped = 0;
    try {
      final jobs = <_Job>[];
      for (final type in types) {
        final collected = _collectJobs(type);
        jobs.addAll(collected.jobs);
        skipped += collected.skipped;
      }
      total.value = jobs.length;

      final bySource = <String, List<_Job>>{};
      for (final job in jobs) {
        bySource.putIfAbsent(job.source.id ?? '', () => []).add(job);
      }

      final health = SourceHealth();
      final queue = bySource.values.toList();
      Future<void> worker() async {
        while (queue.isNotEmpty && !_cancelled) {
          final sourceJobs = queue.removeAt(0);
          for (var i = 0; i < sourceJobs.length && !_cancelled; i++) {
            final job = sourceJobs[i];
            current.value = job.title;
            final outcome = await _check(job, health);
            if (outcome == null) {
              failed++;
            } else {
              checked++;
              newChapters += outcome;
            }
            done.value++;
            if (i < sourceJobs.length - 1) {
              await Future.delayed(pauseBetweenRequests);
            }
          }
        }
      }

      await Future.wait(List.generate(sourceConcurrency, (_) => worker()));
      await UpdateRepository.prune();
    } catch (e) {
      Logger.e('HV: library update failed: $e');
    } finally {
      final result = LibraryUpdateResult(
        checked: checked,
        newChapters: newChapters,
        failed: failed,
        skipped: skipped,
        finishedAt: DateTime.now(),
      );
      lastResult.value = result;
      HvKeys.hvLastUpdateRunAt.set(result.finishedAt.millisecondsSinceEpoch);
      current.value = '';
      running.value = false;
    }
    return lastResult.value;
  }

  void cancel() {
    _cancelled = true;
    for (final entry in _activeTokens.entries) {
      entry.value.cancelRequest(entry.key);
    }
    _activeTokens.clear();
  }

  ({List<_Job> jobs, int skipped}) _collectJobs(ItemType type) {
    final sources = Get.find<SourceController>();
    final jobs = <_Job>[];
    var skipped = 0;

    for (final id in LibraryMembership.idsOfType(type.index)) {
      final media = LibraryMembership.media(type.index, id);
      if (media == null) continue;
      final link = SourceLinkRepository.get(type.index, id);
      Source? source;
      if (link != null && link.isTrusted) {
        source = sources.findSourceById(link.sourceId, type);
      } else {
        source = _guessSource(media, type, sources);
      }
      if (source == null) {
        skipped++;
        unawaited(_recordError(
          media,
          type,
          link?.sourceId,
          link?.sourceName,
          link != null
              ? 'Source "${link.sourceName ?? link.sourceId}" is not installed.'
              : 'Not linked to a source yet. Open the title once to link it.',
        ));
        continue;
      }
      jobs.add(_Job(media, type, source,
          link != null && link.isTrusted ? link : null));
    }
    return (jobs: jobs, skipped: skipped);
  }

  /// The source an unlinked title was last used with: the one remembered for
  /// it on the details page, else the one its last read chapter came from.
  Source? _guessSource(
      OfflineMedia media, ItemType type, SourceController sources) {
    final id = media.mediaId ?? '';
    final stickyId = DynamicKeys.stickySource.get<String>(id, '');
    if (stickyId.isNotEmpty) {
      final sticky = sources.findSourceById(stickyId, type);
      if (sticky != null) return sticky;
    }
    final name = media.currentChapter?.sourceName ??
        media.readChapters?.lastOrNull?.sourceName;
    if (name == null || name.isEmpty) return null;
    final installed = switch (type) {
      ItemType.manga => sources.installedMangaExtensions,
      ItemType.novel => sources.installedNovelExtensions,
      ItemType.anime => sources.installedExtensions,
    };
    final byName = installed.where((s) => s.name == name).toList();
    return byName.length == 1 ? byName.first : null;
  }

  /// Returns the number of new chapters, or null when the check failed.
  Future<int?> _check(_Job job, SourceHealth health) async {
    final sourceId = job.source.id ?? '';
    if (health.isPaused(sourceId)) {
      await _recordError(job.media, job.type, sourceId, job.source.name,
          'Skipped: ${job.source.name} failed several times in a row.');
      return null;
    }
    try {
      job.link ??= await _autoLink(job);
      final link = job.link;
      if (link == null) {
        await _recordError(job.media, job.type, sourceId, job.source.name,
            'Couldn\'t find this title on ${job.source.name}. Open it once and pick the right entry.');
        return null;
      }

      final detail = await _call(
          job.source, (token) => job.source.methods.getDetail(
                DMedia.withUrl(link.url),
                parameters: SourceParams(cancelToken: token),
              ));
      final chapters =
          Media.fromDManga(detail, job.type).altMediaContent ?? <Chapter>[];
      final diff = await ChapterRecorder.record(
        link: link,
        chapters: chapters,
        reportNew: true,
        mediaTitle: job.title,
        poster: job.media.poster,
      );
      if (diff.kind == ChapterDiffKind.empty) {
        throw Exception('The source returned no chapters.');
      }
      await SourceLinkRepository.save(link);
      await UpdateRepository.clearError(job.mediaKey);
      health.recordSuccess(sourceId);
      return diff.kind == ChapterDiffKind.changes ? diff.newIndexes.length : 0;
    } catch (e) {
      if (_cancelled) return null;
      health.recordFailure(sourceId);
      await _recordError(
          job.media, job.type, sourceId, job.source.name, _describe(e));
      return null;
    }
  }

  /// Links an unlinked title: an extension entry is its own URL on its
  /// source; anything else is searched by title and linked only on a strong
  /// match.
  Future<HvSourceLink?> _autoLink(_Job job) async {
    final sourceId = job.source.id ?? '';
    HvSourceLink newLink(String url, String? title, double score) =>
        HvSourceLink()
          ..mediaId = job.mediaId
          ..mediaTypeIndex = job.type.index
          ..serviceIndex = job.media.serviceIndex ?? 0
          ..sourceId = sourceId
          ..sourceName = job.source.name
          ..url = url
          ..title = title
          ..matchScore = score
          ..linkedAt = DateTime.now().millisecondsSinceEpoch;

    if (hvIsExtensionKeyed(job.mediaId)) {
      return newLink(job.mediaId, job.title, 1.0);
    }

    final titles = <String>[
      for (final t in [job.media.name, job.media.english, job.media.jname])
        if (t != null && TitleNormalizer.isMeaningful(t)) t,
    ];
    final saved = <String>[
      for (var service = 0; service < 4; service++)
        if (DynamicKeys.mappedMediaTitle
                .get<String>('$sourceId-${job.mediaId}-$service', '')
            case final t when t.isNotEmpty)
          t,
    ];
    final queries = <String>{...saved, ...titles}.take(2);

    for (final query in queries) {
      final results = (await _call(
              job.source,
              (token) => job.source.methods.search(query, 1, [],
                  parameters: SourceParams(cancelToken: token))))
          .list;
      if (results.isEmpty) continue;
      final exact = results.where((r) =>
          saved.any((s) =>
              TitleNormalizer.normalize(s) ==
              TitleNormalizer.normalize(r.title ?? '')));
      if (exact.isNotEmpty && (exact.first.url ?? '').isNotEmpty) {
        return newLink(exact.first.url!, exact.first.title, 1.0);
      }
      final match = TitleMatcher.bestMatch<DMedia>(
          [...saved, ...titles], results, (r) => [r.title]);
      if (match != null &&
          match.score >= autoLinkScore &&
          (match.candidate.url ?? '').isNotEmpty) {
        return newLink(match.candidate.url!, match.candidate.title, match.score);
      }
    }
    return null;
  }

  Future<T> _call<T>(Source source, Future<T> Function(String token) request) {
    final token =
        'hvupd_${source.id}_${DateTime.now().microsecondsSinceEpoch}';
    _activeTokens[token] = source;
    return request(token).timeout(requestTimeout, onTimeout: () {
      source.cancelRequest(token);
      throw TimeoutException('The source took too long to answer.');
    }).whenComplete(() => _activeTokens.remove(token));
  }

  Future<void> _recordError(OfflineMedia media, ItemType type, String? sourceId,
      String? sourceName, String message) async {
    try {
      await UpdateRepository.setError(HvUpdateError()
        ..mediaKey = hvMediaKey(type.index, media.mediaId ?? '')
        ..mediaId = media.mediaId ?? ''
        ..mediaTypeIndex = type.index
        ..mediaTitle = media.displayTitle
        ..poster = media.poster
        ..sourceId = sourceId
        ..sourceName = sourceName
        ..message = message
        ..timestamp = DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      Logger.e('HV: saving update error failed: $e');
    }
  }

  static String _describe(Object error) {
    var text = error.toString();
    for (final prefix in const ['Exception: ', 'PlatformException(']) {
      if (text.startsWith(prefix)) text = text.substring(prefix.length);
    }
    text = text.split('\n').first.trim();
    if (text.length > 300) text = '${text.substring(0, 300)}…';
    return text.isEmpty ? 'Unknown error' : text;
  }
}
