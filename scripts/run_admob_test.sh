#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
for arg in "$@"; do
  case "$arg" in
    --release|--profile) echo 'AdMob test launcher supports debug builds only.' >&2; exit 2 ;;
  esac
done
exec flutter run --debug -t lib/main_admob_test.dart --dart-define=ADMOB_TEST_MODE=true "$@"
