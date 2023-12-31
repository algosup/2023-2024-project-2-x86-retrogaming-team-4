#!/usr/bin/env bash

set -Cue

thisDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rootDir="$(cd "$thisDir/.." && pwd)"
binDir="$rootDir/src/bin"

cd "${thisDir}" \
  && nasm main.asm -f bin -o "${binDir}/main.com" \

echo "Builded Successfully! ✅"

ROOT_DIR="$(cd "$thisDir/.." && pwd)"
BIN_DIR="$ROOT_DIR/src/bin"
DOSBOX_BIN="/opt/homebrew/bin/dosbox"
CONFIG_LOC="$ROOT_DIR"

"$DOSBOX_BIN" -c "MOUNT c $BIN_DIR" -c "C:" -c "keyb fr" -c "main.com"


#$ chmod +x builder.bash


