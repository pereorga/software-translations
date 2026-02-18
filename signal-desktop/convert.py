import json


def escape_po(s):
    return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n')


en = json.load(open('tmp/en.json', encoding='utf-8'))
ca = json.load(open('tmp/ca.json', encoding='utf-8'))

lines_out = ['msgid ""', 'msgstr ""',
             '"Content-Type: text/plain; charset=UTF-8\\n"',
             '"Content-Transfer-Encoding: 8bit\\n"',
             '']

for key, ca_entry in ca.items():
    if not isinstance(ca_entry, dict):
        continue
    ca_val = ca_entry.get('messageformat', '')
    en_entry = en.get(key, {})
    en_val = en_entry.get('messageformat', '') if isinstance(en_entry, dict) else ''
    if en_val and ca_val:
        lines_out += [f'msgctxt "{escape_po(key)}"',
                      f'msgid "{escape_po(en_val)}"',
                      f'msgstr "{escape_po(ca_val)}"',
                      '']

print('\n'.join(lines_out))
