TopicListParser = require './parser/TopicListParser'
ThreadParser = require './parser/ThreadParser'
TypeParser = require './parser/TypeParser'
helper = require './utils/helper'

class MobileGoldenParser

  constructor: ->

  parseTopicList: (responseBody, onCompleteCallback) ->
    new TopicListParser().parse responseBody, onCompleteCallback

  parseThread: (responseBody, onCompleteCallback) ->
    new ThreadParser().parse responseBody, onCompleteCallback

  parseTypes: (responseBody, onCompleteCallback) ->
    new TypeParser().parse responseBody, onCompleteCallback

module.exports = MobileGoldenParser