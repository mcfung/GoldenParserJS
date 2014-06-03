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

    fs.readFile('./topics.html', {
          encoding: 'utf8'
        }, function(err, html) {
            mobileGoldenParser.parseTopicList(html, function(topics) {
            });
        });
```