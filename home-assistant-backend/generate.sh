#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf *.whl home_assistant/ translations/

url=$(curl -s https://pypi.org/project/homeassistant/#files | \
grep -oE 'https://files.pythonhosted.org/[^"]+.whl' | \
head -n 1)
file_name=$(basename "$url")
curl -O "$url" && unzip -o "$file_name"

for lang in ca en; do
    find homeassistant/components -name "$lang.json" | while read -r src_file; do
        dir_name=$(basename $(dirname $(dirname "$src_file")))
        mkdir -p translations/"$dir_name"
        cp "$src_file" translations/"$dir_name"/"$lang".json
    done
done

