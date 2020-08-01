#!/bin/sh

cd "$(dirname "$0")"

rm -f gettext/*
rm -rf haiku
git clone --depth=1 https://github.com/haiku/haiku.git
node generate.js
