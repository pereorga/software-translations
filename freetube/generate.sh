#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/
mkdir tmp

curl https://raw.githubusercontent.com/FreeTubeApp/FreeTube/development/static/locales/en-US.yaml > tmp/en.yaml
curl https://raw.githubusercontent.com/FreeTubeApp/FreeTube/development/static/locales/ca.yaml > tmp/ca.yaml
yaml2po tmp/ca.yaml --template=tmp/en.yaml > ca.po
