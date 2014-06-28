cheerio = require("cheerio")

class ContentPreprocessor

  constructor: (@subDomain) ->

  preprocess: (ele) ->
    $ = cheerio.load(ele)

    preprocessor = @
    $('img[src^="/faces"]').each ->
      preprocessor.prependDomainToImageSrc $ @

  prependDomainToImageSrc: (img) ->

    src = img.attr('src')
    img.attr('src', "http://#{@subDomain}.hkgolden.com#{src}")

module.exports = ContentPreprocessor