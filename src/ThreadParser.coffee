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
      authorDom = $ '.ViewNameMale, .ViewNameFemale', @
      if authorDom.length > 0
        author = authorDom.text()
        gender = if $('.ViewNameMale', @).length > 0 then "male" else "female"
        contentDom = $($(@).children('div').get(1))

        $('img[src^="/faces"]', contentDom).each ->
          $this = $ @
          src = $this.attr 'src'
          $this.attr 'src', "http://#{subDomain}.hkgolden.com#{src}"

        images = []
        $('img.Image', contentDom).each ->
          $this = $ @
          $this.removeAttr 'onclick'
          src = $this.attr 'src'
          $this.attr 'src', "http://#{subDomain}.hkgolden.com#{src}"
          imageSrc = $this.attr 'alt'
          imageSrc = imageSrc.substring imageSrc.indexOf(']') + 1, imageSrc.lastIndexOf('[')
          $this.attr 'img-src', imageSrc
          images.push imageSrc

        result.push
          author: author
          gender: gender
          content: contentDom.html()
          images: images

    onCompleteCallback result

module.exports = ThreadParser