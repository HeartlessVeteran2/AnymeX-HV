#!/usr/bin/env bash
# HV: regenerate the Isar code for lib/hv models only.
# build_runner with a build filter treats the upstream lib/database/*.g.dart
# files as conflicting outputs and may delete them, so they are restored from
# git afterwards (upstream models are never changed on this branch).
set -euo pipefail
cd "$(dirname "$0")/../.."
dart run build_runner build --delete-conflicting-outputs --build-filter="lib/hv/**"
git checkout -- lib/database/isar_models/
git status --short lib/hv
