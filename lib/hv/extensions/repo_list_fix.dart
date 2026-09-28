import 'dart:convert';

import 'package:anymex_extension_runtime_bridge/Settings/KvStore.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:get/get.dart';

/// Keeps the extension repo lists visible after a restart (upstream AnymeX
/// issue #585).
///
/// The bridge's Mangayomi manager saves its repos under
/// `'<managerId><type>Repos'` and reads them back to fetch extensions, but
/// only fills the list the Repositories screen shows (`getReposRx`) when a
/// repo is added or removed. So after a restart the screen says "No
/// repositories yet" while the extensions from those repos keep working.
///
/// This fills any *empty* list from the stored value. Lists a manager already
/// filled itself are left alone, and add/remove keep working as before
/// because the managers read storage, not this list.
class HvRepoListFix {
  HvRepoListFix._();

  static Worker? _worker;

  /// Restores the lists now and again whenever managers are (re)registered,
  /// e.g. after the runtime bridge loads.
  static void attach() {
    if (_worker != null || !Get.isRegistered<ExtensionManager>()) return;
    final em = Get.find<ExtensionManager>();
    _worker = ever<List<Extension>>(em.managers, restore);
    restore(em.managers);
  }

  static void restore(List<Extension> managers) {
    try {
      restoreRepoLists(managers, (key) => getVal<List<String>>(key));
    } catch (_) {
      // Never let a display fix break startup.
    }
  }
}

/// Fills each manager's empty repo list from storage, read through [read].
void restoreRepoLists(
  Iterable<Extension> managers,
  List<String>? Function(String key) read,
) {
  for (final manager in managers) {
    for (final type in ItemType.values) {
      if (!_supports(manager, type)) continue;
      final rx = manager.getReposRx(type);
      if (rx.value.isNotEmpty) continue;
      final repos = decodeStoredRepos(read(repoStorageKey(manager.id, type)),
          managerId: manager.id);
      if (repos.isNotEmpty) rx.value = repos;
    }
  }
}

/// The key the bridge's managers store their repo list under.
String repoStorageKey(String managerId, ItemType type) =>
    '$managerId${type.name}Repos';

/// Decodes a stored repo list, skipping malformed entries.
///
/// Removing a repo from the screen looks its manager up by
/// [Repo.managerId], so entries saved without one get [managerId].
List<Repo> decodeStoredRepos(List<String>? encoded, {String? managerId}) {
  if (encoded == null) return const [];
  final repos = <Repo>[];
  for (final raw in encoded) {
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic> || json['url'] is! String) continue;
      final repo = Repo.fromJson(json);
      repos.add(repo.managerId != null || managerId == null
          ? repo
          : Repo(
              url: repo.url,
              name: repo.name,
              iconUrl: repo.iconUrl,
              extensions: repo.extensions,
              managerId: managerId,
            ));
    } catch (_) {}
  }
  return repos;
}

bool _supports(Extension manager, ItemType type) => switch (type) {
      ItemType.anime => manager.supportsAnime,
      ItemType.manga => manager.supportsManga,
      ItemType.novel => manager.supportsNovel,
    };
