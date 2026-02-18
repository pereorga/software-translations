#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

# Helper: remove first 2 lines (portable: works on both macOS BSD and GNU/Linux)
strip2() { tail -n +3 "$1" > "$1.tmp" && mv "$1.tmp" "$1"; }

# web
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/locales/en-US.yml > tmp/web-en.yml
strip2 tmp/web-en.yml
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/locales/ca-ES.yml > tmp/web-ca.yml
strip2 tmp/web-ca.yml

yaml2po tmp/web-ca.yml --template=tmp/web-en.yml > translations/tmdb-web.po

# countries
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/countries/en-US.yml > tmp/countries-en.yml
strip2 tmp/countries-en.yml

curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/countries/ca-ES.yml > tmp/countries-ca.yml
strip2 tmp/countries-ca.yml

yaml2po tmp/countries-ca.yml --template=tmp/countries-en.yml > translations/tmdb-countries.po

# languages
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/languages/en-US.yml > tmp/languages-en.yml
strip2 tmp/languages-en.yml

curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/languages/ca-ES.yml > tmp/languages-ca.yml
strip2 tmp/languages-ca.yml

yaml2po tmp/languages-ca.yml --template=tmp/languages-en.yml > translations/tmdb-languages.po
