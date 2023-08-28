#!/usr/bin/env bash

cd "$(dirname "$0")"

repo_url="https://github.com/OpenEmu/OpenEmu.git"
temp_dir="temp_openemu"

rm -rf "$temp_dir"
git clone --depth 1 "$repo_url" "$temp_dir"

files=($(cd "$temp_dir/OpenEmu/ca.lproj" && ls *.strings | sed 's/.strings$//'))
for file in "${files[@]}"; do
    cp "$temp_dir/OpenEmu/en.lproj/$file.strings" "files/$file.template"
    cat "$temp_dir/OpenEmu/ca.lproj/$file.strings" | grep -F -v '// TODO' | grep -F -v ', TODO' | grep -F -v '/*' | grep . > "files/$file.strings"
    prop2po --personality=strings --encoding=utf-8 -i "files/$file.strings" -o "po/$file.po" --template="files/$file.template"
done
