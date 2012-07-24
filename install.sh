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

# add own bashrc to the existing ~/.bashrc + delete existing
# bashrc_nmandery inclusion
[ -f ~/.bashrc ] || touch ~/.bashrc

sed -i '/dotfiles nmandery start/,/dotfiles nmandery end/d' ~/.bashrc
cat >>~/.bashrc <<EOF
# dotfiles nmandery start
[ -f ~/.bashrc_nmandery ] && . ~/.bashrc_nmandery
# dotfiles nmandery end
EOF

# add own zshrc to the existing ~/.zshrc + delete existing
# zshrc_nmandery inclusion
[ -f ~/.zshrc ] || touch ~/.zshrc

sed -i '/dotfiles nmandery start/,/dotfiles nmandery end/d' ~/.zshrc
cat >>~/.zshrc <<EOF
# dotfiles nmandery start
[ -f ~/.zshrc_nmandery ] && . ~/.zshrc_nmandery
# dotfiles nmandery end
EOF


popd >/dev/null
