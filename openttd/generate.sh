#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

curl --silent https://raw.githubusercontent.com/OpenTTD/OpenTTD/master/src/lang/english.txt > tmp/en.txt
curl --silent https://raw.githubusercontent.com/OpenTTD/OpenTTD/master/src/lang/catalan.txt > tmp/ca.txt

python3 convert.py > translations/openttd.po

python3 ../removeIdenticalMsgidMsgstr.py translations/openttd.po
