import 'dart:async';

import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/controllers/services/anilist/anilist_data.dart';
import 'package:anymex/database/data_keys/keys.dart';
import 'package:anymex/hv/common/core/adult_filter.dart';
import 'package:anymex/hv/common/core/latest_only.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/utils/logger.dart';
import 'package:get/get.dart';

/// "Hide Adult Content" (Settings → Common), on by default. It decides
/// whether search, the home page and the calendar can show 18+ titles.
bool hvHideAdultContent() => General.hideAdultContent.get<bool>(true);

/// Whether search includes 18+ titles: the setting is off and search's Adult
/// button is on. The same rule search uses when it opens.
bool hvAdultSearchOn() =>
    !hvHideAdultContent() && General.searchIsAdult.get<bool>(false);

/// Home reloads after the setting changed, one at a time, so the reload for
/// the latest value is the one that finishes last.
final _homeReloads = HvLastRunQueue();

/// Follows a change of "Hide Adult Content" on the home page without a
/// restart: the home page reloads. When hiding, 18+ titles already on the
/// AniList home page are dropped first, so they don't stay up if the reload
/// fails (offline). MyAnimeList's lists carry no 18+ flag; they follow on
/// the reload.
void hvOnHideAdultContentChanged() {
  if (!Get.isRegistered<ServiceHandler>()) return;
  if (Get.isRegistered<AnilistData>()) {
    hvDropAdult(hvAnilistHomeLists(Get.find<AnilistData>()));
  }
  unawaited(_homeReloads
      .run(() => Get.find<ServiceHandler>().fetchHomePage())
      .catchError(
          (Object e) => Logger.i('Reloading home after adult setting: $e')));
}

/// The AniList home page's lists, anime and manga.
List<RxList<Media>> hvAnilistHomeLists(AnilistData data) => [
      data.upcomingAnimes,
      data.popularAnimes,
      data.trendingAnimes,
      data.latestAnimes,
      data.recentlyUpdatedAnimes,
      data.popularMangas,
      data.morePopularMangas,
      data.latestMangas,
      data.mostFavoriteMangas,
      data.topRatedMangas,
      data.topUpdatedMangas,
      data.topOngoingMangas,
      data.trendingMangas,
    ];

/// Removes the 18+ titles from [lists] while "Hide Adult Content" is on:
/// titles AniList flagged, and the bundled fallback titles, which show until
/// the first load from AniList replaces them and stay if that load fails.
void hvDropAdult(Iterable<RxList<Media>> lists) {
  if (!hvHideAdultContent()) return;
  for (final list in lists) {
    list.removeWhere((m) => hvIsAdultTitle(m.id, isAdult: m.isAdult));
  }
}
