#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

curl --silent https://raw.githubusercontent.com/OpenRCT2/OpenRCT2/develop/data/language/en-GB.txt > tmp/en.txt
curl --silent https://raw.githubusercontent.com/OpenRCT2/OpenRCT2/develop/data/language/ca-ES.txt > tmp/ca.txt

python3 convert.py > translations/openrct2.po

python3 ../removeIdenticalMsgidMsgstr.py translations/openrct2.po
