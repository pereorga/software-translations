#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/
mkdir tmp

curl -L "https://docs.google.com/spreadsheets/d/1FoYdyEraEQuWofzbYCDPKN7EdKgS_2ZrsDrOA8scgwQ/export?format=csv&gid=0" > tmp/draw1.csv
csvcut tmp/draw1.csv -c 1,2,7 --skip-lines 2 > tmp/draw2.csv
csv2po tmp/draw2.csv ca.po
