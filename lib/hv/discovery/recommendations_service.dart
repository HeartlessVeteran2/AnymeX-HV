import 'package:anymex/controllers/services/anilist/anilist_api.dart';
import 'package:anymex/database/isar_models/offline_media.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/discovery/core/rec_ranking.dart';
import 'package:anymex/hv/library/library_membership.dart';
import 'package:anymex/hv/source_link/source_link_repository.dart';
import 'package:anymex/utils/logger.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    hide isar;

/// "Recommended for your library": AniList recommendations of every title
/// in the library, merged and ranked by how many of your titles recommend
/// each one (Komikku's "find common recommendations").
class HvRecommendations {
  HvRecommendations._();

  static const Duration cacheFor = Duration(hours: 24);
  static const int _batch = 50;

  static const String _query = r'''
query ($ids: [Int], $malIds: [Int], $type: MediaType, $page: Int) {
  Page(page: $page, perPage: 50) {
    media(id_in: $ids, idMal_in: $malIds, type: $type) {
      id
      title { userPreferred }
      recommendations(sort: RATING_DESC, perPage: 10) {
        nodes {
          rating
          mediaRecommendation {
            id idMal format averageScore
            title { userPreferred english romaji }
            coverImage { large }
          }
        }
      }
    }
  }
}''';

  static String _cacheKey(ItemType type) => 'hvRecsCache_${type.index}';

  /// Bumped by every [load], so a slower, older load can't overwrite the
  /// cache a newer one wrote.
  static final Map<ItemType, int> _generation = {};

  /// Cached results when fresh, else null.
  static List<RankedRec>? cached(ItemType type) {
    final json = KvHelper.get<Map<String, dynamic>>(_cacheKey(type),
        defaultVal: const {});
    final at = json['at'];
    if (at is! int) return null;
    if (DateTime.now().millisecondsSinceEpoch - at > cacheFor.inMilliseconds) {
      return null;
    }
    return [
      for (final item in (json['items'] as List? ?? const []))
        if (item is Map<String, dynamic>)
          if (RankedRec.fromJson(item) case final RankedRec r) r,
    ];
  }

  /// Fetches and ranks recommendations for the library titles of [type]
  /// (anime or manga; novels are AniList manga).
  static Future<List<RankedRec>> load(ItemType type,
      {bool refresh = false}) async {
    if (!refresh) {
      final hit = cached(type);
      if (hit != null) return hit;
    }
    final generation = _generation[type] = (_generation[type] ?? 0) + 1;
    final library = [
      for (final id in LibraryMembership.idsOfType(type.index))
        if (LibraryMembership.media(type.index, id) case final OfflineMedia m)
          m,
    ];

    // AniList can look titles up by MAL id (AniList and MAL entries both
    // store one) or by its own id. Extension-only titles have neither.
    final malIds = <int>{};
    final anilistIds = <int>{};
    final titleByMal = <int, String>{};
    final titleById = <int, String>{};
    for (final m in library) {
      final id = m.mediaId ?? '';
      final mal = int.tryParse(m.idMal ?? '');
      final numericId = int.tryParse(id);
      if (mal != null && mal > 0) {
        malIds.add(mal);
        titleByMal[mal] = m.displayTitle;
        if (numericId != null && numericId != mal) {
          titleById[numericId] = m.displayTitle;
        }
      } else if (numericId != null && _isAniList(m, type)) {
        anilistIds.add(numericId);
        titleById[numericId] = m.displayTitle;
      }
    }

    final edges = <RecEdge>[];
    var failedBatches = 0;
    final anilistType = type == ItemType.anime ? 'ANIME' : 'MANGA';
    Future<void> fetch(Map<String, dynamic> variables) async {
      final data = await AnilistApi().postQuery(_query, variables: {
        ...variables,
        'type': anilistType,
        'page': 1,
      });
      final media = data?['data']?['Page']?['media'];
      final errors = data?['errors'];
      // postQuery returns null (it doesn't throw) when AniList fails, and a
      // GraphQL error can come with partial data: use what came back, but
      // count the batch as failed so the result isn't cached.
      if (media is! List || (errors is List && errors.isNotEmpty)) {
        failedBatches++;
      }
      if (media is! List) return;
      for (final m in media) {
        final from = m['title']?['userPreferred'] as String? ?? '?';
        final nodes = m['recommendations']?['nodes'];
        if (nodes is! List) continue;
        for (final node in nodes) {
          final rec = node['mediaRecommendation'];
          if (rec == null || rec['id'] is! int) continue;
          final title = rec['title'] ?? const {};
          edges.add(RecEdge(
            fromTitle: from,
            mediaId: rec['id'] as int,
            idMal: rec['idMal'] as int?,
            title: title['userPreferred'] ??
                title['english'] ??
                title['romaji'] ??
                '?',
            cover: rec['coverImage']?['large'] as String?,
            format: rec['format'] as String?,
            averageScore: rec['averageScore'] as int?,
            rating: node['rating'] as int? ?? 0,
          ));
        }
      }
    }

    try {
      final mal = malIds.toList();
      for (var i = 0; i < mal.length; i += _batch) {
        await fetch({'malIds': mal.sublist(i, (i + _batch).clamp(0, mal.length))});
        await Future.delayed(const Duration(milliseconds: 700));
      }
      final ids = anilistIds.toList();
      for (var i = 0; i < ids.length; i += _batch) {
        await fetch({'ids': ids.sublist(i, (i + _batch).clamp(0, ids.length))});
        await Future.delayed(const Duration(milliseconds: 700));
      }
    } catch (e) {
      Logger.e('HV: recommendations failed: $e');
      failedBatches++;
    }

    if (failedBatches > 0 && edges.isEmpty) {
      throw Exception("Couldn't reach AniList. Check your connection and "
          'try again.');
    }
    final ranked = rankRecommendations(
      edges,
      excludeIds: {...anilistIds, ...titleById.keys},
      excludeMalIds: malIds,
    );
    // A partial result is shown but not cached, so the next visit retries
    // instead of keeping it for a day.
    if (failedBatches == 0 && _generation[type] == generation) {
      KvHelper.set(_cacheKey(type), {
        'at': DateTime.now().millisecondsSinceEpoch,
        'items': [for (final r in ranked.take(100)) r.toJson()],
      });
    }
    return ranked.take(100).toList();
  }

  /// A numeric id without a MAL id is an AniList id when the title was
  /// opened from AniList (index 0 of `ServicesType`).
  static bool _isAniList(OfflineMedia m, ItemType type) {
    final link = SourceLinkRepository.get(type.index, m.mediaId ?? '');
    final service = link?.serviceIndex ?? m.serviceIndex ?? 0;
    return service == 0;
  }
}
