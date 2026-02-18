import json
import xml.etree.ElementTree as ET


def parse(path):
    root = ET.parse(path).getroot()
    results = {}
    for resource in root.findall('.//resource[@name]'):
        key = resource.attrib['name']
        text = ''.join(resource.itertext()).strip()
        results[key] = text
    return results


with open('tmp/en.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/en.xml'), f, ensure_ascii=False, indent=2, sort_keys=True)

with open('tmp/ca.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/ca.xml'), f, ensure_ascii=False, indent=2, sort_keys=True)
