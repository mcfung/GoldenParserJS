class ContentPreprocessor

  constructor: (@subDomain) ->

  preprocess: (ele, $) ->

    preprocessor = @
    $(ele).find('img[src^="/faces"]').each ->
      preprocessor.prependDomainToImageSrc $ @

  prependDomainToImageSrc: (img) ->

    src = img.attr('src')
    img.attr('src', "http://#{@subDomain}.hkgolden.com#{src}")

module.exports = ContentPreprocessor