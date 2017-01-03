cheerio = require "cheerio"

class TopicListParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody
    topicDoms = $ '.topic'
    result =
      isNextPageAvailable: $('.ui-block-c>a').text().trim() isnt ''
      isPreviousPageAvailable: $('.ui-block-a>a').text().trim() isnt ''
      totalNumberOfPage: +$('.pageno').text().substring($('.pageno').text().lastIndexOf(' '))
      topics: []

    topicDoms.each ->
      getAuthorAndRating = (ele) ->
        authorDom = $ '.topic-name', ele
        author = authorDom.text().trim()
        rating = +$('.topic-count-like', ele).text()-$('.topic-count-dislike', ele).text()
        {
        author: author
        rating: rating
        }

      getTitle = (ele) ->
        titleDom = $ '.topic-title', ele
        titleDom.text().trim()

      getMessageId = (ele) ->
        link = $ 'a', ele
        href = link.attr 'href'
        href.substring href.indexOf("=") + 1, href.lastIndexOf("&")

      getTotalNumberOfPage = (ele) ->
        $('.topic-page', ele).attr('totalpage')

      getNumberOfReplies = (ele) ->
        numberOfReplies = $ '.topic-count-comment', ele
        numberOfReplies = parseInt numberOfReplies.text().trim()

      authorAndRating = getAuthorAndRating @
      title = getTitle @
      messageId = getMessageId @
      totalNumberOfPage = getTotalNumberOfPage @
      numberOfReplies = getNumberOfReplies @

      result.topics.push
        author: authorAndRating.author
        rating: authorAndRating.rating
        title: title
        messageId: messageId
        totalNumberOfPage: totalNumberOfPage
        numberOfReplies: numberOfReplies

    onCompleteCallback result

module.exports = TopicListParser