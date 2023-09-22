#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

git clone --depth 1 https://github.com/OpenEmu/OpenEmu.git tmp/OpenEmu

files=($(cd "tmp/OpenEmu/OpenEmu/ca.lproj" && ls *.strings | sed 's/.strings$//'))
for file in "${files[@]}"; do
    cp "tmp/OpenEmu/OpenEmu/en.lproj/$file.strings" "tmp/$file.template"
    cat "tmp/OpenEmu/OpenEmu/ca.lproj/$file.strings" | grep -F -v '// TODO' | grep -F -v ', TODO' | grep -F -v '/*' | grep . > "tmp/$file.strings"
    prop2po --personality=strings --encoding=utf-8 -i "tmp/$file.strings" -o "translations/$file.po" --template="tmp/$file.template"
done
