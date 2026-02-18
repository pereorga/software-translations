import re


def escape_po(s):
    return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n')


content = open('tmp/strings.txt').read()

lines_out = ['msgid ""', 'msgstr ""',
             '"Content-Type: text/plain; charset=UTF-8\\n"',
             '"Content-Transfer-Encoding: 8bit\\n"',
             '']

current_key = None
current_en = None
current_ca = None

for line in content.split('\n'):
    line = line.rstrip()
    if line.startswith('[['):
        continue
    m = re.match(r'^\[([^\]]+)\]$', line)
    if m:
        if current_key and current_en and current_ca:
            lines_out += [f'msgctxt "{escape_po(current_key)}"',
                          f'msgid "{escape_po(current_en)}"',
                          f'msgstr "{escape_po(current_ca)}"',
                          '']
        current_key = m.group(1)
        current_en = None
        current_ca = None
        continue
    m = re.match(r'^([\w-]+)\s*=\s*(.+)$', line)
    if m:
        if m.group(1) == 'en':
            current_en = m.group(2)
        elif m.group(1) == 'ca':
            current_ca = m.group(2)

if current_key and current_en and current_ca:
    lines_out += [f'msgctxt "{escape_po(current_key)}"',
                  f'msgid "{escape_po(current_en)}"',
                  f'msgstr "{escape_po(current_ca)}"',
                  '']

print('\n'.join(lines_out))
