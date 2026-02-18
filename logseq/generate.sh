#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir -p tmp translations

curl --silent https://raw.githubusercontent.com/logseq/logseq/master/src/resources/dicts/en.edn > tmp/en.edn
curl --silent https://raw.githubusercontent.com/logseq/logseq/master/src/resources/dicts/ca.edn > tmp/ca.edn

python3 convert.py

json2po --template=tmp/en.json tmp/ca.json > translations/logseq.po
python3 ../removeIdenticalMsgidMsgstr.py translations/logseq.po
