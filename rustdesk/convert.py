import ast
import json
import re

PAIR_RE = re.compile(r'^\s*\("((?:\\.|[^"\\])*)",\s*"((?:\\.|[^"\\])*)"\),?\s*$')


def decode(value):
    try:
        return ast.literal_eval(f'"{value}"')
    except Exception:
        return value


def parse(path, fallback_key_as_value=False):
    results = {}
    with open(path, encoding='utf-8') as f:
        for line in f:
            match = PAIR_RE.match(line)
            if not match:
                continue
            key = decode(match.group(1))
            val = decode(match.group(2))
            results[key] = val if val or not fallback_key_as_value else key
    return results


with open('tmp/en.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/en.rs', fallback_key_as_value=True), f, ensure_ascii=False, indent=2, sort_keys=True)

with open('tmp/ca.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/ca.rs'), f, ensure_ascii=False, indent=2, sort_keys=True)
