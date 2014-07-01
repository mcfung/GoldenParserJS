// Generated by CoffeeScript 1.7.1
(function() {
  var TypeParser, cheerio;

  cheerio = require("cheerio");

  TypeParser = (function() {
    function TypeParser() {}

    TypeParser.prototype.parse = function(responseBody, onCompleteCallback) {
      var $, result;
      $ = cheerio.load(responseBody);
      result = [];
      $('.MainBoxLink').each(function(i, ele) {
        var self;
        self = $(ele);
        return result.push({
          name: self.text(),
          key: self.attr('href').replace('./topics.aspx?type=', '')
        });
      });
      return onCompleteCallback(result);
    };

    return TypeParser;

  })();

  module.exports = TypeParser;

}).call(this);

//# sourceMappingURL=TypeParser.map