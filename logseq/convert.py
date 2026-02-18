import ast
import json
import re

PAIR_RE = re.compile(r'^\s*:([^\s]+)\s+"((?:\\.|[^"\\])*)"')


def decode(value):
    try:
        return ast.literal_eval(f'"{value}"')
    except Exception:
        return value


def parse(path):
    results = {}
    with open(path, encoding='utf-8') as f:
        for line in f:
            match = PAIR_RE.match(line)
            if not match:
                continue
            key = match.group(1)
            val = decode(match.group(2))
            results[key] = val
    return results


with open('tmp/en.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/en.edn'), f, ensure_ascii=False, indent=2, sort_keys=True)

with open('tmp/ca.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/ca.edn'), f, ensure_ascii=False, indent=2, sort_keys=True)
