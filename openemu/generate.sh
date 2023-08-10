#!/bin/sh
cd "$(dirname "$0")"

base_url="https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu"
declare -a files=("ControlLabels" "Debug" "InfoPlist" "Localizable" "MainMenu" "OEControls")

# Fetching and filtering ca.lproj files
for file in "${files[@]}"; do
    curl "$base_url/ca.lproj/$file.strings" | grep -F -v '// TODO' | grep -F -v '/*' | grep . > "files/$file.strings"
done

# Fetching en.lproj files
for file in "${files[@]}"; do
    curl "$base_url/en.lproj/$file.strings" > "files/$file.template"
done

# Running prop2po
for file in "${files[@]}"; do
    prop2po --personality=strings --encoding=utf-8 -i "files/$file.strings" -o "po/$file.po" --template="files/$file.template"
done
