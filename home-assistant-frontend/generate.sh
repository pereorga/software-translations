#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

url=$(curl -s https://pypi.org/project/home-assistant-frontend/#files | \
grep -oE 'https://files.pythonhosted.org/[^"]+.whl' | \
head -n 1)
file_name=$(basename "$url")
curl "$url" > "tmp/$file_name" && unzip -o -d tmp/ "tmp/$file_name"

for lang in ca en; do
    find tmp/hass_frontend/static/translations -name "*$lang-*.json" | while read -r src_file; do
        dir_name=$(basename $(dirname "$src_file"))
        mkdir -p translations/"$dir_name"
        cp "$src_file" translations/"$dir_name"/"$lang".json
    done
done

