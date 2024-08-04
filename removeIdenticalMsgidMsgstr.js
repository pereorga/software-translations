const fs = require('fs');
const path = require('path');

// Check if a filename was provided as an argument
if (process.argv.length < 3) {
  console.error('Please provide the filename as an argument.');
  process.exit(1);
}

// Get the filename from the command line arguments
const inputFile = process.argv[2];

// Check if the file exists
if (!fs.existsSync(inputFile)) {
  console.error(`File not found: ${inputFile}`);
  process.exit(1);
}

// Read the input file
fs.readFile(inputFile, 'utf8', (err, data) => {
  if (err) {
    console.error(`Error reading file: ${err}`);
    return;
  }

  // Split the file content into entries
  const entries = data.split(/\n\n/);

  // Function to extract multiline msgid or msgstr
  function extractMultilineValue(entry, key) {
    const regex = new RegExp(`^${key}.*`, 'mg');
    const matches = entry.match(regex);
    if (!matches) return '';

    // Combine lines and remove quotes
    const value = matches.map(line => line.replace(new RegExp(`^${key}`, 'm'), '').trim().replace(/^"(.*)"$/, '$1')).join('');
    return value;
  }

  // Filter out entries where msgid and msgstr are identical
  const filteredEntries = entries.filter(entry => {
    const msgid = extractMultilineValue(entry, 'msgid');
    const msgstr = extractMultilineValue(entry, 'msgstr');

    if (msgid && msgstr) {
      return msgid !== msgstr;
    }
    return true;
  });

  // Join the filtered entries back into a single string
  const outputData = filteredEntries.join('\n\n');

  // Write the filtered content back to the original file
  fs.writeFile(inputFile, outputData, 'utf8', (err) => {
    if (err) {
      console.error(`Error writing file: ${err}`);
    } else {
      console.log(`Filtered content has been written to ${inputFile}`);
    }
  });
});
