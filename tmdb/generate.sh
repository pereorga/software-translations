#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf tmp/ translations/
mkdir tmp translations

# web
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/locales/en-US.yml > tmp/web-en.yml
sed -i '1d' tmp/web-en.yml
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/locales/ca.yml > tmp/web-ca.yml
sed -i '1d' tmp/web-ca.yml

yaml2po tmp/web-ca.yml --template=tmp/web-en.yml > translations/tmdb-web.po

# countries
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/countries/en-US.yml > tmp/countries-en.yml
sed -i '1,2d' tmp/countries-en.yml

curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/countries/ca-ES.yml > tmp/countries-ca.yml
sed -i '1,2d' tmp/countries-ca.yml

yaml2po tmp/countries-ca.yml --template=tmp/countries-en.yml > translations/tmdb-countries.po

# languages
curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/languages/en-US.yml > tmp/languages-en.yml
sed -i '1,2d' tmp/languages-en.yml

curl https://raw.githubusercontent.com/travisbell/tmdb-web-translations/main/languages/ca-ES.yml > tmp/languages-ca.yml
sed -i '1,2d' tmp/languages-ca.yml

yaml2po tmp/languages-ca.yml --template=tmp/languages-en.yml > translations/tmdb-languages.po


