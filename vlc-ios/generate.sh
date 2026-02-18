#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

git clone --depth 1 https://code.videolan.org/videolan/vlc-ios.git tmp/vlc-ios

files=($(cd "tmp/vlc-ios/Resources/ca.lproj" && ls *.strings | sed 's/.strings$//'))
for file in "${files[@]}"; do
    # Copy template.
    cp "tmp/vlc-ios/Resources/en.lproj/$file.strings" "tmp/$file.template"

    # Copy Catalan translation, optionally converting it to UTF-8.
    if file "tmp/vlc-ios/Resources/ca.lproj/$file.strings" | grep -q 'UTF-16'; then
        iconv -f UTF-16LE -t UTF-8 "tmp/vlc-ios/Resources/ca.lproj/$file.strings" > "tmp/$file.strings"
    else
        cp "tmp/vlc-ios/Resources/ca.lproj/$file.strings" "tmp/$file.strings"
    fi

    # Convert to Gettext.
    prop2po --encoding=utf-8 -i "tmp/$file.strings" -o "translations/$file.po" --template="tmp/$file.template"

    # Try to remove English (untranslated) strings.
    python3 ../removeIdenticalMsgidMsgstr.py "translations/$file.po"
done
