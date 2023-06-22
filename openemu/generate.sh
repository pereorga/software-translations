#!/bin/sh
cd "$(dirname "$0")"

curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/ca.lproj/OEControls.strings" | grep -v '// TODO' | grep -F -v '/*' | grep . > files/OEControls.strings
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/ca.lproj/MainMenu.strings" | grep -v '// TODO' | grep -F -v '/*' | grep . > files/MainMenu.strings
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/ca.lproj/ControlLabels.strings" | grep -F -v '// TODO' | grep -F -v '/*' | grep . > files/ControlLabels.strings
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/ca.lproj/Localizable.strings" | grep -v '// TODO' | grep -F -v '/*' | grep . > files/Localizable.strings
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/ca.lproj/Debug.strings" | grep -v '// TODO' | grep -F -v '/*' | grep . > files/Debug.strings

curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/en.lproj/OEControls.strings" > files/OEControls.template
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/en.lproj/MainMenu.strings" > files/MainMenu.template
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/en.lproj/ControlLabels.strings" > files/ControlLabels.template
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/en.lproj/Localizable.strings" > files/Localizable.template 
curl "https://raw.githubusercontent.com/OpenEmu/OpenEmu/master/OpenEmu/en.lproj/Debug.strings" > files/Debug.template 

prop2po --personality=strings --encoding=utf-8 -i files/OEControls.strings -o po/OEControls.po --template=files/OEControls.template
prop2po --personality=strings --encoding=utf-8 -i files/MainMenu.strings -o po/MainMenu.po --template=files/MainMenu.template
prop2po --personality=strings --encoding=utf-8 -i files/ControlLabels.strings -o po/ControlLabels.po --template=files/ControlLabels.template
prop2po --personality=strings --encoding=utf-8 -i files/Localizable.strings -o po/Localizable.po --template=files/Localizable.template
prop2po --personality=strings --encoding=utf-8 -i files/Debug.strings -o po/Debug.po --template=files/Debug.template
