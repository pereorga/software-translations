var lineReader = require('readline').createInterface({
  input: require('fs').createReadStream('CA.ini')
});

var source = '';
lineReader.on('line', function (line) {

  var new_line = '';

  if (line.startsWith('; "') && line.endsWith('"')) {

    // Get source string.
    source = line.substring('; "'.length, line.lastIndexOf('"'));
  }
  else if (source && line.indexOf('="') !== -1 && line.endsWith('"')) {

    // Build the new line.
    new_line = line.substring(0, line.indexOf('="')) + '="' + source + '"';
    source = '';
  }
  else {

    // Skip source string (it does not have translation)
    source = '';
  }


  // Print the new file.
  if (new_line) {

    // If we have built a new line, print it.
    console.log(new_line);
  }
  else {

    // Otherwise, print the same origin line.
    console.log(line);
  }
});