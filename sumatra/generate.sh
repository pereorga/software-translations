#!/usr/bin/env bash

cd "$(dirname "$0")"

# Generate PO header
cat << EOF > sumatra.po
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\n"
EOF

# Download translations.txt from Sumatra repository, extract English and Catalan strings, and convert to PO format
grep -E '^(\:|ca\:)' <(curl -s "https://raw.githubusercontent.com/sumatrapdfreader/sumatrapdf/master/src/docs/translations.txt") | \
sed -e 's/^:/msgid "/' \
    -e 's/^ca:/msgstr "/' \
    -e 's/$/"/' >> sumatra.po

# Check PO syntax
if [[ -z $(msgattrib sumatra.po 2> /dev/null) ]]; then
    msgattrib sumatra.po
    echo "ERROR: probablement falten cadenes per traduir"
    exit 1
else
    echo "OK"
fi
