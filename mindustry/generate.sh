#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/
mkdir tmp

curl https://raw.githubusercontent.com/Anuken/Mindustry/master/core/assets/bundles/bundle.properties > tmp/en.properties
curl https://raw.githubusercontent.com/Anuken/Mindustry/master/core/assets/bundles/bundle_ca.properties > tmp/ca.properties

prop2po --encoding=utf-8 -t tmp/en.properties tmp/ca.properties > ca.po
