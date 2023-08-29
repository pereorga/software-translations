#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf gettext
mkdir gettext
rm -rf haiku
git clone --depth=1 https://github.com/haiku/haiku.git

# Find and convert .catkeys files to .csv
find './haiku/data/catalogs' -name "*ca.catkeys" -print0 | while IFS= read -r -d '' file; do
    newFile="${file%.catkeys}.csv"
    csvcut -t -c 2,1,4 -K 1 "$file" | csvformat -U 1 > "$newFile"
done

# Convert .csv files to Gettext .po and place them in the gettext directory
find './haiku/data/catalogs' -name "*.csv" -print0 | while IFS= read -r -d '' file; do
    newFile="${file##./haiku/data/catalogs/}"
    newFile="${newFile//\//_}"
    newFile="${newFile//_ca.csv/.po}"
    csv2po "$file" "gettext/$newFile"
done
