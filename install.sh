#!/bin/bash

set -e

SCRIPT_DIR=$(dirname $0)
pushd "$SCRIPT_DIR" >/dev/null


for SFILE in $(ls -1 "./" | grep '^_'); do
    TARGET_FILE=$(echo "$SFILE" | sed 's/^_/./g')
    TARGET_FULL="$HOME/$TARGET_FILE"
    echo "$SFILE"
    if [ -L "$TARGET_FULL" ]; then
        rm "$TARGET_FULL"
    fi
    if [ -e "$TARGET_FULL" ]; then
        echo "$HOME/$TARGET_FILE exits. creating a backup"
        mv "$HOME/$TARGET_FILE" "$HOME/$TARGET_FILE.backup"
    fi
    ln -s "$PWD/$SFILE" "$TARGET_FULL"
done

popd >/dev/null
