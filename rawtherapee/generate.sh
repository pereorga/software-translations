#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/
mkdir tmp

curl "https://raw.githubusercontent.com/Beep6581/RawTherapee/dev/rtdata/languages/default" | grep -v '^#' | grep . | sed 's/;/|/' > tmp/en.csv
curl "https://raw.githubusercontent.com/Beep6581/RawTherapee/dev/rtdata/languages/Catala" | grep -v '^#' | grep -v '^!' | grep . | sed 's/;/|/' > tmp/ca.csv
csvformat --no-header-row -d"|" -u 3 --out-quoting 1 tmp/en.csv > tmp/en2.csv
csvformat --no-header-row -d"|" -u 3 --out-quoting 1 tmp/ca.csv > tmp/ca2.csv
csvjoin -c 1 tmp/en2.csv tmp/ca2.csv > tmp/rawtherapee.csv
csv2po tmp/rawtherapee.csv ca.po
