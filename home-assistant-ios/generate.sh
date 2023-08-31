#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf iOS/ po/
mkdir po
git clone --depth 1 https://github.com/home-assistant/iOS

files=($(cd "iOS/Sources/App/Resources/ca-ES.lproj" && ls *.strings | sed 's/.strings$//'))
for file in "${files[@]}"; do
    prop2po --personality=strings --encoding=utf-8 -i "iOS/Sources/App/Resources/ca-ES.lproj/$file.strings" -o "po/$file.po" --template="iOS/Sources/App/Resources/en.lproj/$file.strings"
done
