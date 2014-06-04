[![Build Status](https://travis-ci.org/mcfung/GoldenParserJS.svg?branch=master)](https://travis-ci.org/mcfung/GoldenParserJS)

GoldenParserJS
==============

This is used to parse forum post in hkgolden.com for further processing.


## Installation
`npm install golden-parser`

## Usage

```js
    var parser = require('golden-parser'),
        mobileGoldenParser = new parser.MobileGoldenParser(),
        fs = require('fs')

    // src of html, e.g. from a file
    fs.readFile('./topics.html', {
          encoding: 'utf8'
        }, function(err, html) {
            mobileGoldenParser.parseTopicList(html, function(topics) {
            });
        });
```

## API

### MobileGoldenParser (0.1.1)
#### .parseTopicList(html, function(topics)) (0.1.1)

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

#### .parseThread(html, function(result)) (0.1.1)

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
      images: ['http://example.com/example.jpg']
    }
]
```
The `content` will be returning encoded character so there will be something like `&#x99AC;`. It will be rendered as chinese in browser and this is the expected behavior.

Any image wrapped by `[img][/img]` will be preprocessed such that `onclick` is removed and the actual image src will be added as ng-src attribute.
e.g.
```html
<img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://abc.com/abc.jpg[/img]\" ng-src=\"https://abc.com/abc.jpg\">
```
All faces icon will be preprocessed to use absolute URL.

The `images` properties will store the images found in the reply, which is wrapped in `[img][/img]` internally in hkgolden.

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