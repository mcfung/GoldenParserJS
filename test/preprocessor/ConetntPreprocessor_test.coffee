ContentPreprocessor = require('../../index').ContentPreprossor
cheerio = require('cheerio')
fs = require('fs')

exports.ContentPreprocessor =
  'test preprocess faces to use absolute url': (test) ->

    fs.readFile './test/viewFixtures/reply.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.expect 4
      test.ifError err
      subDomain = "m1"
      contentPreprocessor = new ContentPreprocessor(subDomain)
      $ = cheerio.load(data)
      $('.ReplyBox').each ->
        numberOfFaces = $('img[src^="/faces"]', @).length
        test.ok(numberOfFaces isnt 0)
        contentPreprocessor.preprocess(@, $)
        test.ok($('img[src^="/faces"]', @).length is 0)
        test.ok($("img[src^=\"http://#{subDomain}.hkgolden.com/faces\"]", @).length is numberOfFaces)
      test.done()