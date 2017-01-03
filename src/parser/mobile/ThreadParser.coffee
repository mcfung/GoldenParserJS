cheerio = require("cheerio")
getImageSourceFromAlt = require('../../utils/helper').getImageSourceFromAlt

class ThreadParser

  constructor: (@preprocessors) ->

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody

    preprocessors = @preprocessors
    result =
      isNextPageAvailable: $('.btn-page-next').length > 0
      isPreviousPageAvailable: $('.btn-page-prev').length > 0
      totalNumberOfPage: +$('.pageno').text().substring($('.pageno').text().lastIndexOf(' '))
      title: $('#heading').text().trim()
      replies: []
    replies = $ '.post'
    replies.each ->

      getReplyIdFromDom = ->

        id = $(@).attr('id')
        id.substring(id.indexOf('_') + 1)

      for contentPreprocessor in preprocessors
        if typeof contentPreprocessor is 'function'
          contentPreprocessor(@, $)
        else
          contentPreprocessor?.preprocess?(@, $)

      authorDom = $ '.name_male, .name_female', @
      if authorDom.length > 0

        author = authorDom.text()
        gender = if $('.name_male', @).length > 0 then "male" else "female"
        date = $('.topic-time', @).text().trim();
        contentDom = $('.post-content2', @)

        replyId = getReplyIdFromDom.call @

        images = []
        $('img.Image', contentDom).each ->
          $this = $ @
          images.push getImageSourceFromAlt($this)

        result.replies.push
          author: author
          gender: gender
          content: contentDom.html()
          images: images
          date: date
          replyId: replyId

    onCompleteCallback result

module.exports = ThreadParser