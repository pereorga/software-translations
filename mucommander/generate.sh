#!/bin/sh
cd "$(dirname "$0")"

curl "https://raw.githubusercontent.com/mucommander/mucommander/master/mucommander-translator/src/main/resources/dictionary.properties" > dictionary.properties
curl "https://raw.githubusercontent.com/mucommander/mucommander/master/mucommander-translator/src/main/resources/dictionary_ca.properties" > dictionary_ca.properties
prop2po -i dictionary_ca.properties -o dictionary_ca.po --template=dictionary.properties
