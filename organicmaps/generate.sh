#!/bin/bash

cd "$(dirname "$0")"

rm -f ca.po
curl https://raw.githubusercontent.com/organicmaps/organicmaps/master/data/strings/strings.txt \
    | grep -v 'ref = ' > strings.txt
twine generate-localization-file --format=gettext strings.txt ca.po
rm strings.txt
