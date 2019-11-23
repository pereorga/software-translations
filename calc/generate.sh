#!/bin/sh
curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/en-US/Resources.resw" > en.resx
curl "https://raw.githubusercontent.com/microsoft/calculator/master/src/Calculator/Resources/ca-ES/Resources.resw" > ca.resx
resx2po -t en.resx ca.resx ca.po
