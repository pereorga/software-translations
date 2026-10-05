#!/usr/bin/env bash

cd "$(dirname "$0")"

REPO="sumatrapdfreader/sumatrapdf"
FILE="translations/translations.txt"
FALLBACK_REF="3.6.1rel"

# Upstream removed translations/ from master (2026-07-29, translations now live
# in apptranslator.org), so detect the newest release tag that still ships
# translations.txt instead of hardcoding a ref.
REF=""
CANDIDATES=$(curl -fsSL --max-time 30 "https://api.github.com/repos/${REPO}/releases?per_page=100" 2>/dev/null | grep -o '"tag_name": *"[^"]*"' | sed 's/.*": *"//;s/"$//')
CANDIDATES="${CANDIDATES} ${FALLBACK_REF}"
TMP_FILE=$(mktemp)
for tag in $CANDIDATES; do
    if curl -fsSL --max-time 60 "https://raw.githubusercontent.com/${REPO}/${tag}/${FILE}" -o "$TMP_FILE" 2>/dev/null; then
        REF="$tag"
        break
    fi
done

if [[ -z $REF ]]; then
    echo "ERROR: no s'ha trobat cap versió de ${REPO} amb ${FILE}" >&2
    rm -f "$TMP_FILE"
    exit 1
fi
echo "Fent servir la versió ${REF} de ${REPO}"

# Generate PO header
cat << EOF > sumatra.po
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\n"
EOF

# Extract English and Catalan strings and convert to PO format
grep -E '^(\:|ca\:)' "$TMP_FILE" | \
sed -e 's/^:/msgid "/' \
    -e 's/^ca:/msgstr "/' \
    -e 's/$/"/' >> sumatra.po
rm -f "$TMP_FILE"

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
