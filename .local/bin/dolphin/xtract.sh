#!/bin/bash

# Remove file:// if passed from Dolphin
ARCHIVE=$(echo "$1" | sed 's|file://||')

# Set output dir
DEST_DIR="$(dirname "$ARCHIVE")"

cd "$DEST_DIR" || exit 1

case "$ARCHIVE" in
  *.tar.bz2)   tar xvjf "$ARCHIVE" ;;
  *.tar.gz)    tar xvzf "$ARCHIVE" ;;
  *.tar.xz)    tar xvJf "$ARCHIVE" ;;
  *.tar)       tar xvf "$ARCHIVE" ;;
  *.zip)       unzip -o "$ARCHIVE" ;;
  *.rar)       unrar x -o+ "$ARCHIVE" ;;
  *.7z)        7z x "$ARCHIVE" ;;
  *)           notify-send "❌ Unknown archive format: $ARCHIVE" ;;
esac

