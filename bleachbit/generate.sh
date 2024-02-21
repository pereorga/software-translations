#!/usr/bin/env bash

cd "$(dirname "$0")"

curl https://raw.githubusercontent.com/bleachbit/bleachbit/master/po/ca.po | grep -v ' \.\./' > ca.po
