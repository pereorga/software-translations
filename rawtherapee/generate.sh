#!/bin/sh
cd "$(dirname "$0")"

curl "https://raw.githubusercontent.com/Beep6581/RawTherapee/dev/rtdata/languages/default" | grep -v '^#' | grep . | sed 's/;/|/' > en.csv
curl "https://raw.githubusercontent.com/Beep6581/RawTherapee/dev/rtdata/languages/Catala" | grep -v '^#' | grep -v '^!' | grep . | sed 's/;/|/' > ca.csv
csvformat --no-header-row -d"|" -u 3 --out-quoting 1 en.csv > en2.csv
csvformat --no-header-row -d"|" -u 3 --out-quoting 1 ca.csv > ca2.csv
csvjoin -c 1 en2.csv ca2.csv > rawtherapee.csv
csv2po rawtherapee.csv ca.po
