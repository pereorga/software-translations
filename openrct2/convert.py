import re


def escape_po(s):
    return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n')


def parse(path):
    result = {}
    with open(path, encoding='utf-8') as f:
        for line in f:
            line = line.rstrip('\n')
            if line.startswith('#') or not line.strip():
                continue
            m = re.match(r'^(\w+)\s*:(.*)', line)
            if m:
                result[m.group(1)] = m.group(2).strip()
    return result


en = parse('tmp/en.txt')
ca = parse('tmp/ca.txt')

lines_out = ['msgid ""', 'msgstr ""',
             '"Content-Type: text/plain; charset=UTF-8\\n"',
             '"Content-Transfer-Encoding: 8bit\\n"',
             '']

for key, ca_val in ca.items():
    en_val = en.get(key, '')
    if en_val and ca_val:
        lines_out += [f'msgctxt "{escape_po(key)}"',
                      f'msgid "{escape_po(en_val)}"',
                      f'msgstr "{escape_po(ca_val)}"',
                      '']

print('\n'.join(lines_out))
