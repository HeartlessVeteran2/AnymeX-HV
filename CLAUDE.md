# CLAUDE.md — AnymeX-HV

AnymeX-HV is a fork of [AnymeX](https://github.com/RyanYuuki/AnymeX): a Flutter anime/manga/novel
tracker (AniList, MAL, Simkl) with extension sources. This fork adds library, reader and discovery
features ported from two Kotlin manga readers (Komikku-HV and Otaku Reader), re-implemented in Dart.

## Stack

- Flutter 3.41.6 (the version CI uses; `.fvmrc` is stale), Dart 3.11.
- State: GetX (`GetxController`, `.obs`, `Obx`). Controllers are registered in `lib/main.dart`
  (`_initializeGetxController`).
- Storage: Isar (`isar_community`). Schemas are registered in `lib/database/database.dart`.
  Settings are `KeyValue` rows written through enum keys (`lib/database/data_keys/keys.dart`,
  `lib/database/kv_helper.dart`: `SomeKeys.key.get<T>(default)` / `.set(v)`). The enum value's
  `name` is the stored key, so key names must be unique across all enums.
- Navigation: `navigate(() => Page())` from `lib/utils/function.dart`.
- Extensions come from `anymex_extension_runtime_bridge` (git dependency); sources expose
  `search`, `getDetail`, `getPageList`, `getLatestUpdates`, ...
- The bridge is our fork, `HeartlessVeteran2/AnymeXExtensionRuntimeBridge-HV`
  (`hvBridgeRepo` in `lib/hv/extensions/bridge_repo.dart`), pinned by commit in `pubspec.yaml`
  for both `anymex_extension_runtime_bridge` and `libtorrent_flutter`. Fix bridge bugs there
  (small PR on the fork), then bump both `ref:`s and run `flutter pub get`. The fork ignores its
  own `test/`; bridge tests live in `test/hv/extensions/`.
- The Android runtime host APK / desktop jar come from the fork's releases (plugin manager,
  `RuntimeDownloader`). They are upstream's builds, copied daily by the fork's
  `mirror-runtime-releases` workflow; a release with a higher tag published on the fork wins.

## Where the fork's code lives

- **New features go in `lib/hv/<feature>/`.** Existing AnymeX files only get small hook calls
  (a button, a menu entry, a callback), each marked with a `// HV:` comment, so the fork stays
  easy to merge with upstream. Edit existing files in place and don't reformat them.
- New Isar collections live next to their feature (`lib/hv/**/models/`) and are added to the
  schema list in `lib/database/database.dart`. Existing collections are not changed.
- Settings for HV features use `HvKeys` (`lib/hv/common/hv_keys.dart`), all prefixed `hv`.
- Pure logic (matching, diffing, filters, ...) stays free of Flutter/Isar/GetX imports so it can be
  unit-tested in `test/hv/`.
- `HV_CHANGES.md` is the user-facing list of what this fork changes (linked from the top of
  `README.md`). A PR that adds or fixes something a user would notice adds a line there.

## HV features (where they live)

| Feature | Code | Hooked from |
|---|---|---|
| Title matcher | `lib/hv/matching/` | used by links, updates |
| Saved source links | `lib/hv/source_link/` | `media_details_controller.dart` (mapping + fetch) |
| Library update checker, Updates / Update errors screens, settings, notifications, auto-download | `lib/hv/library_update/`, `lib/hv/notifications/` | `main.dart`, `my_library.dart` header, settings sheet, `settings.dart` |
| Chapter list filters / mark read | `lib/hv/chapters/` | `chapter_list_builder.dart` |
| Library filters, grouping, hidden lists, search syntax, multi-select | `lib/hv/library/` | `library_controller.dart`, `my_library.dart`, `renameCustomList` |
| Reader: page gallery, bookmarks/notes, per-series settings, download ahead, delete after read, dual page, transition | `lib/hv/reader/`, `lib/hv/bookmarks/` | `reader_controller.dart` (`HvReaderHooks.attach/detach`, `_savePreferences`, `chapterNavigator`, spread pairing), top bars, `reader_view.dart`, `tabbed_reader_settings.dart` |
| Discover (feed, saved searches, library recommendations) | `lib/hv/discovery/` | settings sheet |
| Backup token fix | `lib/hv/backup/secret_keys.dart` | `backup_restore_service.dart` |
| Extension fixes: repo list after restart, install/update errors, source call timeouts | `lib/hv/extensions/` | `hv_bootstrap.dart`, `ExtensionItem.dart`, `ExtensionList.dart`, `search_view.dart`, `reader_controller.dart` (`fetchImages`) |

Isar collections added: `HvSourceLink`, `HvChapterUpdate`, `HvUpdateError`, `HvPageBookmark`,
`HvBookmarkCollection`, `HvReaderNote` (all registered in `lib/hv/hv_bootstrap.dart`).
Widgets that sit in a `Stack` return `Positioned` at the top with the `Obx` inside it.

## Commands

```bash
scripts/hv/setup_env.sh                       # install Flutter 3.41.6, stub .env, pub get
flutter analyze --no-fatal-infos --no-fatal-warnings lib test
flutter test
scripts/hv/codegen.sh                         # after changing an Isar model in lib/hv
```

`.env` is required as an asset but is gitignored; `setup_env.sh` writes the stub from
`DEVELOPMENT.md`. `flutter analyze` on the whole repo reports errors in the vendored
`packages/rhttp/test` (missing `mocktail`); analyze `lib test` instead. `lib` has no errors —
keep it that way.

## CI

- `.github/workflows/hv_ci.yml` — analyze `lib test` (errors fail) + `flutter test`, on PRs and
  pushes to `claude/**`. A manual run can also build a debug APK, and run the app on Linux
  (`runtime_tests`): `integration_test/hv/extension_flow_test.dart` drives the extension path end
  to end and uploads logs (`HVRESULT` lines) and screenshots. It needs live third-party sites, so
  it never gates a PR. `integration_test` is added by that job, not in `pubspec.yaml`: as a dev
  dependency its Android test libraries make R8 fail debug APK builds.
- `.github/workflows/build.yml` — upstream release builds, on tags only.

## Branches

Work goes on branches named `claude/anymex-feature-integration-1o2rd6-<topic>`, cut from `main`,
one small PR each so the review bots can read the diff (Sourcery stops at 150k diff characters,
CodeAnt at 100 files). `main` is not touched directly.
