#!/usr/bin/env bash

cd "$(dirname "$0")"

curl https://raw.githubusercontent.com/FreeTubeApp/FreeTube/development/static/locales/en-US.yaml > en.yaml
curl https://raw.githubusercontent.com/FreeTubeApp/FreeTube/development/static/locales/ca.yaml > ca.yaml
yaml2po ca.yaml --template=en.yaml > ca.po
