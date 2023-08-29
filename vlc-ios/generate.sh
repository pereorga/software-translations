#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf vlc-ios/ po/
mkdir po/
git clone --depth 1 https://code.videolan.org/videolan/vlc-ios.git

files=($(cd "vlc-ios/Resources/ca.lproj" && ls *.strings | sed 's/.strings$//'))
for file in "${files[@]}"; do
    # Copy template.
    cp "vlc-ios/Resources/en.lproj/$file.strings" "$file.template"

    # Copy Catalan translation, optionally converting it to UTF-8.
    if file "vlc-ios/Resources/ca.lproj/$file.strings" | grep -q 'UTF-16'; then
        iconv -f UTF-16LE -t UTF-8 "vlc-ios/Resources/ca.lproj/$file.strings" > "$file.strings"
    else
        cp "vlc-ios/Resources/ca.lproj/$file.strings" "$file.strings"
    fi

    # Convert to Gettext.
    prop2po --encoding=utf-8 -i "$file.strings" -o "po/$file.po" --template="$file.template"
done
