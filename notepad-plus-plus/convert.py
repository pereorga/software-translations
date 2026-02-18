import json
import xml.etree.ElementTree as ET


def parse(path):
    root = ET.parse(path).getroot()
    out = {}

    def walk(node, path_parts):
        tag = node.tag
        current_path = path_parts + [tag]

        if 'name' in node.attrib and tag != 'Native-Langue':
            key_parts = ['/'.join(current_path)]
            for attr in ('id', 'menuId', 'subMenuId', 'index'):
                if attr in node.attrib:
                    key_parts.append(f"{attr}={node.attrib[attr]}")

            base_key = '|'.join(key_parts)
            key = base_key
            suffix = 2
            while key in out:
                key = f"{base_key}#{suffix}"
                suffix += 1

            out[key] = node.attrib['name']

        for child in node:
            walk(child, current_path)

    walk(root, [])
    return out


with open('tmp/en.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/en.xml'), f, ensure_ascii=False, indent=2, sort_keys=True)

with open('tmp/ca.json', 'w', encoding='utf-8') as f:
    json.dump(parse('tmp/ca.xml'), f, ensure_ascii=False, indent=2, sort_keys=True)
