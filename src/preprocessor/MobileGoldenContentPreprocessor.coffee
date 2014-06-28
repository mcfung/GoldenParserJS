cheerio = require('cheerio')
ContentPreprocessor = require('./ContentPreprocessor')

class MobileGoldenContentPreprocessor extends ContentPreprocessor

  preprocess: (ele) ->
    super(ele)
    $ = cheerio.load(ele)

    preprocessor = @
    $('img.Image').each ->
      $this = $ @
      $this.removeAttr 'onclick'
      preprocessor.prependDomainToImageSrc $this
      imageSrc = $this.attr 'alt'
      imageSrc = imageSrc.substring imageSrc.indexOf(']') + 1, imageSrc.lastIndexOf('[')
      $this.attr 'ng-src', imageSrc

module.exports = MobileGoldenContentPreprocessor