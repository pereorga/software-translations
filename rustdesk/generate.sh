#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir -p tmp translations

curl --silent https://raw.githubusercontent.com/rustdesk/rustdesk/master/src/lang/en.rs > tmp/en.rs
curl --silent https://raw.githubusercontent.com/rustdesk/rustdesk/master/src/lang/ca.rs > tmp/ca.rs

python3 convert.py

json2po --template=tmp/en.json tmp/ca.json > translations/rustdesk.po
python3 ../removeIdenticalMsgidMsgstr.py translations/rustdesk.po
