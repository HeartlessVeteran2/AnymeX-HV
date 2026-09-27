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

## Where the fork's code lives

- **New features go in `lib/hv/<feature>/`.** Existing AnymeX files only get small hook calls
  (a button, a menu entry, a callback), each marked with a `// HV:` comment, so the fork stays
  easy to merge with upstream. Edit existing files in place and don't reformat them.
- New Isar collections live next to their feature (`lib/hv/**/models/`) and are added to the
  schema list in `lib/database/database.dart`. Existing collections are not changed.
- Settings for HV features use `HvKeys` (`lib/hv/common/hv_keys.dart`), all prefixed `hv`.
- Pure logic (matching, diffing, filters, ...) stays free of Flutter/Isar/GetX imports so it can be
  unit-tested in `test/hv/`.

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
