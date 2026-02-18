#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

curl --silent https://raw.githubusercontent.com/signalapp/Signal-Desktop/main/_locales/en/messages.json > tmp/en.json
curl --silent https://raw.githubusercontent.com/signalapp/Signal-Desktop/main/_locales/ca/messages.json > tmp/ca.json

python3 convert.py > translations/signal-desktop.po

python3 ../removeIdenticalMsgidMsgstr.py translations/signal-desktop.po
