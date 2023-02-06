#!/bin/bash

cd "$(dirname "$0")"

# Generate PO header
echo "msgid \"\"" > sumatra.po
echo "msgstr \"\"" >> sumatra.po
echo "\"Content-Type: text/plain; charset=UTF-8\n\""  >> sumatra.po
echo ""  >> sumatra.po

curl "https://raw.githubusercontent.com/sumatrapdfreader/sumatrapdf/master/src/docs/translations.txt" > translations.txt

# Extract English and Catalan strings
grep -E '^(\:|ca\:)' translations.txt > translations_ca.txt

# Convert text file to PO
sed 's/^:/msgid "/' translations_ca.txt > translations_po_step1.txt
sed 's/^ca:/msgstr "/' translations_po_step1.txt > translations_po_step2.txt
sed 's/$/"/' translations_po_step2.txt >> sumatra.po

if [[ -z $(msgattrib sumatra.po 2> /dev/null) ]]; then
    msgattrib sumatra.po
    echo "ERROR: probablement falten cadenes per traduir"
else
    echo "OK"
fi

rm -f *step*.txt
