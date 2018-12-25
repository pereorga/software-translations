const fs = require('fs');
const mv = require('mv');


function deleteDuplicated(version) {

  dir = 'po/' + version + '/projects';
  var files = fs.readdirSync(dir);
  for (var f in files) {
    if (files[f] !== '..') {
      var currentFile = dir + '/' + files[f];
      var stats = fs.statSync(currentFile);
      if (stats.isDirectory()) {
        var po_files = fs.readdirSync(currentFile);
        var biggest_size = 0;
        var biggest_size_filepath = '';
        for (var po in po_files) {
          var currentPoFile = currentFile + '/' + po_files[po];
          var fileSizeInBytes = fs.statSync(currentPoFile).size;
          if (fileSizeInBytes > biggest_size) {
            biggest_size = fileSizeInBytes;
            biggest_size_filepath = currentPoFile;
          }
        }

        // Keep biggest file.
        for (var po in po_files) {
          var currentPoFile = currentFile + '/' + po_files[po];
          if (currentPoFile !== biggest_size_filepath) {
            fs.unlink(currentPoFile);
          }
        }

        // Move it to parent directory.
        mv(biggest_size_filepath, 'po/' + version + '/' + biggest_size_filepath.split("/").pop(), function(err) {
          // done.
        });
      }
    }
  }
}


if (typeof process.argv[2] === 'undefined' || (
    process.argv[2] !== '6.x'
    && process.argv[2] !== '7.x'
    && process.argv[2] !== '8.x'
  )) {
  console.error('Usage: node delete_duplicated.js 7.x')
}
else {

  var version = process.argv[2];

  deleteDuplicated(version);
}