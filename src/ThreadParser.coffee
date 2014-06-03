#$ = require './Selector'
cheerio = require "cheerio"

class ThreadParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody

    replies = $ '.ReplyBox'
    result = []
    replies.each ->
      authorDom = $ '.ViewNameMale, .ViewNameFemale', @
      if authorDom.length > 0
        author = authorDom.text()
        gender = if $('.ViewNameMale', @).length > 0 then "male" else "female"
        contentDom = $($(@).children('div').get(1))
        images = []
        $('img.Image', contentDom).each ->
          imageSrc = $(@).attr 'alt'
          imageSrc = imageSrc.substring imageSrc.indexOf(']') + 1, imageSrc.lastIndexOf('[')
          images.push imageSrc

        result.push
          author: author
          gender: gender
          content: contentDom.html()
          images: images

    onCompleteCallback result

module.exports = ThreadParser