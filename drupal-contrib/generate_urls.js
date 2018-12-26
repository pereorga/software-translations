const request = require('request');
const cheerio = require('cheerio');
const fs      = require('fs');
const xml2js  = require('xml2js');


function printPoUrls(project_url, branch, project) {

  if (project === 'commerce_drupalgap_kickstart') {

    // Skip useless projects.
    return;
  }

  request('https://updates.drupal.org/release-history/' + project + '/' + branch, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      xml2js.parseString(body, function (error, result) {

        if (!error && result

            // Project is valid.
            && typeof result['project'] !== 'undefined'
            && typeof result['project']['type'] !== 'undefined'
            && typeof result['project']['type'][0] !== 'undefined'

            // Project has releases.
            && typeof result['project']['releases'] !== 'undefined'
            && typeof result['project']['releases'][0] !== 'undefined'
            && typeof result['project']['releases'][0]['release'] !== 'undefined') {

          var project_is_module = result['project']['type'][0] === 'project_module';

          if (project_is_module) {

            var releases = result['project']['releases'][0]['release'];

            var latest_release_date = 0;
            var latest_release_name = '';

            var i;
            for (i = 0; i < releases.length; i++) {

              if (typeof releases[i]['date'] !== 'undefined'
                  && typeof releases[i]['date'][0] !== 'undefined'
                  && typeof releases[i]['tag'] !== 'undefined'
                  && typeof releases[i]['tag'][0] !== 'undefined'

                  && releases[i]['date'][0] > latest_release_date) {

                latest_release_date = releases[i]['date'][0];
                latest_release_name = releases[i]['tag'][0];

              }
            }

            var last_file = project + '-' + latest_release_name + '.ca.po';

            request({method: 'GET', uri: project_url + '?disable_caching=' + Math.floor(Math.random() * 100)}, function (error, response, body) {
              if (!error && response.statusCode == 200) {
                var $ = cheerio.load(body);
                var matched = false;
                $('a').each(function() {

                    var file_url = project_url + '/' + $(this).attr('href');
                    if (file_url.endsWith(last_file)) {
                      fs.appendFileSync('urls_' + branch + '.txt', file_url + '\n dir=po/' + branch + '\n');
                      matched = true;
                    }
                });
                if (!matched) {

                  // Download all.
                  var $ = cheerio.load(body);
                  $('a').each(function() {

                    if ($(this).attr('href').indexOf('.ca.po') !== -1) {
                      var file_url = project_url + '/' + $(this).attr('href');
                      fs.appendFileSync('urls_' + branch + '.txt', file_url + '\n dir=po/' + branch + '/projects/' + project + '\n');
                    }
                  });
                }
              }
              else {
                console.error(error + " with url " + project_url);
              }
            });
          }
        }
      });
    }
    else {
      console.error(error + " with url " + project_url);
    }
  });

}


function generatePoUlrs(branch) {

  var prefix_url = 'https://ftp-origin.drupal.org/files/translations/' + branch + '/';

  var delay = 0;

  request(prefix_url, function (error, response, body) {
    if (!error && response.statusCode == 200) {

      var $ = cheerio.load(body);
      $('a').each(function() {

        var project_name = $(this).attr('href').slice(0, -1);
        if (project_name !== '..') {
          var url = prefix_url + project_name;
          setTimeout(function() {
            printPoUrls(url, branch, project_name);
          }, delay);
          delay += 200;
        }
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
  console.error('Usage: node generate_urls.js 7.x');
}
else {

  var version = process.argv[2];

  // Empty file.
  fs.writeFileSync('urls_' + version + '.txt', '');

  generatePoUlrs(version);
}
