#!/usr/bin/env bash
# HV: one-shot local setup for working on AnymeX-HV (Linux/macOS shells).
# Installs the Flutter version CI uses, writes a stub .env and fetches packages.
set -euo pipefail

FLUTTER_VERSION="3.41.6"
FLUTTER_DIR="${FLUTTER_DIR:-$HOME/flutter}"
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  echo "Installing Flutter $FLUTTER_VERSION to $FLUTTER_DIR"
  # Flutter publishes Linux archives for x64 only, macOS ones for x64 and arm64.
  case "$(uname -s)-$(uname -m)" in
    Linux-x86_64) archive="linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" ;;
    Darwin-arm64) archive="macos/flutter_macos_arm64_${FLUTTER_VERSION}-stable.zip" ;;
    Darwin-x86_64) archive="macos/flutter_macos_${FLUTTER_VERSION}-stable.zip" ;;
    *)
      echo "No Flutter archive for $(uname -s) $(uname -m): install Flutter $FLUTTER_VERSION" \
        "yourself and run again with FLUTTER_DIR set to it." >&2
      exit 1
      ;;
  esac
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/${archive##*/}" \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/$archive"
  case "$archive" in
    *.zip) unzip -q "$tmp/${archive##*/}" -d "$(dirname "$FLUTTER_DIR")" ;;
    *) tar -xf "$tmp/${archive##*/}" -C "$(dirname "$FLUTTER_DIR")" ;;
  esac
  rm -rf "$tmp"
  git config --global --add safe.directory "$FLUTTER_DIR" || true
fi
export PATH="$FLUTTER_DIR/bin:$PATH"

cd "$ROOT"
if [ ! -f .env ]; then
  # Stub values from DEVELOPMENT.md; enough to build and run tests.
  cat > .env <<'ENV'
AL_CLIENT_ID=0
AL_CLIENT_SECRET=0
SIMKL_CLIENT_ID=0
SIMKL_CLIENT_SECRET=0
MAL_CLIENT_ID=0
MAL_CLIENT_SECRET=0
CALLBACK_SCHEME=anymex://callback
COMMENTS_BASE_URL=https://whzwmfxngelicmjyxwmr.supabase.co/functions/v1
ENV
fi

flutter --version
flutter pub get
