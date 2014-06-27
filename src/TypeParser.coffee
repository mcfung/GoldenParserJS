cheerio = require "cheerio"

class TypeParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody

    result = []
    $('.MainBoxLink').each (i, ele)->
      self = $(ele)
      result.push
        name: self.text()
        key: self.attr('href').replace('./topics.aspx?type=', '')


    onCompleteCallback result

module.exports = TypeParser