#!/usr/bin/env bash

cd "$(dirname "$0")"

curl --silent https://raw.githubusercontent.com/bitcoin/bitcoin/master/src/qt/locale/bitcoin_ca.ts | sed 's/ type="unfinished"//g' > bitcoin_ca.ts
