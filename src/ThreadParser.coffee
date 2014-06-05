#$ = require './Selector'
cheerio = require "cheerio"
domainList = ['m1', 'm2', 'm3']

class ThreadParser

  parse: (responseBody, onCompleteCallback) ->
    $ = cheerio.load responseBody
    subDomain = domainList[Math.floor(Math.random() * domainList.length)]
    result = []
    result.isNextPageAvailable = $('.View_PageSelectRight').text().trim() isnt ''
    result.isPreviousPageAvailable = $('.View_PageSelectLeft').text().trim() isnt ''
    result.totalNumberOfPage = $('option', $('select.View_PageSelect').get(0)).length - 2
    replies = $ '.ReplyBox'
    replies.each ->

      prependDomainToImageSrc = (img) ->

        src = img.attr 'src'
        img.attr 'src', "http://#{subDomain}.hkgolden.com#{src}"

      authorDom = $ '.ViewNameMale, .ViewNameFemale', @
      if authorDom.length > 0

        author = authorDom.text()
        gender = if $('.ViewNameMale', @).length > 0 then "male" else "female"
        date = $('.ViewDate', @).text().trim();
        contentDom = $($(@).children('div').get(1))

        $('img[src^="/faces"]', contentDom).each ->
          prependDomainToImageSrc $ @

        images = []
        $('img.Image', contentDom).each ->
          $this = $ @
          $this.removeAttr 'onclick'
          prependDomainToImageSrc $this
          imageSrc = $this.attr 'alt'
          imageSrc = imageSrc.substring imageSrc.indexOf(']') + 1, imageSrc.lastIndexOf('[')
          $this.attr 'ng-src', imageSrc
          images.push imageSrc

        result.push
          author: author
          gender: gender
          content: contentDom.html()
          images: images
          date: date

    onCompleteCallback result

module.exports = ThreadParser