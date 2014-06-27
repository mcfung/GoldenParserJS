TopicListParser = require './TopicListParser'
ThreadParser = require './ThreadParser'
TypeParser = require './TypeParser'

class MobileGoldenParser

  parseTopicList: (responseBody, onCompleteCallback) ->
    new TopicListParser().parse responseBody, onCompleteCallback

  parseThread: (responseBody, onCompleteCallback) ->
    new ThreadParser().parse responseBody, onCompleteCallback

  parseTypes: (responseBody, onCompleteCallback) ->
    new TypeParser().parse responseBody, onCompleteCallback

module.exports = MobileGoldenParser