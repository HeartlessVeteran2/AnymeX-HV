# What AnymeX-HV changes

AnymeX-HV is a fork of [AnymeX](https://github.com/RyanYuuki/AnymeX) by RyanYuuki. It adds
library, reader and discovery features from two manga readers,
[Komikku-HV](https://github.com/HeartlessVeteran2/komikku-HV) and
[Otaku Reader](https://github.com/HeartlessVeteran2/Otaku-Reader), rewritten in Dart. It also
fixes several known extension problems.

Upstream code is changed as little as possible, so updates from AnymeX stay easy to merge:

- New code lives in `lib/hv/`.
- Upstream files only get small hooks, each marked with a `// HV:` comment.
- Search the code for `HV:` to see every place this fork touches upstream code.

Each change below links to the pull request that made it.

## Extension fixes

- **The repository list was empty after restarting the app** (upstream issue #585). The
  extensions still worked. The list now reloads from storage.
  [#3](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/3)
- **Installing, updating or removing an extension silently did nothing when it failed**
  (upstream #583, #515). The error is now shown, along with how to fix it.
  [#4](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/4),
  [#16](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/16)
- **Source searches and page loads could spin forever or show "No results"** (upstream #524,
  #591). They now time out with a readable error, and failed searches aren't cached.
  [#5](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/5)
- **The reader showed "No pages found" for chapters that do have pages.** Saving website
  cookies clashed with other database writes and made the page request fail.
  [#14](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/14),
  [#18](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/18)
- **The app uses our own fork of the extension bridge,**
  [AnymeXExtensionRuntimeBridge-HV](https://github.com/HeartlessVeteran2/AnymeXExtensionRuntimeBridge-HV).
  The runtime APK/JAR and the torrent engine also come from it. The fork passes Mangayomi
  sources the settings they were missing (API URL, date format). See its
  [HV_CHANGES.md](https://github.com/HeartlessVeteran2/AnymeXExtensionRuntimeBridge-HV/blob/main/HV_CHANGES.md).
  [#15](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/15),
  [#19](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/19)

## Added features

All of these arrived in [#2](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/2) and were
fixed up in the PRs listed under *Other fixes*.

### Library

- **New chapter checks.** The app checks library titles for new chapters on their sources,
  on a schedule or on demand. It includes:
  - Updates and Update errors screens;
  - settings for how often to check, which lists to check and which titles to skip;
  - notifications, and optional automatic download of new chapters.
- **Saved source links.** The app remembers which entry on a source each title matched. The
  details page then opens it without searching again, and the update checker knows where to
  look. Titles are matched automatically, and a manual pick always wins.
- **Library tools:**
  - filters and grouping;
  - hidden lists;
  - search syntax;
  - selecting several titles at once.
- **Chapter list:** filters and mark-as-read actions.

### Reader

- Page gallery.
- Page bookmarks and notes, with collections.
- Per-series reader settings.
- Download ahead, and delete after reading (keeping the last N chapters).
- Two-page mode keeps wide pages on their own. The arrow keys move one spread at a time
  (upstream #494, [#6](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/6)).
- Chapter transition page.

### Discover

- A feed made of rows you choose. Each row shows one source's latest updates, or a search you
  saved on it.
- Recommendations for your library: AniList recommendations for the titles you have, ranked
  by how many of them recommend each one.

### Backups

- **Login tokens could end up in backups.** The backup's "auth tokens" switch never matched
  anything, so tokens were exported whenever settings were. It now leaves them out, along with
  signed-in site cookies.
  [#11](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/11)

## Other fixes

- **Saved source links** were lost on errors or overwritten by weaker matches.
  [#7](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/7),
  [#17](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/17)
- **Update checker:**
  - the unread count and anime progress were wrong;
  - stale links were still followed;
  - a failed or cancelled run still pushed back the next automatic check;
  - titles re-linked during a run were overwritten;
  - a check could stay stuck as "running" until the app was restarted.

  [#8](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/8),
  [#17](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/17),
  [#21](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/21)
- **Library:**
  - renaming a list broke update and auto-download list choices;
  - deleted lists stopped auto-download;
  - a selection carried over when switching media type.

  [#9](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/9),
  [#17](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/17)
- **Reader:**
  - color filter blend modes;
  - wide pages in two-page mode, on Android and Linux;
  - "keep last N" deleted unread chapters, and "keep last 0" sometimes kept the chapter just
    finished;
  - a failed next chapter now shows a message, once;
  - reading downloaded chapters in continuous mode kept every page in memory until the app
    closed, which could crash it on long chapters (an upstream bug).

  [#10](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/10),
  [#16](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/16),
  [#21](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/21)
- **Recommendations:** a failed load was cached as "no recommendations" for 24 hours, and saving
  the results could turn a successful load into an error.
  [#12](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/12),
  [#18](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/18),
  [#21](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/21)
- **Startup:** a failed AniList home page load at startup is now handled.
  [#18](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/18)

## Test builds

- **Test APKs install next to AnymeX.** They are named "AnymeX HV" (app ID
  `com.ryan.anymex.hv`), so you can keep the original app and its data.
- **Each test APK installs over the previous one.** They are signed with a test key kept in this
  repository (`android/hv-test.keystore`), so updating doesn't need an uninstall. The key is
  public: it's only for test builds, never for a release shared with others. A release build
  uses it only when CI marks it as a test build; any other release build needs a real key.
- **Release and debug APKs.** The release APK runs at full speed; the debug one is slower but
  shows full error details.
- Both apps answer `anymex://` links (adding a repository, the tracker login callback). If
  Android asks which app to open, pick AnymeX HV.
- Logging in to MAL, Simkl, or AniList through the browser needs API clients of your own, set
  as repository secrets (`AL_CLIENT_ID`, `AL_CLIENT_SECRET`, `MAL_CLIENT_ID`,
  `MAL_CLIENT_SECRET`, `SIMKL_CLIENT_ID`, `SIMKL_CLIENT_SECRET`). AniList's "token" login
  works without them.

[#24](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/24)

## Testing

- Unit tests for the fork's code are in `test/hv/`. `.github/workflows/hv_ci.yml` runs them,
  along with `flutter analyze`, on every pull request.
- A manual CI job runs the app on Linux and drives the extension path end to end:
  install sources, search, open details, read pages, run the update checker, and restart.
  [#13](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/13),
  [#18](https://github.com/HeartlessVeteran2/AnymeX-HV/pull/18)

For developers, [CLAUDE.md](CLAUDE.md) lists where each feature's code lives and how it hooks
into upstream files.
