#!/bin/sh
cd "$(dirname "$0")"

curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/en-US/Resources.resw" > Resources_en.resx
curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/ca-ES/Resources.resw" > Resources.resx

curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/en-US/CEngineStrings.resw" > CEngineStrings_en.resx
curl "https://raw.githubusercontent.com/microsoft/calculator/main/src/Calculator/Resources/ca-ES/CEngineStrings.resw" > CEngineStrings.resx

resx2po -t Resources_en.resx Resources.resx Resources.po
resx2po -t CEngineStrings_en.resx CEngineStrings.resx CEngineStrings.po
