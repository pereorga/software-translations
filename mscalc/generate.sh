#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/
mkdir tmp

curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/en-US/Resources.resw" > tmp/Resources_en.resx
curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/ca-ES/Resources.resw" > tmp/Resources.resx

curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/en-US/CEngineStrings.resw" > tmp/CEngineStrings_en.resx
curl "https://raw.githubusercontent.com/microsoft/calculator/main/src/Calculator/Resources/ca-ES/CEngineStrings.resw" > tmp/CEngineStrings.resx

resx2po -t tmp/Resources_en.resx tmp/Resources.resx Resources.po
resx2po -t tmp/CEngineStrings_en.resx tmp/CEngineStrings.resx CEngineStrings.po
