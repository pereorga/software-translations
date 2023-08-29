#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf "Stooa/" "po/"
mkdir po
git clone --depth 1 "https://github.com/Stooa/Stooa.git"

files=($(cd Stooa/frontend/locales/ca/ && ls *.json))
for file in "${files[@]}"; do
    json2po --template="Stooa/frontend/locales/en/$file" "Stooa/frontend/locales/ca/$file" > "po/$file.po"
done

curl https://raw.githubusercontent.com/Stooa/Stooa/main/backend/translations/messages.en.yaml > messages.en.yaml
curl https://raw.githubusercontent.com/Stooa/Stooa/main/backend/translations/messages.ca.yaml > messages.ca.yaml
yaml2po messages.ca.yaml --template=messages.en.yaml > po/backend.po
