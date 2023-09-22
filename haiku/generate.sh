#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

git clone --depth=1 https://github.com/haiku/haiku.git tmp/haiku

# Find and convert .catkeys files to .csv
find 'tmp/haiku/data/catalogs' -name "*ca.catkeys" -print0 | while IFS= read -r -d '' file; do
    newFile="${file%.catkeys}.csv"
    csvcut -t -c 2,1,4 -K 1 "$file" | csvformat -U 1 > "$newFile"
done

# Convert .csv files to Gettext .po and place them in the gettext directory
find 'tmp/haiku/data/catalogs' -name "*.csv" -print0 | while IFS= read -r -d '' file; do
    newFile="${file##./haiku/data/catalogs/}"
    newFile="${newFile//\//_}"
    newFile="${newFile//tmp_haiku_data_catalogs/haiku}"
    newFile="${newFile//_ca.csv/.po}"
    csv2po "$file" "translations/$newFile"
done
