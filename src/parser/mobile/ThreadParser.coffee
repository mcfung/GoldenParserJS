cheerio = require("cheerio")
getImageSourceFromAlt = require('../../utils/helper').getImageSourceFromAlt

class ThreadParser

  constructor: (@preprocessors) ->

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody

    preprocessors = @preprocessors
    result = []
    result.isNextPageAvailable = $('.View_PageSelectRight').text().trim() isnt ''
    result.isPreviousPageAvailable = $('.View_PageSelectLeft').text().trim() isnt ''
    result.totalNumberOfPage = $('option', $('select.View_PageSelect').get(0)).length - 2
    result.title = $('.ViewTitle').text().trim()
    replies = $ '.ReplyBox'
    replies.each ->

      getReplyIdFromDom = ->

        quoteLink = $('.ViewAuthorPanel a', @).attr('href')
        quoteLinkPattern = /(rid=[0-9]*)/g
        rid = quoteLink.match(quoteLinkPattern)[0]
        rid.substring(rid.indexOf('=') + 1)

      for contentPreprocessor in preprocessors
        if typeof contentPreprocessor is 'function'
          contentPreprocessor(@, $)
        else
          contentPreprocessor?.preprocess?(@, $)

      authorDom = $ '.ViewNameMale, .ViewNameFemale', @
      if authorDom.length > 0

        author = authorDom.text()
        gender = if $('.ViewNameMale', @).length > 0 then "male" else "female"
        date = $('.ViewDate', @).text().trim();
        contentDom = $($(@).children('div').get(1))

        replyId = getReplyIdFromDom.call @

        images = []
        $('img.Image', contentDom).each ->
          $this = $ @
          images.push getImageSourceFromAlt($this)

        result.push
          author: author
          gender: gender
          content: contentDom.html()
          images: images
          date: date
          replyId: replyId

    onCompleteCallback result

module.exports = ThreadParser