#!/usr/bin/env bash

cd "$(dirname "$0")"

rm -rf keycloak/ translations/
mkdir translations/

git clone --depth=1 https://github.com/keycloak/keycloak

for en_file in $(find keycloak/themes/src/main/resources/theme/base -type f -name "messages_en.properties"); do
    ca_file="${en_file/resources/resources-community}"
    ca_file="${ca_file/_en.properties/_ca.properties}"

    if [ -f "$ca_file" ]; then
        po_file="$(basename "$(dirname "$(dirname "$en_file")")")"
        prop2po --encoding utf-8 --template "$en_file" "$ca_file" "translations/$po_file.po"
    fi
done

prop2po --encoding utf-8 --template \
    keycloak/themes/src/main/resources/theme/keycloak.v2/account/messages/messages_en.properties \
    keycloak/themes/src/main/resources-community/theme/keycloak.v2/account/messages/messages_ca.properties \
    translations/account_v2.po
