import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/library_update/chapter_recorder.dart';
import 'package:anymex/hv/matching/title_matcher.dart';
import 'package:anymex/hv/source_link/core/link_policy.dart';
import 'package:anymex/hv/source_link/link_merge.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';
import 'package:anymex/hv/source_link/source_link_repository.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    as d;

/// Hooks called from `MediaDetailsController` to remember which source entry
/// a title was matched to.
class HvDetailsHooks {
  HvDetailsHooks._();

  /// Titles whose saved match failed this session; they search as usual until
  /// the app restarts, so a broken link can't cause a retry loop.
  static final Set<String> _failedThisSession = {};

  static String _key(Media media) => '${media.mediaType.index}|${media.id}';

  /// A match the details page can use without searching the source again, or
  /// null to search as usual.
  static Media? savedMapping(Media media, d.Source source,
      {d.Source? initialSource}) {
    try {
      if (media.id.isEmpty || _failedThisSession.contains(_key(media))) {
        return null;
      }
      // A title opened straight from this source: its id is its URL here.
      if (media.serviceType == ServicesType.extensions &&
          source.id != null &&
          (media.sourceId == source.id || initialSource?.id == source.id)) {
        return _mapped(media.id, media.title, media.mediaType);
      }
      final link = SourceLinkRepository.get(media.mediaType.index, media.id);
      // Ids are only unique within a service: AniList 105778 and MAL 105778
      // are different titles.
      if (link == null ||
          link.serviceIndex != media.serviceType.index ||
          link.sourceId != source.id ||
          link.url.isEmpty ||
          !link.isTrusted) {
        return null;
      }
      return _mapped(link.url, link.title ?? media.title, media.mediaType);
    } catch (e) {
      Logger.e('HV: reading saved source link failed: $e');
      return null;
    }
  }

  /// Stop using the saved match for the rest of this session after opening
  /// it failed, so the details page searches instead.
  ///
  /// The link itself is kept: the failure may be temporary (offline, a
  /// timeout, a request cancelled because another details page opened), and
  /// deleting it would lose a match the user picked and the chapters the
  /// update checker has already seen. A search that finds a better match
  /// replaces it through [onDetailFetched].
  static void skipSavedMapping(Media media) {
    _failedThisSession.add(_key(media));
  }

  /// Called after the details page fetched a title's chapters from [source].
  ///
  /// Saves (or refreshes) the link, and for library titles records chapters
  /// that weren't on the source at the last check as updates.
  static Future<void> onDetailFetched({
    required Media media,
    required d.Source source,
    required Media mapped,
    List<Chapter>? chapters,
    required bool userConfirmed,
  }) async {
    try {
      final sourceId = source.id;
      if (sourceId == null || sourceId.isEmpty || media.id.isEmpty) return;
      if (mapped.id.isEmpty) return;

      final typeIndex = media.mediaType.index;
      final isSelf = mapped.id == media.id;
      final score = (userConfirmed || isSelf)
          ? 1.0
          : TitleMatcher.bestMatch<String>(
                  [media.title, media.romajiTitle, ...media.synonyms],
                  [mapped.title],
                  (t) => [t],
                )?.score ??
              0.0;

      final serviceIndex = media.serviceType.index;
      final confirmed = userConfirmed || isSelf;
      final stored = SourceLinkRepository.get(typeIndex, media.id);
      // A link saved for the same id on another service is a different title.
      final existing =
          stored != null && stored.serviceIndex == serviceIndex ? stored : null;
      final sameTarget = existing != null &&
          existing.sourceId == sourceId &&
          existing.url == mapped.id;
      if (existing != null &&
          !sameTarget &&
          !hvShouldReplaceLink(
            existingConfirmed: existing.userConfirmed,
            existingTrusted: existing.isTrusted,
            newConfirmed: confirmed,
            newTrusted: confirmed || score >= _trustedScore,
          )) {
        return;
      }

      // A different source or entry starts a fresh chapter baseline.
      final link = sameTarget
          ? existing
          : (HvSourceLink()
            ..mediaId = media.id
            ..mediaTypeIndex = typeIndex
            ..knownChapterKeys = []);
      final wasConfirmed = sameTarget && existing.userConfirmed;
      final linkedAt = sameTarget ? existing.linkedAt : 0;
      // Refreshing the same entry never lowers its score, so a trusted link
      // can't become untrusted because one fetch matched worse.
      final keptScore = sameTarget && existing.matchScore > score
          ? existing.matchScore
          : score;
      link
        ..serviceIndex = serviceIndex
        ..sourceId = sourceId
        ..sourceName = source.name
        ..url = mapped.id
        ..title = mapped.title
        ..userConfirmed = confirmed || wasConfirmed
        ..matchScore = keptScore
        ..linkedAt =
            linkedAt > 0 ? linkedAt : DateTime.now().millisecondsSinceEpoch;

      if (chapters != null && chapters.isNotEmpty) {
        await ChapterRecorder.record(
          link: link,
          chapters: chapters,
          reportNew: LibraryMembership.contains(typeIndex, media.id),
          mediaTitle: media.title,
          poster: media.poster,
        );
      }
      // Recording awaited: another fetch may have saved a link meanwhile.
      // A different entry must pass the policy again before it's replaced;
      // the same entry is merged, so what that fetch recorded isn't lost.
      final latest = SourceLinkRepository.get(typeIndex, media.id);
      if (latest != null && latest.serviceIndex == serviceIndex) {
        if (latest.sourceId == sourceId && latest.url == mapped.id) {
          hvMergeSavedLink(link, latest);
        } else if (!hvShouldReplaceLink(
          existingConfirmed: latest.userConfirmed,
          existingTrusted: latest.isTrusted,
          newConfirmed: confirmed,
          newTrusted: confirmed || score >= _trustedScore,
        )) {
          return;
        }
      }
      await SourceLinkRepository.save(link);
    } catch (e) {
      Logger.e('HV: saving source link failed: $e');
    }
  }

  /// Same threshold as [HvSourceLink.isTrusted].
  static const _trustedScore = 0.7;

  static Media _mapped(String url, String title, d.ItemType type) => Media(
        id: url,
        title: title,
        romajiTitle: title,
        mediaType: type,
        serviceType: ServicesType.extensions,
      );
}
