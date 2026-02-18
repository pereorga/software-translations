#!/usr/bin/env python3
"""Parse eMule Windows RC STRINGTABLE files and output a PO file."""

import re

EN_FILE = "tmp/emule.rc"
CA_FILE = "tmp/ca_ES.rc"


def parse_rc(path):
    with open(path, "rb") as f:
        content = f.read().decode("cp1252", errors="replace")

    entries = {}
    in_stringtable = False
    in_block = False
    pending_key = None

    for line in content.splitlines():
        stripped = line.strip()

        if re.match(r'^STRINGTABLE\b', stripped):
            in_stringtable = True
            continue
        if in_stringtable and stripped == "BEGIN":
            in_block = True
            continue
        if in_block and stripped == "END":
            in_block = False
            in_stringtable = False
            pending_key = None
            continue
        if not in_block:
            in_stringtable = False
            continue

        # Value continuation line (key was on previous line)
        if pending_key is not None:
            m = re.match(r'^"(.*)"', stripped)
            if m:
                entries[pending_key] = m.group(1)
            pending_key = None
            continue

        # KEY "value"  or  KEY\n"value"
        m = re.match(r'^(\w+)\s+"(.*)"', stripped)
        if m:
            entries[m.group(1)] = m.group(2)
            continue

        m = re.match(r'^(\w+)\s*$', stripped)
        if m:
            pending_key = m.group(1)

    return entries


def unescape_rc(s):
    return s.replace('""', '"').replace("\\n", "\n").replace("\\t", "\t")


def escape_po(s):
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n").replace("\t", "\\t")


def main():
    en = parse_rc(EN_FILE)
    ca = parse_rc(CA_FILE)

    print('msgid ""')
    print('msgstr ""')
    print('"Content-Type: text/plain; charset=UTF-8\\n"')
    print('"Content-Transfer-Encoding: 8bit\\n"')
    print()

    for key, en_val in sorted(en.items()):
        ca_val = ca.get(key, "")
        en_text = unescape_rc(en_val)
        ca_text = unescape_rc(ca_val)
        if not en_text:
            continue
        print(f"#: {key}")
        print(f'msgctxt "{key}"')
        print(f'msgid "{escape_po(en_text)}"')
        print(f'msgstr "{escape_po(ca_text)}"')
        print()


if __name__ == "__main__":
    main()
