import 'dart:async';

import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/database/data_keys/keys.dart';
import 'package:anymex/utils/logger.dart';
import 'package:get/get.dart';

/// "Hide Adult Content" (Settings → Common), on by default. It decides
/// whether search, the home page and the calendar can show 18+ titles.
bool hvHideAdultContent() => General.hideAdultContent.get<bool>(true);

/// Whether search includes 18+ titles: the setting is off and search's Adult
/// button is on. The same rule search uses when it opens.
bool hvAdultSearchOn() =>
    !hvHideAdultContent() && General.searchIsAdult.get<bool>(false);

/// Reloads the home page after "Hide Adult Content" changed, so its lists
/// follow the new value without a restart.
void hvOnHideAdultContentChanged() {
  if (!Get.isRegistered<ServiceHandler>()) return;
  unawaited(Get.find<ServiceHandler>().fetchHomePage().catchError(
      (Object e) => Logger.i('Reloading home after adult setting: $e')));
}
