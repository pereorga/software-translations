const language_to_convert   = 'ca';

const catalogs_path         = './haiku/data/catalogs';

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};

var fs = require('fs');
var execFile = require('child_process').execFile;
var child_process = require('child_process');

var walkAndFindFiles = function(dir, mustEndWith, done) {
  var results = [];
  fs.readdir(dir, function(err, list) {
    if (err) return done(err);
    var i = 0;
    (function next() {
      var file = list[i++];
      if (!file) return done(null, results);
      file = dir + '/' + file;
      fs.stat(file, function(err, stat) {
        if (stat && stat.isDirectory()) {
          walkAndFindFiles(file, mustEndWith, function(err, res) {
            results = results.concat(res);
            next();
          });
        } else {
          if (file.endsWith(mustEndWith)) {
            results.push(file);
          }
          next();
        }
      });
    })();
  });
};


// Convert catkeys files to CSV.
walkAndFindFiles(catalogs_path, language_to_convert + '.catkeys', function(err, results) {
  if (err) throw err;
  for (var i = 0; i < results.length; i++) {

    var filename = results[i];
    var newFile  = filename.replace('.catkeys', '.csv');
    var command  = 'csvcut -t -c 2,1,4 -K 1 ' + filename + ' | csvformat -U 1 > ' + newFile;
    child_process.exec(command, (err, stdout, stderr) => {
      if (err) {
        return;
      }
    });
  }
});

// Convert CSV files to Gettext.
walkAndFindFiles(catalogs_path, '.csv', function(err, results) {
  if (err) throw err;
  for (var i = 0; i < results.length; i++) {

    var filename = results[i];
    var newFile  = 'gettext/' + filename.replaceAll(catalogs_path + '/', '').replaceAll('/', '_').replace('_' + language_to_convert + '.csv', '.po');
    console.log(newFile);
    var command  = 'csv2po ' + filename + ' ' + newFile;
    child_process.exec(command, (err, stdout, stderr) => {
      if (err) {
        return;
      }
    });
  }
});

