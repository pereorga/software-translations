const request = require('request');
const cheerio = require('cheerio');
var fs = require('fs')

function generatePoUlrs(version) {

  var prefix_url = 'https://ftp-origin.drupal.org/files/translations/' + version + '/';

  request(prefix_url, function (error, response, body) {
    if (!error && response.statusCode == 200) {

      var $ = cheerio.load(body);

      $('a').each(function() {
        var project_path = prefix_url + $(this).attr('href');
        request(project_path, function (error, response, body) {
          if (!error && response.statusCode == 200) {
            var $p = cheerio.load(body);
            $p('a').each(function() {
              if ($p(this).attr('href').indexOf('.ca.po') !== -1) {
                var po_file_url = project_path + $p(this).attr('href');
                fs.appendFileSync('urls_' + version + '.txt', po_file_url + '\n');
              }
            });
          }
          else {
            console.error("Error " + error + " in " + project_path);
          }
        });
      });
    }
    else {
      console.error(error);
    }
  });
}

if (typeof process.argv[2] === 'undefined' || (
    process.argv[2] !== '6.x'
    && process.argv[2] !== '7.x'
    && process.argv[2] !== '8.x'
  )) {
  console.error('Usage: node generate_urls.js 7.x')
}
else {

  var version = process.argv[2];

  // Remove file contents.
  fs.writeFileSync('urls_' + version + '.txt', '');

  generatePoUlrs(version);
}
