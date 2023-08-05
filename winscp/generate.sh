#!/bin/sh
cd "$(dirname "$0")"

curl "https://winscp.net/translations/EN.ini" | dos2unix > EN.ini
curl "https://winscp.net/translations/current/CA.ini" | dos2unix > CA.ini
