const request = require('request');
const cheerio = require('cheerio');
const fs      = require('fs')


var delay = 0;

function printPoUrls(project_url, branch, project) {

  // Ignore drupal core.
  if (project !== 'drupal/') {
    request(project_url, function (error, response, body) {
      if (!error && response.statusCode == 200) {
        var $ = cheerio.load(body);
        $('a').each(function() {
          if ($(this).attr('href').indexOf('.ca.po') !== -1) {
            var file_url = project_url + $(this).attr('href');
            fs.appendFileSync('urls_' + branch + '.txt', file_url + '\n dir=po/' + project + '\n');
          }
        });
      }
      else {
        console.error(error + " with url " + project_url);
      }
    });
  }
}


function generatePoUlrs(branch) {

  var prefix_url = 'https://ftp-origin.drupal.org/files/translations/' + branch + '/';

  request(prefix_url, function (error, response, body) {
    if (!error && response.statusCode == 200) {

      var $ = cheerio.load(body);
      $('a').each(function() {

        delay += 50;
        var project_name = $(this).attr('href');
        var url = prefix_url + project_name;

        setTimeout(function() {
          printPoUrls(url, branch, project_name);
        }, delay);

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

  // Empty file.
  fs.writeFileSync('urls_' + process.argv[2] + '.txt', '');

  generatePoUlrs(process.argv[2]);
}
