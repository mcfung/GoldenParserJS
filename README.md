[![Build Status](https://travis-ci.org/mcfung/GoldenParserJS.svg?branch=master)](https://travis-ci.org/mcfung/GoldenParserJS)

GoldenParserJS
==============

This is used to parse forum post in hkgolden.com for further processing.

## Installation
```
npm install golden-parser
```

## Usage

```js
    var parser = require('golden-parser'),
        mobileGoldenParser = new parser.MobileGoldenParser({
            contentPreprocessors: [function(contentElement) {
                // do something here
            }]
        }),
        fs = require('fs')

    // src of html, e.g. from a file
    fs.readFile('./topics.html', {
          encoding: 'utf8'
        }, function(err, html) {
            mobileGoldenParser.parseTopics(html, function(result) {
            });
        });
```

## API

### MobileGoldenParser (0.1.1)

Create a parser object to parse the HTML.

### MobileGoldenParser(options) (0.2.0)

Create a parser object with options to parse the HTML.
Available options:

* contentPreprocessors (default: `[new ContentPreprocess()]`)

    array of function(element, $) or object with preprocess(element, $) method
Each reply will be preprocessed by each preprocessor. `element` given is the DOMElement of the processing reply and $ is the cheerio object of the whole page.

#### .parseTopicList(html, function(topics)) (0.1.1) (deprecated)

This method is deprecated because the augmentation of array object may incur some implementation problem for its caller.
Use .parseTopics instead.

This method parse the `html` of topic page of mobile golden forum to an array of JSON objects.
Each JSON object represents a topic.
The array of JSON object is then passed to the callback from the second argument, which will be called when parse complete.
The expected JSON object is as follows:
```js
[
    {
      author: 'someAuthor',
      rating: 0,
      title: 'someTitle',
      messageId: '1234567',
      totalNumberOfPage: 15,
      numberOfReplies: 359
    }
]
```

(since 0.1.3)

`isNextPageAvailable` and `isPreviousPageAvailable` are added to the array as a property to indicate if next or previous page is available.

`totalNumberOfPage` is added to the array as a property to indicate the total number of page of topics.

#### .parseTopics(html, function(result)) (0.2.0)

This method parse the `html` of topic page of mobile golden forum and pass the parse result to the callback.
The expected parse result is as follows:
```js
{
  isNextPageAvailable: true,
  isPreviousPageAvailable: false,
  totalNumberOfPage: 100,
  topics: [
    {
        author: 'someAuthor',
        rating: 0,
        title: 'someTitle',
        messageId: '1234567',
        totalNumberOfPage: 15,
        numberOfReplies: 359
    }
  ]
}
```                          

#### .parseThread(html, function(result)) (0.1.1) (deprecated)

This method is deprecated because the augmentation of array object may incur some implementation problem for its caller.
Use .parseThreadContent instead.

This method parse the `html` of thread page of one of the thread in mobile golden forum to an array of JSON objects.
Each JSON object represents a reply.
The array of JSON object is then passed to the callback from the second argument, which will be called when parse complete.
The expected JSON object is as follows:
```js
[
    {
      author: 'someAuthor',
      gender: 'male',
      content: 'someContent',
      images: ['http://example.com/example.jpg'],
      date: '6/3/2014 6:49 AM', // (since 0.1.3)
      replyId: '179492794' // (since 0.1.5)
    }
]
```
The `content` will be returning encoded character so there will be something like `&#x99AC;`.
It will be rendered as chinese in browser and this is the expected behavior.

The `images` properties will store the images found in the reply, which is wrapped in `[img][/img]` internally in hkgolden.

(since 0.1.2)

Any image wrapped by `[img][/img]` will be preprocessed such that `onclick` is removed and the actual image src will be added as `ng-src` attribute by default.
e.g.
```html
<img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://abc.com/abc.jpg[/img]\" ng-src=\"https://abc.com/abc.jpg\">
```

All faces icon will be preprocessed to use absolute URL by default.

(since 0.1.3)

`isNextPageAvailable` and `isPreviousPageAvailable` are added to the array as a property to indicate if next or previous page is available.

`totalNumberOfPage` is added to the array as a property to indicate the total number of page of given thread.

`title` is added to the array as a property to indicate the title of the thread.

#### .parseThreadContent(html, function(result)) (0.2.0)

This method will preprocess and parse the `html` of thread page of one of the thread in mobile golden forum according to the preprocessors.
And then pass the parse result to the callback.
The expected JSON object is as follows:
```js
{
  isNextPageAvailable: true,
  isPreviousPageAvailable: false,
  totalNumberOfPage: 1,
  title: 'some title',
  replies: [
      {
          author: 'someAuthor',
          gender: 'male',
          content: 'someContent',
          images: ['http://example.com/example.jpg'],
          date: '6/3/2014 6:49 AM',
          replyId: '179492794'
      }
  ]
}
```             
The `content` will be returning encoded character so there will be something like `&#x99AC;`.
It will be rendered as chinese in browser and this is the expected behavior.

The `images` properties will store the images found in the reply, which is wrapped in `[img][/img]` internally in hkgolden.

#### .parseTypes(html, function(result)) (0.2.0)

This method parse the `html` of forum types page of mobile golden forum to an array of JSON objects.
Each JSON object represents a type.
The array of JSON is then passed to the callback from the argument, which will be called when parse completed.
The expected JSON object is as follows:
```js
[
  {
    name: '吹水台'
    key: 'BW'
  }
]
```

### ContentPreprocessor(subDomain) (0.2.0)

```js
    var parser = require('golden-parser'),
        ContentPreprocessor = new parser.ContentPreprocessor("m3"),      
        mobileGoldenParser = new parser.MobileGoldenParser({
            contentPreprocessors: [contentPreprocessor]
        }),
        fs = require('fs')

    // src of html, e.g. from a file
    fs.readFile('./topics.html', {
          encoding: 'utf8'
        }, function(err, html) {
            mobileGoldenParser.parseTopics(html, function(result) {
            });
        });
```
It is a coffeescript class so you can extends this class easily for more preprocessing.

#### .preprocess(element, $)

This method will prepend `http://#{@subDomain}.hkgolden.com` to the source of all image which source is start with `/faces` which would be the face icon in golden such that all face icon will be using absolute URL.

#### .prependDomainToImageSrc(img)

This method will prepend `http://#{@subDomain}.hkgolden.com` to the source of given image cheerio object                                     

### MobileGoldenContentPreprocessor(subDomain) (0.2.0)

This is subclass of ContentPreprocessor.

```js
    var parser = require('golden-parser'),
        ContentPreprocessor = new parser.MobileGoldenContentPreprocessor("m3"),      
        mobileGoldenParser = new parser.MobileGoldenParser({
            contentPreprocessors: [contentPreprocessor]
        }),
        fs = require('fs')

    // src of html, e.g. from a file
    fs.readFile('./topics.html', {
          encoding: 'utf8'
        }, function(err, html) {
            mobileGoldenParser.parseTopics(html, function(result) {
            });
        });
```

#### .preprocess(element, $)

In addition to the behavior of its super class, it finds all image of class Image, remove its onclick attribute and prepend `http://#{@subDomain}.hkgolden.com` to the source. Extract the actual image source from alt and put it in ng-src directive.
  
#### .prependDomainToImageSrc(img)

Same as its super class.

## Potential issues

As the html structure of hkgolden may change overtime, this package may not be working properly when html structure of hkgolden is changed.
When it is not working anymore, please create a issue for follow up.

## License

The MIT License (MIT)

Copyright (c) 2014 Mike

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.