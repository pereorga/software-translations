#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir -p tmp translations

curl --silent https://raw.githubusercontent.com/greenshot/greenshot/master/Greenshot/Languages/language-en-US.xml > tmp/en.xml
curl --silent https://raw.githubusercontent.com/greenshot/greenshot/master/Greenshot/Languages/language-ca-CA.xml > tmp/ca.xml

python3 convert.py

json2po --template=tmp/en.json tmp/ca.json > translations/greenshot.po
python3 ../removeIdenticalMsgidMsgstr.py translations/greenshot.po
