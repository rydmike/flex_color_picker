#!/usr/bin/env bash

set -euo pipefail

# Prepares a fresh git worktree for development: copies the one gitignored file
# an Android example build may want, then resolves Dart/Flutter packages for the
# package root and the example app.
#
# Run it from the new worktree root, or let Cursor / Codex run it through
# .cursor/worktrees.json and .codex/environments/environment.toml. Claude Code
# copies the same file via .worktreeinclude, but still needs the `pub get` this
# script does — run it by hand there.

worktree_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$worktree_root"

# Cursor exports ROOT_WORKTREE_PATH during worktree creation. Otherwise use the
# main checkout, which `git worktree list` always reports first.
source_root="${ROOT_WORKTREE_PATH:-}"
if [[ -z "$source_root" ]]; then
  source_root="$(git worktree list --porcelain 2>/dev/null | sed -nE '1s/^worktree //p')"
fi

if [[ -z "$source_root" || "$source_root" == "$worktree_root" ]]; then
  echo "No separate source checkout found; skipping the local.properties copy." >&2
  echo "This looks like the main checkout rather than a worktree." >&2
else
  echo "Copying gitignored setup files from: $source_root"

  # Local Android SDK paths for the example app. Keep in sync with .worktreeinclude.
  # Flutter can regenerate this file; skip quietly when the source has none.
  local_properties_src="$source_root/example/android/local.properties"
  local_properties_dst="$worktree_root/example/android/local.properties"
  if [[ -f "$local_properties_src" ]]; then
    if [[ -f "$local_properties_dst" ]]; then
      echo "  example/android/local.properties already present, left untouched"
    else
      mkdir -p "$(dirname -- "$local_properties_dst")"
      cp "$local_properties_src" "$local_properties_dst"
      echo "  example/android/local.properties copied"
    fi
  fi
fi

# Local development pins Flutter with fvm; fall back to a plain flutter on PATH.
if command -v fvm >/dev/null 2>&1; then
  flutter_cmd=(fvm flutter)
else
  flutter_cmd=(flutter)
fi

echo "Running ${flutter_cmd[*]} pub get"
"${flutter_cmd[@]}" pub get

echo "Running ${flutter_cmd[*]} pub get in example/"
( cd example && "${flutter_cmd[@]}" pub get )

cat <<NEXT

Worktree ready: $worktree_root

Next steps:
  - Package tests: ${flutter_cmd[*]} test
  - Example app:   cd example && ${flutter_cmd[*]} run
  - The first iOS/macOS example run may take a bit while Swift Package Manager resolves.
    Do not run pod install; flutter run in example/ generates the ephemeral Swift package.
NEXT
