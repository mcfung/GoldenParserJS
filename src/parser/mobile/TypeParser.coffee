cheerio = require "cheerio"

class TypeParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody

    result =
      types: []
    $('#channels>ul>li>a').each (i, ele)->
      self = $(ele)
      result.types.push
        name: self.text()
        key: self.attr('type')

    onCompleteCallback result

module.exports = TypeParser