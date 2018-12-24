const request = require('request');
const cheerio = require('cheerio');
const fs      = require('fs')
const async   = require('async');


var q = async.queue(function(project, callback) {
  printPoUrls(project);
  callback();
}, 10);


function printPoUrls(project) {
  request(project, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      var $ = cheerio.load(body);
      $('a').each(function() {
        if ($(this).attr('href').indexOf('.ca.po') !== -1) {
          var po_file_url = project + $(this).attr('href');
          console.log(po_file_url);
        }
      });
    }
    else {
      console.error(error + " with url " + project);
    }
  });
}


function generatePoUlrs(branch) {

  var prefix_url = 'https://ftp-origin.drupal.org/files/translations/' + branch + '/';

  request(prefix_url, function (error, response, body) {
    if (!error && response.statusCode == 200) {

      var $ = cheerio.load(body);
      $('a').each(function() {
        q.push(prefix_url + $(this).attr('href'));
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
  generatePoUlrs(process.argv[2]);
}
