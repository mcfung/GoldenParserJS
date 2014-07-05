MobileGoldenContentPreprocessor = require('../../index').MobileGoldenContentPreprocessor
cheerio = require('cheerio')
getImageSourceFromAlt = require('../../src/utils/helper').getImageSourceFromAlt
fs = require('fs')

exports.MobileGoldenContentPreprocessor =
  'test preprocess .Image': (test) ->

    fs.readFile './test/viewFixtures/reply.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.expect 5
      test.ifError err
      subDomain = "m1"
      contentPreprocessor = new MobileGoldenContentPreprocessor(subDomain)
      $ = cheerio.load(data)
      $('.ReplyBox').each ->
        test.ok($('img.Image', @).attr('ng-src') is undefined)
        test.ok($('img.Image', @).attr('onclick') isnt undefined)
        originalAlt = $('img.Image', @).attr('alt')
        contentPreprocessor.preprocess(@, $)
        test.equal($('img.Image', @).attr('ng-src'), (originalAlt.substring originalAlt.indexOf(']') + 1, originalAlt.lastIndexOf('[')))
        test.ok($('img.Image', @).attr('onclick') is undefined)
      test.done()
