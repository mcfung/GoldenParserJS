cheerio = require "cheerio"

class TypeParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody

    $('.MainBoxLink').each (i, ele)->
      self = $(ele)
      {
        name: self.text()
        key: self.attr('href').replace('http://m1.hkgolden.com/topics.aspx?type=', '').replace('http://m2.hkgolden.com/topics.aspx?type=', '').replace('http://m3.hkgolden.com/topics.aspx?type=', '')
      }

module.exports = TypeParser