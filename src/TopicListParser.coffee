cheerio = require "cheerio"

class TopicListParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody
    topicDoms = $ '.TopicBox_Details'
    result = []
    topicDoms.each ->
      getAuthorAndRating = (ele) ->
        authorDom = $ '.TopicBox_Author', ele
        text = authorDom.text().trim()
        author = text.substring 0, text.indexOf "-"
        rating = parseInt(text.substring text.lastIndexOf(":") + 2, text.lastIndexOf(")"))
        {
        author: author
        rating: rating
        }

      getTitle = (ele) ->
        titleDom = $ 'a div:not(.TopicBox_Replies)', ele
        titleDom.text().trim()

      getMessageId = (ele) ->
        link = $ 'a', ele
        href = link.attr 'href'
        href.substring href.indexOf("=") + 1, href.lastIndexOf("&")

      getTotalNumberOfPage = (ele) ->
        pageOptionsDom = $ '.TopicBox_PageSelect option', ele
        pageOptionsDom.length - 1

      getNumberOfReplies = (ele) ->
        numberOfReplies = $ '.TopicBox_Replies', ele
        numberOfReplies = parseInt numberOfReplies.text().trim()

      authorAndRating = getAuthorAndRating @
      title = getTitle @
      messageId = getMessageId @
      totalNumberOfPage = getTotalNumberOfPage @
      numberOfReplies = getNumberOfReplies @

      result.push
        author: authorAndRating.author
        rating: authorAndRating.rating
        title: title
        messageId: messageId
        totalNumberOfPage: totalNumberOfPage
        numberOfReplies: numberOfReplies

      onCompleteCallback result

module.exports = TopicListParser