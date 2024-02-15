#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/
mkdir tmp

curl "https://raw.githubusercontent.com/bitwarden/mobile/main/src/Core/Resources/Localization/AppResources.ca.resx" > tmp/AppResources.ca.resx
curl "https://raw.githubusercontent.com/bitwarden/mobile/main/src/Core/Resources/Localization/AppResources.en-IN.resx" > tmp/AppResources.en.resx

resx2po -t tmp/AppResources.en.resx tmp/AppResources.ca.resx AppResources.po
