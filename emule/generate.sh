#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

curl https://raw.githubusercontent.com/irwir/eMule/master/emule.rc > tmp/emule.rc
curl https://raw.githubusercontent.com/irwir/eMule/master/lang/ca_ES.rc > tmp/ca_ES.rc

python3 convert.py > translations/emule.po

python3 ../removeIdenticalMsgidMsgstr.py translations/emule.po
