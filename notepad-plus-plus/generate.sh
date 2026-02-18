#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir -p tmp translations

curl --silent https://raw.githubusercontent.com/notepad-plus-plus/notepad-plus-plus/master/PowerEditor/installer/nativeLang/english.xml > tmp/en.xml
curl --silent https://raw.githubusercontent.com/notepad-plus-plus/notepad-plus-plus/master/PowerEditor/installer/nativeLang/catalan.xml > tmp/ca.xml

python3 convert.py

json2po --template=tmp/en.json tmp/ca.json > translations/notepad-plus-plus.po
python3 ../removeIdenticalMsgidMsgstr.py translations/notepad-plus-plus.po
