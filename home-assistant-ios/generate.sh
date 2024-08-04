#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

git clone --depth 1 https://github.com/home-assistant/iOS tmp/iOS

files=($(cd "tmp/iOS/Sources/App/Resources/ca-ES.lproj" && ls *.strings | sed 's/.strings$//'))
for file in "${files[@]}"; do
    prop2po \
        --personality=strings \
        --encoding=utf-8 \
        -i "tmp/iOS/Sources/App/Resources/ca-ES.lproj/$file.strings" \
        -o "translations/$file.po" \
        --template="tmp/iOS/Sources/App/Resources/en.lproj/$file.strings"

    # Try to remove English (untranslated) strings.
    node ../removeIdenticalMsgidMsgstr.js "translations/$file.po"
done
