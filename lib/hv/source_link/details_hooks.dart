import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/database/isar_models/chapter.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/library_update/chapter_recorder.dart';
import 'package:anymex/hv/matching/title_matcher.dart';
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
      if (link == null ||
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

  /// Forget the saved match after it stopped working, so the next attempt
  /// searches again.
  static Future<void> forgetMapping(Media media) async {
    _failedThisSession.add(_key(media));
    try {
      await SourceLinkRepository.remove(media.mediaType.index, media.id);
    } catch (e) {
      Logger.e('HV: removing source link failed: $e');
    }
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

      final existing = SourceLinkRepository.get(typeIndex, media.id);
      final sameTarget = existing != null &&
          existing.sourceId == sourceId &&
          existing.url == mapped.id;

      // A different source or entry starts a fresh chapter baseline.
      final link = sameTarget
          ? existing
          : (HvSourceLink()
            ..mediaId = media.id
            ..mediaTypeIndex = typeIndex
            ..knownChapterKeys = []);
      final wasConfirmed = sameTarget && existing.userConfirmed;
      final linkedAt = sameTarget ? existing.linkedAt : 0;
      link
        ..serviceIndex = media.serviceType.index
        ..sourceId = sourceId
        ..sourceName = source.name
        ..url = mapped.id
        ..title = mapped.title
        ..userConfirmed = userConfirmed || isSelf || wasConfirmed
        ..matchScore = score
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
      await SourceLinkRepository.save(link);
    } catch (e) {
      Logger.e('HV: saving source link failed: $e');
    }
  }

  static Media _mapped(String url, String title, d.ItemType type) => Media(
        id: url,
        title: title,
        romajiTitle: title,
        mediaType: type,
        serviceType: ServicesType.extensions,
      );
}
