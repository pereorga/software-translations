#!/usr/bin/env python3
import re
import sys

if len(sys.argv) < 2:
    print('Please provide the filename as an argument.', file=sys.stderr)
    sys.exit(1)

input_file = sys.argv[1]

try:
    data = open(input_file, encoding='utf-8').read()
except FileNotFoundError:
    print(f'File not found: {input_file}', file=sys.stderr)
    sys.exit(1)


def extract_value(entry, key):
    lines = entry.split('\n')
    for i, line in enumerate(lines):
        if line.startswith(key):
            value = ''
            for continuation in lines[i + 1:]:
                continuation = continuation.strip()
                if continuation.startswith('"') and continuation.endswith('"'):
                    value += continuation[1:-1]
                else:
                    break
            return value or re.sub(r'^"(.*)"$', r'\1', line[len(key):].strip())
    return ''


entries = data.split('\n\n')
filtered = [e for e in entries if extract_value(e, 'msgid') != extract_value(e, 'msgstr')]

with open(input_file, 'w', encoding='utf-8') as f:
    f.write('\n\n'.join(filtered))

print(f'Filtered content has been written to {input_file}')
