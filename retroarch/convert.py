import ast
import re


def unescape(s):
    try:
        return ast.literal_eval(f'"{s}"')
    except Exception:
        return s


def escape_po(s):
    return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n')


def parse(path):
    result = {}
    content = open(path, encoding='utf-8').read()
    for m in re.finditer(r'MSG_HASH\(\s*(\w+),\s*"((?:[^"\\]|\\.)*)"\s*\)', content, re.DOTALL):
        result[m.group(1)] = unescape(m.group(2))
    return result


en = parse('tmp/en.h')
ca = parse('tmp/ca.h')

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
