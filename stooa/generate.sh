#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

git clone --depth 1 "https://github.com/Stooa/Stooa.git" tmp/Stooa

files=($(cd tmp/Stooa/frontend/locales/ca/ && ls *.json))
for file in "${files[@]}"; do
    json2po --template="tmp/Stooa/frontend/locales/en/$file" "tmp/Stooa/frontend/locales/ca/$file" > "translations/$file.po"
done

curl https://raw.githubusercontent.com/Stooa/Stooa/main/backend/translations/messages.en.yaml > tmp/messages.en.yaml
curl https://raw.githubusercontent.com/Stooa/Stooa/main/backend/translations/messages.ca.yaml > tmp/messages.ca.yaml
yaml2po tmp/messages.ca.yaml --template=tmp/messages.en.yaml > translations/backend.po
