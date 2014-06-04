#$ = require './Selector'
cheerio = require "cheerio"
domainList = ['m1', 'm2', 'm3']

class ThreadParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody
    subDomain = domainList[Math.floor(Math.random() * domainList.length)]

    replies = $ '.ReplyBox'
    result = []
    replies.each ->

      prependDomainToImageSrc = (img) ->

        src = img.attr 'src'
        img.attr 'src', "http://#{subDomain}.hkgolden.com#{src}"

      authorDom = $ '.ViewNameMale, .ViewNameFemale', @
      if authorDom.length > 0
        author = authorDom.text()
        gender = if $('.ViewNameMale', @).length > 0 then "male" else "female"
        contentDom = $($(@).children('div').get(1))

        $('img[src^="/faces"]', contentDom).each ->
          prependDomainToImageSrc $ @

        images = []
        $('img.Image', contentDom).each ->
          $this = $ @
          $this.removeAttr 'onclick'
          prependDomainToImageSrc $this
          imageSrc = $this.attr 'alt'
          imageSrc = imageSrc.substring imageSrc.indexOf(']') + 1, imageSrc.lastIndexOf('[')
          $this.attr 'ng-src', imageSrc
          images.push imageSrc

        result.push
          author: author
          gender: gender
          content: contentDom.html()
          images: images

    onCompleteCallback result

module.exports = ThreadParser