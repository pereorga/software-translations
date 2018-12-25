#!/bin/sh

cd "$(dirname "$0")"

rm -rf po

node generate_urls.js 7.x
node generate_urls.js 8.x

aria2c -i urls_7.x.txt
aria2c -i urls_8.x.txt

node delete_duplicated.js 7.x
node delete_duplicated.js 8.x

rm -rf 'po/7.x/projects/'
rm -rf 'po/8.x/projects/'


# Remove problematic files.
for filename in po/7.x/*.po; do
  msgattrib $filename > /dev/null
  rc=$?
  if [ $rc != 0 ]
  then
    rm $filename
  fi
done
for filename in po/8.x/*.po; do
  msgattrib $filename > /dev/null
  rc=$?
  if [ $rc != 0 ]
  then
    rm $filename
  fi
done

msgcat --no-wrap --use-first --unique po/7.x/*.po > 7.x.po
msgcat --no-wrap --use-first --unique po/8.x/*.po 7.x.po > drupal-contrib.po
rm 7.x.po
