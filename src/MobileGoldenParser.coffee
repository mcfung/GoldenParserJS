TopicListParser = require './parser/mobile/TopicListParser'
ThreadParser = require './parser/mobile/ThreadParser'
TypeParser = require './parser/mobile/TypeParser'
extend = require('./utils/helper').extend
domainList = require('./utils/domainList')
MobileGoldenContentPreprocessor = require('./preprocessor/MobileGoldenContentPreprocessor')

subDomain = domainList[Math.floor(Math.random() * domainList.length)]
defaultOptions =
  contentPreprocessors: [new MobileGoldenContentPreprocessor(subDomain)]

class MobileGoldenParser

  constructor: (options) ->
    @options = extend(defaultOptions, options)

  parseTopicList: (responseBody, onCompleteCallback) ->
    new TopicListParser().parse responseBody, onCompleteCallback

  parseThread: (responseBody, onCompleteCallback) ->
    new ThreadParser(@options.contentPreprocessors).parse responseBody, onCompleteCallback

  parseTypes: (responseBody, onCompleteCallback) ->
    new TypeParser().parse responseBody, onCompleteCallback

module.exports = MobileGoldenParser