cheerio = require "cheerio"

class TypeParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody

    result =
      types: []
    $('.MainBoxLink').each (i, ele)->
      self = $(ele)
      result.types.push
        name: self.text()
        key: self.attr('href').replace('./topics.aspx?type=', '')

    onCompleteCallback result

module.exports = TypeParser