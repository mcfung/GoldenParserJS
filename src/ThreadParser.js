// Generated by CoffeeScript 1.7.1
(function() {
  var ThreadParser, cheerio, domainList;

  cheerio = require("cheerio");

  domainList = ['m1', 'm2', 'm3'];

  ThreadParser = (function() {
    function ThreadParser() {}

    ThreadParser.prototype.parse = function(responseBody, onCompleteCallback) {
      var $, replies, result, subDomain;
      $ = cheerio.load(responseBody);
      subDomain = domainList[Math.floor(Math.random() * domainList.length)];
      replies = $('.ReplyBox');
      result = [];
      replies.each(function() {
        var author, authorDom, contentDom, gender, images;
        authorDom = $('.ViewNameMale, .ViewNameFemale', this);
        if (authorDom.length > 0) {
          author = authorDom.text();
          gender = $('.ViewNameMale', this).length > 0 ? "male" : "female";
          contentDom = $($(this).children('div').get(1));
          $('img[src^="/faces"]', contentDom).each(function() {
            var $this, src;
            $this = $(this);
            src = $this.attr('src');
            return $this.attr('src', "http://" + subDomain + ".hkgolden.com" + src);
          });
          images = [];
          $('img.Image', contentDom).each(function() {
            var $this, imageSrc, src;
            $this = $(this);
            $this.removeAttr('onclick');
            src = $this.attr('src');
            $this.attr('src', "http://" + subDomain + ".hkgolden.com" + src);
            imageSrc = $this.attr('alt');
            imageSrc = imageSrc.substring(imageSrc.indexOf(']') + 1, imageSrc.lastIndexOf('['));
            $this.attr('img-src', imageSrc);
            return images.push(imageSrc);
          });
          return result.push({
            author: author,
            gender: gender,
            content: contentDom.html(),
            images: images
          });
        }
      });
      return onCompleteCallback(result);
    };

    return ThreadParser;

  })();

  module.exports = ThreadParser;

}).call(this);

//# sourceMappingURL=ThreadParser.map
