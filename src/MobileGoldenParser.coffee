TopicListParser = require './TopicListParser'
ThreadParser = require './ThreadParser'

class MobileGoldenParser

  parseTopicList: (responseBody, onCompleteCallback) ->
    new TopicListParser().parse responseBody, onCompleteCallback

  parseThread: (responseBody, onCompleteCallback) ->
    new ThreadParser().parse responseBody, onCompleteCallback

module.exports = MobileGoldenParser