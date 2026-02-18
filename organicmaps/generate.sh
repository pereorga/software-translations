#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

curl --silent https://raw.githubusercontent.com/organicmaps/organicmaps/master/data/strings/strings.txt > tmp/strings.txt

python3 convert.py > translations/strings.po

python3 ../removeIdenticalMsgidMsgstr.py translations/strings.po
