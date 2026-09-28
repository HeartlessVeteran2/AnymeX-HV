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
- The bridge is pinned to our fork, `HeartlessVeteran2/AnymeXExtensionRuntimeBridge-HV`, by
  commit. Fix bridge bugs there (small PR on the fork), then bump `ref:` in `pubspec.yaml` and
  run `flutter pub get`. The fork ignores its own `test/`; bridge tests live in
  `test/hv/extensions/`. `libtorrent_flutter` still comes from upstream.

## Where the fork's code lives

- **New features go in `lib/hv/<feature>/`.** Existing AnymeX files only get small hook calls
  (a button, a menu entry, a callback), each marked with a `// HV:` comment, so the fork stays
  easy to merge with upstream. Edit existing files in place and don't reformat them.
- New Isar collections live next to their feature (`lib/hv/**/models/`) and are added to the
  schema list in `lib/database/database.dart`. Existing collections are not changed.
- Settings for HV features use `HvKeys` (`lib/hv/common/hv_keys.dart`), all prefixed `hv`.
- Pure logic (matching, diffing, filters, ...) stays free of Flutter/Isar/GetX imports so it can be
  unit-tested in `test/hv/`.

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
  pushes to `claude/**`. A manual run can also build a debug APK.
- `.github/workflows/build.yml` — upstream release builds, on tags only.

## Branches

Development happens on `claude/anymex-feature-integration-1o2rd6`; `main` is not touched
directly.
