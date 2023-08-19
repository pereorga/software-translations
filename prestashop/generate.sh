#!/usr/bin/env bash

cd "$(dirname "$0")"

CURRENT_VERSION=8

rm -rf gettext
mkdir gettext
rm -rf TranslationFiles
git clone --depth=1 https://github.com/PrestaShop/TranslationFiles.git

cd "TranslationFiles/$CURRENT_VERSION/ca-ES/"
for file in *.{xlf,xliff}; do
    [ -f "$file" ] || continue

    basename="${file%.*}"
    xliff2po "$file" > "../../../gettext/${basename}.po"
done
