#!/usr/bin/env bash

cd "$(dirname "$0")"


# Generate PO header
cat << EOF > sumatra.po
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\n"
EOF

# Download translations.txt from Sumatra repository, extract English and Catalan strings, and convert to PO format
grep -E '^(\:|ca\:)' <(curl -s "https://raw.githubusercontent.com/sumatrapdfreader/sumatrapdf/master/translations/translations.txt") | \
sed -e 's/^:/msgid "/' \
    -e 's/^ca:/msgstr "/' \
    -e 's/$/"/' >> sumatra.po

# Check PO syntax
if [[ -z $(msgattrib sumatra.po 2> /dev/null) ]]; then
    echo "Avís: probablement falten cadenes per traduir, intentant arreglar-ho..."
    python3 process_po.py
    if [[ -z $(msgattrib sumatra.po 2> /dev/null) ]]; then
        msgattrib sumatra.po
        echo "ERROR: no s'ha pogut arreglar"
        exit 1
    fi
fi
