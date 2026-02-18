#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

curl --silent https://raw.githubusercontent.com/libretro/RetroArch/master/intl/msg_hash_us.h > tmp/en.h
curl --silent https://raw.githubusercontent.com/libretro/RetroArch/master/intl/msg_hash_ca.h > tmp/ca.h

python3 convert.py > translations/retroarch.po

python3 ../removeIdenticalMsgidMsgstr.py translations/retroarch.po
