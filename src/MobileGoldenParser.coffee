TopicListParser = require './parser/TopicListParser'
ThreadParser = require './parser/ThreadParser'
TypeParser = require './parser/TypeParser'
extend = require('./utils/helper').extend
domainList = require('./utils/domainList')
MobileGoldenContentPreprocessor = require('./preprocessor/MobileGoldenContentPreprocessor')

subDomain = domainList[Math.floor(Math.random() * domainList.length)]
defaultOptions =
  contentPreprocessor: new MobileGoldenContentPreprocessor(subDomain)

class MobileGoldenParser

  constructor: (options) ->
    @options = extend(defaultOptions, options)

  parseTopicList: (responseBody, onCompleteCallback) ->
    new TopicListParser().parse responseBody, onCompleteCallback

  parseThread: (responseBody, onCompleteCallback) ->
    new ThreadParser(@options.contentPreprocessor).parse responseBody, onCompleteCallback

  parseTypes: (responseBody, onCompleteCallback) ->
    new TypeParser().parse responseBody, onCompleteCallback

module.exports = MobileGoldenParser