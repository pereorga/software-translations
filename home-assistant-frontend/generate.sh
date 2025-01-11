#!/usr/bin/env bash

# Navigate to the script's directory
cd "$(dirname "$0")"

# Clean up and create necessary directories
rm -rf tmp/ translations/
mkdir -p tmp translations

# Use pip to download the latest home-assistant-frontend package
pip download --no-deps --dest tmp home-assistant-frontend

# Find the downloaded .whl file
whl_file=$(find tmp -name "*.whl" | head -n 1)

# Check if the .whl file was downloaded
if [ -z "$whl_file" ]; then
    echo "Failed to download the .whl file."
    exit 1
fi

# Unzip the .whl file
unzip -o -d tmp/ "$whl_file"

# Copy translation files for specified languages
for lang in ca en; do
    find tmp/hass_frontend/static/translations -name "*$lang-*.json" | while read -r src_file; do
        dir_name=$(basename "$(dirname "$src_file")")
        mkdir -p translations/"$dir_name"
        cp "$src_file" translations/"$dir_name"/"$lang".json
    done
done
