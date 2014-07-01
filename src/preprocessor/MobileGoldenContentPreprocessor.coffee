cheerio = require('cheerio')
ContentPreprocessor = require('./ContentPreprocessor')
getImageSourceFromAlt = require('../utils/helper').getImageSourceFromAlt

class MobileGoldenContentPreprocessor extends ContentPreprocessor

  preprocess: (ele) ->
    super(ele)
    $ = cheerio.load(ele)

    preprocessor = @
    $('img.Image').each ->
      $this = $ @
      $this.removeAttr 'onclick'
      preprocessor.prependDomainToImageSrc $this
      $this.attr 'ng-src', getImageSourceFromAlt($this)

module.exports = MobileGoldenContentPreprocessor