#!/bin/sh
curl "https://docs.google.com/spreadsheets/d/1FoYdyEraEQuWofzbYCDPKN7EdKgS_2ZrsDrOA8scgwQ/export?exportFormat=csv" > draw1.csv
csvcut draw1.csv -c 1,2,8 > draw2.csv
csv2po draw2.csv ca.po
rm -f draw1.csv draw2.csv
