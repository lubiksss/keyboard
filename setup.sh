#!/usr/bin/env bash
set -euo pipefail

# 이 스크립트가 있는 디렉터리(리포 루트라고 가정)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# 소스 경로 (반드시 실제로 존재해야 함)
KARAB_SRC="$SCRIPT_DIR/karabiner"

# 목적지 경로
KARAB_DEST="$HOME/.config/karabiner"

# 존재 확인
[ -d "$KARAB_SRC" ] || { echo "ERROR: $KARAB_SRC not found"; exit 1; }

# Karabiner: ~/.config/karabiner -> <repo>/karabiner
mkdir -p "$HOME/.config"
rm -rf "$KARAB_DEST"
ln -sfn "$KARAB_SRC" "$KARAB_DEST"

# 검증
echo "Karabiner link:"
ls -ld "$KARAB_DEST"

echo "Done! Restart Karabiner-Elements."
