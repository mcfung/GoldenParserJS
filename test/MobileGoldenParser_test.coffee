fs = require 'fs'

exports.MobileGoldenParser =
  setUp: (done) ->
    @backupRand = Math.random
    Math.random = ->
      0.99
    done()

  tearDown: (done) ->
    Math.random = @backupRand
    done()
  'test parse topic list': (test) ->
    parser = require '../index'
    mobileGoldenParser = new parser.MobileGoldenParser()
    fs.readFile './test/viewFixtures/topics.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseTopicList data, (topics) ->
        expected = [
          {
            author: '歸零睪'
            rating: 3
            title: '有冇巴絲做過去暗瘡印凹凸洞同收毛孔既treatment?'
            messageId: '6644173'
            totalNumberOfPage: 5
            numberOfReplies: 112
          }
          {
            author: '米子米弭'
            rating: -7,
            title: '[戀愛相談] 你問我答'
            messageId: '6649960'
            totalNumberOfPage: 4
            numberOfReplies: 100
          }
        ]
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 2997
        test.deepEqual topics, expected
        test.done()

  'test parse thread': (test) ->
    parser = require '../index'

    MobileGoldenContentPreprocessor = parser.MobileGoldenContentPreprocessor
    mobileGoldenParser = new parser.MobileGoldenParser({
      contentPreprocessors: [new MobileGoldenContentPreprocessor('m3')]
    })
    fs.readFile './test/viewFixtures/thread.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseThread data, (result) ->
        expected =[
          {
            "author": "B頭佬III",
            "content": "<img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" show=\"0\" alt=\"[img]http://static.apple.nextmedia.com/images/e-paper/20161201/large/1480571640_42d3.jpg[/img]\" ng-src=\"http://static.apple.nextmedia.com/images/e-paper/20161201/large/1480571640_42d3.jpg\">\r\n                    <br>\r\n                    <br>&#x5167;&#x5730;&#x8FD1;&#x5E74;&#x6709;&#x4E0D;&#x5C11;&#x7DB2;&#x7D61;&#x91D1;&#x878D;&#x793E;&#x4EA4;&#x5E73;&#x53F0;&#xFF0C;&#x66F4;&#x65E9;&#x5DF2;&#x5165;&#x4FB5;&#x5167;&#x5730;&#x6821;&#x5712;&#x3002;&#x6709;&#x501F;&#x65B9;&#x56E0;&#x6015;&#x5973;&#x5B78;&#x751F;&#x5C07;&#x4F86;&#x672A;&#x80FD;&#x9084;&#x6B3E;&#xFF0C;&#x8981;&#x6C42;&#x5973;&#x5B78;&#x751F;&#x5148;&#x62CD;&#x88F8;&#x7167;&#x6216;&#x5F71;&#x7247;&#x4F5C;&#x300C;&#x62B5;&#x62BC;&#x300D;&#x3002;\r\n                    <br>\r\n                    <br>&#x6628;&#x65E5;&#x5167;&#x5730;&#x5831;&#x9053;&#xFF0C;&#x5176;&#x4E2D;&#x4E00;&#x820D;&#x5E73;&#x53F0;&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x6D41;&#x51FA;&#x4E0D;&#x5C11;&#x5973;&#x5B78;&#x751F;&#x88F8;&#x7167;&#x6216;&#x5F71;&#x7247;&#xFF0C;&#x5BB9;&#x91CF;&#x591A;&#x9054;10GB&#x3002;&#x501F;&#x6B3E;&#x7684;&#x5973;&#x5B50;&#xFF0C;&#x5927;&#x90E8;&#x5206;&#x65BC;1993&#x81F3;1997&#x5E74;&#x51FA;&#x751F;&#xFF0C;&#x4E5F;&#x6709;&#x500B;&#x5225;1981&#x5E74;&#x3001;1982&#x5E74;&#x3002;&#x5831;&#x9053;&#x6307;&#xFF0C;&#x501F;&#x9322;&#x7684;&#x689D;&#x4EF6;&#x4E0D;&#x55AE;&#x662F;&#x5F71;&#x88F8;&#x7167;&#xFF0C;&#x751A;&#x81F3;&#x8981;&#x88F8;&#x804A;&#x3002;\r\n                    <br>&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x5B98;&#x65B9;&#x5C31;&#x6B64;&#x5426;&#x8A8D;&#xFF0C;&#x6307;&#x660E;&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x6839;&#x672C;&#x4E0D;&#x63D0;&#x4F9B;&#x7167;&#x7247;&#x50B3;&#x9001;&#x529F;&#x80FD;&#xFF0C;&#x5E73;&#x53F0;&#x4E0A;&#x5F9E;&#x672A;&#x7522;&#x751F;&#x3001;&#x5132;&#x5B58;&#x904E;&#x4EFB;&#x4F55;&#x88F8;&#x7167;&#x3002;&#x6B64;&#x985E;&#x4E0D;&#x96C5;&#x7167;&#xFF0C;&#x70BA;&#x5C11;&#x6578;&#x7528;&#x6236;&#x8207;&#x7B2C;&#x4E09;&#x65B9;&#x4E0D;&#x6B63;&#x898F;&#x501F;&#x8CB8;&#x516C;&#x53F8;&#x6216;&#x653E;&#x8CB8;&#x4EBA;&#xFF0C;&#x79C1;&#x4E0B;&#x4EA4;&#x6613;&#x800C;&#x7522;&#x751F;&#x3002;&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x53C8;&#x6307;&#xFF0C;&#x90E8;&#x5206;&#x7528;&#x6236;&#x56E0;&#x6025;&#x65BC;&#x501F;&#x9322;&#xFF0C;&#x7E5E;&#x904E;&#x5E73;&#x53F0;&#x898F;&#x5247;&#x7684;&#x9650;&#x5236;&#x548C;&#x76E3;&#x7763;&#xFF0C;&#x901A;&#x904E;QQ&#x3001;&#x5FAE;&#x4FE1;&#x7B49;&#x6E20;&#x9053;&#xFF0C;&#x4EE5;&#x62BC;&#x300C;&#x88F8;&#x7167;&#x300D;&#x70BA;&#x689D;&#x4EF6;&#x9032;&#x200B;&#x200B;&#x884C;&#x501F;&#x8CB8;&#xFF0C;&#x76F8;&#x95DC;&#x4E0D;&#x96C5;&#x7167;&#x7247;&#x7686;&#x901A;&#x904E;QQ&#x3001;&#x5FAE;&#x4FE1;&#x3001;&#x77ED;&#x4FE1;&#x7B49;&#x6E20;&#x9053;&#x6D41;&#x50B3;&#x3002;&#x6B64;&#x985E;&#x884C;&#x70BA;&#xFF0C;&#x662F;&#x85C9;&#x8CB8;&#x5BF6;&#x5E73;&#x53F0;&#x4E00;&#x8CAB;&#x9AD8;&#x5EA6;&#x91CD;&#x8996;&#x4E26;&#x56B4;&#x53B2;&#x6253;&#x64CA;&#x7684;&#x3002;\r\n                    <br>&#x516C;&#x53F8;&#x6CD5;&#x52D9;&#x90E8;&#x9580;&#x5DF2;&#x7D93;&#x6536;&#x96C6;&#x76F8;&#x95DC;&#x8B49;&#x64DA;&#xFF0C;&#x4E26;&#x5DF2;&#x5411;&#x516C;&#x5B89;&#x6A5F;&#x95DC;&#x5831;&#x6848;&#xFF0C;&#x5C07;&#x63A1;&#x7528;&#x6CD5;&#x5F8B;&#x624B;&#x6BB5;&#x56B4;&#x53B2;&#x6253;&#x64CA;&#x300C;&#x88F8;&#x7167;&#x300D;&#x653E;&#x8CB8;&#x8005;&#x548C;&#x60E1;&#x610F;&#x50B3;&#x64AD;&#x6DEB;&#x7A62;&#x7167;&#x7247;&#x7684;&#x76F8;&#x95DC;&#x8CAC;&#x4EFB;&#x4EBA;&#x3002;",
            "date": "28日",
            "gender": "male",
            "images": [
              "http://static.apple.nextmedia.com/images/e-paper/20161201/large/1480571640_42d3.jpg"
            ],
            "replyId": "1"
          },
          {
            "author": "hellhi",
            "content": "\r\n                    &#x6BCF;&#x6B21;&#x5462;&#x7A2E;&#x7DB2;&#x7D61;&#x760B;&#x50B3;&#x90FD;&#x7121;&#x9AD8;&#x767B;&#x4EFD;",
            "date": "28日",
            "gender": "female",
            "images": [],
            "replyId": "258507313"
          },
          {
            "author": "流液稀",
            "content": "\r\n                10GB<img src=\"http://m3.hkgolden.com/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507340"
          },
          {
            "author": "健Sir~",
            "content": "\r\n                &#x7559;&#x540D;",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507368"
          },
          {
            "author": "學友社",
            "content": "\r\n                Seed&#x5462;",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507371"
          },
          {
            "author": "兵工廠拍金",
            "content": "\r\n            &#x5C31;&#x7B97;&#x4F60;&#x6E96;&#x6642;&#x9084;&#x9322;, &#x5C0D;&#x65B9;&#x90FD;&#x5BE6;&#x6703;KEEP &#x4F4F;&#x500B;COPY, &#x5514;&#x660E;&#x9EDE;&#x89E3;&#x6709;&#x4EBA;&#x80AF;",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507374"
          },
          {
            "author": "岸明日香",
            "content": "\r\n            &#x5F37;&#x570B;&#x5341;&#x5E7E;&#x5104;&#x4EBA;\r\n            <br>&#x5168;&#x88F8;+&#x8EAB;&#x4EFD;&#x8B49;&#x505A;&#x62B5;&#x62BC;&#x7A76;&#x7ADF;&#x6709;&#x54A9;&#x5F71;&#x97FF;&#x529B;?\r\n            <br>&#x5481;&#x6613;&#x50B3;&#x5F97;&#x8FD4;&#x53BB;&#x8A72;&#x7701;&#x5E02;&#x5531;&#x689D;&#x5973; &#x5C31;&#x5514;&#x6703;&#x5481;&#x591A;&#x5916;&#x7701;&#x4EBA;&#x53BB;&#x5EE3;&#x6771;&#x505A;&#x96DE;&#x5566;\r\n            <br>\r\n            <br>&#x5176;&#x5BE6;&#x5373;&#x4FC2;&#x4FFE;&#x9322;&#x7747;j&#x5716; (&#x524D;&#x984C;&#x4FC2;&#x597D;j)\r\n            <br>&#x6536;&#x5F97;&#x8FD4;&#x672C;&#x91D1;&#x7576;bonus",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507416"
          },
          {
            "author": "manaman",
            "content": "\r\n            <img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" show=\"0\" alt=\"[img]&#x5716;&#x7247;&#x7DB2;&#x5740;[/img]\" ng-src=\"&#x5716;&#x7247;&#x7DB2;&#x5740;\">",
            "date": "28日",
            "gender": "male",
            "images": [
              "圖片網址"
            ],
            "replyId": "258507443"
          },
          {
            "author": "扭波王(已切)",
            "content": "\r\n            10 GB <img src=\"http://m3.hkgolden.com/faces/tongue.gif\" alt=\":P\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507532"
          },
          {
            "author": "六合狂徒",
            "content": "\r\n            <blockquote>10 GB <img src=\"http://m3.hkgolden.com/faces/tongue.gif\" alt=\":P\" border=\"0\"></blockquote><br><br>&#x4F46;&#x4FC2;&#x6C38;&#x9060;&#x5187;&#x9AD8;&#x767B;&#x4EFD;<img src=\"http://m3.hkgolden.com/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507746"
          },
          {
            "author": "揭示板",
            "content": "\r\n            &#x50B3;<img src=\"http://m3.hkgolden.com/faces/clown.gif\" alt=\":o)\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507782"
          },
          {
            "author": "DAOSHI116",
            "content": "\r\n            &#x7559;&#x540D;",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507823"
          },
          {
            "author": "富二代",
            "content": "\r\n            &#x7559;&#x540D;&#x7B49;&#x670B;&#x53CB;<img src=\"http://m3.hkgolden.com/faces/lomore/tongue.gif\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507868"
          },
          {
            "author": "高登論",
            "content": "\r\n            <img src=\"http://m3.hkgolden.com/faces/bouncer.gif\" alt=\"[bouncer]\" border=\"0\"><img src=\"http://m3.hkgolden.com/faces/bouncer.gif\" alt=\"[bouncer]\" border=\"0\"><img src=\"http://m3.hkgolden.com/faces/bouncer.gif\" alt=\"[bouncer]\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507882"
          },
          {
            "author": "屯門毒jj",
            "content": "\r\n            <blockquote>&#x7559;&#x540D;&#x7B49;&#x670B;&#x53CB;<img src=\"http://m3.hkgolden.com/faces/lomore/tongue.gif\" border=\"0\"></blockquote><br>&#x81EA;&#x5DF1;google &quot;&#x88F8;&#x689D;&#x9580;&quot;<img src=\"http://m3.hkgolden.com/faces/angel.gif\" alt=\"O:-)\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258507976"
          },
          {
            "author": "鐸叔",
            "content": "\r\n            <img src=\"http://m3.hkgolden.com/faces/dead.gif\" alt=\"xx(\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508115"
          },
          {
            "author": "DGCNYO",
            "content": "\r\n            10GB 1080P&#x7247;&#x90FD;&#x6210;&#x5E7E;&#x500B;&#x9418;....<img src=\"http://m3.hkgolden.com/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508146"
          },
          {
            "author": "抽昨",
            "content": "\r\n            &#x4E00;&#x9375;&#x7559;&#x540D;&#x5F85;&#x4E01;&#x5927;&#x4E0D;&#x81F3;",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508201"
          },
          {
            "author": "胸圍店女店長",
            "content": "\r\n            Xboxone Contana&#x7559;&#x540D;&#x7CFB;&#x7D71;&#x555F;&#x52D5; &#x8ACB;&#x52FF;&#x56DE;&#x8986;&#x3002;",
            "date": "28日",
            "gender": "female",
            "images": [],
            "replyId": "258508240"
          },
          {
            "author": "艾菲爾學生",
            "content": "\r\n            &#x53C8;&#x5187;&#x9AD8;&#x767B;&#x4EFD;",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508310"
          },
          {
            "author": "離地毒撚",
            "content": "\r\n            <blockquote><blockquote>&#x7559;&#x540D;&#x7B49;&#x670B;&#x53CB;<img src=\"http://m3.hkgolden.com/faces/lomore/tongue.gif\" border=\"0\"></blockquote>\r\n                <br>&#x81EA;&#x5DF1;google &quot;&#x88F8;&#x689D;&#x9580;&quot;<img src=\"http://m3.hkgolden.com/faces/angel.gif\" alt=\"O:-)\" border=\"0\"></blockquote>\r\n            <br>&#x6435;&#x5514;&#x5230;link down<img src=\"http://m3.hkgolden.com/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508399"
          },
          {
            "author": "正氣師",
            "content": "\r\n            &#x7559;&#x540D;",
            "date": "28日",
            "gender": "female",
            "images": [],
            "replyId": "258508416"
          },
          {
            "author": "[email protected]/* <![CDATA[ */!function(t,e,r,n,c,a,p){try{t=document.currentScript||function(){for(t=document.getElementsByTagName('script'),e=t.length;e--;)if(t[e].getAttribute('data-cfhash'))return t[e]}();if(t&&(c=t.previousSibling)){p=t.parentNode;if(a=c.getAttribute('data-cfemail')){for(e='',r='0x'+a.substr(0,2)|0,n=2;a.length-n;n+=2)e+='%'+('0'+('0x'+a.substr(n,2)^r).toString(16)).slice(-2);p.replaceChild(document.createTextNode(decodeURIComponent(e)),c)}p.removeChild(t)}}catch(u){}}()/* ]]> */",
            "content": "\r\n            <img src=\"http://m3.hkgolden.com/faces/kiss.gif\" alt=\"^3^\" border=\"0\">",
            "date": "28日",
            "gender": "female",
            "images": [],
            "replyId": "258508448"
          },
          {
            "author": "大腿張開",
            "content": "\r\n            <blockquote>&#x6BCF;&#x6B21;&#x5462;&#x7A2E;&#x7DB2;&#x7D61;&#x760B;&#x50B3;&#x90FD;&#x7121;&#x9AD8;&#x767B;&#x4EFD;</blockquote><br>Agger<img src=\"http://m3.hkgolden.com/faces/dead.gif\" alt=\"xx(\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508464"
          },
          {
            "author": "屯門毒jj",
            "content": "\r\n            &#x6211;&#x4E4B;&#x524D;down&#x5497;&#x843D;&#x9ECE;&#x4F46;del&#x5497;&#x90E8;&#x4EFD;&#x6A23;&#x8870;&#x5514;&#x597D;j&#x5605;",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508470"
          },
          {
            "author": "Alex_Hunter",
            "content": "\r\n            <blockquote>&#x6211;&#x4E4B;&#x524D;down&#x5DE6;&#x843D;&#x9ECE;&#x4F46;del&#x5DE6;&#x90E8;&#x4EFD;&#x6A23;&#x8870;&#x5514;&#x597D;jo&#x65E2;</blockquote><br>&#x671B;&#x4F60;&#x80FD;&#x76E1;&#x5FEB;&#x6551;&#x4F2F;&#x6BCD;<img src=\"http://m3.hkgolden.com/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
            "date": "28日",
            "gender": "male",
            "images": [],
            "replyId": "258508578"
          }
        ]
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 9
        expected.title = '內地女學生網上借貸 傳10GB「裸照」抵押品流出'
        test.deepEqual result, expected
        test.done()

  'test parse thread without preprocessor': (test) ->

    parser = require '../index'
    mobileGoldenParser = new parser.MobileGoldenParser({
      contentPreprocessors: []
    })

    fs.readFile './test/viewFixtures/thread.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseThread data, (result) ->
        expected =
          [
            {
              "author": "B頭佬III",
              "content": "<img class=\"Image\" src=\"/images/mobile/camera.png\" onclick=\"javascript: ViewImage(this, &#x27;http://static.apple.nextmedia.com/images/e-paper/20161201/large/1480571640_42d3.jpg&#x27;)\" show=\"0\" alt=\"[img]http://static.apple.nextmedia.com/images/e-paper/20161201/large/1480571640_42d3.jpg[/img]\">\r\n                    <br>\r\n                    <br>&#x5167;&#x5730;&#x8FD1;&#x5E74;&#x6709;&#x4E0D;&#x5C11;&#x7DB2;&#x7D61;&#x91D1;&#x878D;&#x793E;&#x4EA4;&#x5E73;&#x53F0;&#xFF0C;&#x66F4;&#x65E9;&#x5DF2;&#x5165;&#x4FB5;&#x5167;&#x5730;&#x6821;&#x5712;&#x3002;&#x6709;&#x501F;&#x65B9;&#x56E0;&#x6015;&#x5973;&#x5B78;&#x751F;&#x5C07;&#x4F86;&#x672A;&#x80FD;&#x9084;&#x6B3E;&#xFF0C;&#x8981;&#x6C42;&#x5973;&#x5B78;&#x751F;&#x5148;&#x62CD;&#x88F8;&#x7167;&#x6216;&#x5F71;&#x7247;&#x4F5C;&#x300C;&#x62B5;&#x62BC;&#x300D;&#x3002;\r\n                    <br>\r\n                    <br>&#x6628;&#x65E5;&#x5167;&#x5730;&#x5831;&#x9053;&#xFF0C;&#x5176;&#x4E2D;&#x4E00;&#x820D;&#x5E73;&#x53F0;&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x6D41;&#x51FA;&#x4E0D;&#x5C11;&#x5973;&#x5B78;&#x751F;&#x88F8;&#x7167;&#x6216;&#x5F71;&#x7247;&#xFF0C;&#x5BB9;&#x91CF;&#x591A;&#x9054;10GB&#x3002;&#x501F;&#x6B3E;&#x7684;&#x5973;&#x5B50;&#xFF0C;&#x5927;&#x90E8;&#x5206;&#x65BC;1993&#x81F3;1997&#x5E74;&#x51FA;&#x751F;&#xFF0C;&#x4E5F;&#x6709;&#x500B;&#x5225;1981&#x5E74;&#x3001;1982&#x5E74;&#x3002;&#x5831;&#x9053;&#x6307;&#xFF0C;&#x501F;&#x9322;&#x7684;&#x689D;&#x4EF6;&#x4E0D;&#x55AE;&#x662F;&#x5F71;&#x88F8;&#x7167;&#xFF0C;&#x751A;&#x81F3;&#x8981;&#x88F8;&#x804A;&#x3002;\r\n                    <br>&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x5B98;&#x65B9;&#x5C31;&#x6B64;&#x5426;&#x8A8D;&#xFF0C;&#x6307;&#x660E;&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x6839;&#x672C;&#x4E0D;&#x63D0;&#x4F9B;&#x7167;&#x7247;&#x50B3;&#x9001;&#x529F;&#x80FD;&#xFF0C;&#x5E73;&#x53F0;&#x4E0A;&#x5F9E;&#x672A;&#x7522;&#x751F;&#x3001;&#x5132;&#x5B58;&#x904E;&#x4EFB;&#x4F55;&#x88F8;&#x7167;&#x3002;&#x6B64;&#x985E;&#x4E0D;&#x96C5;&#x7167;&#xFF0C;&#x70BA;&#x5C11;&#x6578;&#x7528;&#x6236;&#x8207;&#x7B2C;&#x4E09;&#x65B9;&#x4E0D;&#x6B63;&#x898F;&#x501F;&#x8CB8;&#x516C;&#x53F8;&#x6216;&#x653E;&#x8CB8;&#x4EBA;&#xFF0C;&#x79C1;&#x4E0B;&#x4EA4;&#x6613;&#x800C;&#x7522;&#x751F;&#x3002;&#x300C;&#x501F;&#x8CB8;&#x5BF6;&#x300D;&#x53C8;&#x6307;&#xFF0C;&#x90E8;&#x5206;&#x7528;&#x6236;&#x56E0;&#x6025;&#x65BC;&#x501F;&#x9322;&#xFF0C;&#x7E5E;&#x904E;&#x5E73;&#x53F0;&#x898F;&#x5247;&#x7684;&#x9650;&#x5236;&#x548C;&#x76E3;&#x7763;&#xFF0C;&#x901A;&#x904E;QQ&#x3001;&#x5FAE;&#x4FE1;&#x7B49;&#x6E20;&#x9053;&#xFF0C;&#x4EE5;&#x62BC;&#x300C;&#x88F8;&#x7167;&#x300D;&#x70BA;&#x689D;&#x4EF6;&#x9032;&#x200B;&#x200B;&#x884C;&#x501F;&#x8CB8;&#xFF0C;&#x76F8;&#x95DC;&#x4E0D;&#x96C5;&#x7167;&#x7247;&#x7686;&#x901A;&#x904E;QQ&#x3001;&#x5FAE;&#x4FE1;&#x3001;&#x77ED;&#x4FE1;&#x7B49;&#x6E20;&#x9053;&#x6D41;&#x50B3;&#x3002;&#x6B64;&#x985E;&#x884C;&#x70BA;&#xFF0C;&#x662F;&#x85C9;&#x8CB8;&#x5BF6;&#x5E73;&#x53F0;&#x4E00;&#x8CAB;&#x9AD8;&#x5EA6;&#x91CD;&#x8996;&#x4E26;&#x56B4;&#x53B2;&#x6253;&#x64CA;&#x7684;&#x3002;\r\n                    <br>&#x516C;&#x53F8;&#x6CD5;&#x52D9;&#x90E8;&#x9580;&#x5DF2;&#x7D93;&#x6536;&#x96C6;&#x76F8;&#x95DC;&#x8B49;&#x64DA;&#xFF0C;&#x4E26;&#x5DF2;&#x5411;&#x516C;&#x5B89;&#x6A5F;&#x95DC;&#x5831;&#x6848;&#xFF0C;&#x5C07;&#x63A1;&#x7528;&#x6CD5;&#x5F8B;&#x624B;&#x6BB5;&#x56B4;&#x53B2;&#x6253;&#x64CA;&#x300C;&#x88F8;&#x7167;&#x300D;&#x653E;&#x8CB8;&#x8005;&#x548C;&#x60E1;&#x610F;&#x50B3;&#x64AD;&#x6DEB;&#x7A62;&#x7167;&#x7247;&#x7684;&#x76F8;&#x95DC;&#x8CAC;&#x4EFB;&#x4EBA;&#x3002;",
              "date": "28日",
              "gender": "male",
              "images": [
                "http://static.apple.nextmedia.com/images/e-paper/20161201/large/1480571640_42d3.jpg"
              ],
              "replyId": "1"
            },
            {
              "author": "hellhi",
              "content": "\r\n                    &#x6BCF;&#x6B21;&#x5462;&#x7A2E;&#x7DB2;&#x7D61;&#x760B;&#x50B3;&#x90FD;&#x7121;&#x9AD8;&#x767B;&#x4EFD;",
              "date": "28日",
              "gender": "female",
              "images": [],
              "replyId": "258507313"
            },
            {
              "author": "流液稀",
              "content": "\r\n                10GB<img src=\"/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507340"
            },
            {
              "author": "健Sir~",
              "content": "\r\n                &#x7559;&#x540D;",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507368"
            },
            {
              "author": "學友社",
              "content": "\r\n                Seed&#x5462;",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507371"
            },
            {
              "author": "兵工廠拍金",
              "content": "\r\n            &#x5C31;&#x7B97;&#x4F60;&#x6E96;&#x6642;&#x9084;&#x9322;, &#x5C0D;&#x65B9;&#x90FD;&#x5BE6;&#x6703;KEEP &#x4F4F;&#x500B;COPY, &#x5514;&#x660E;&#x9EDE;&#x89E3;&#x6709;&#x4EBA;&#x80AF;",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507374"
            },
            {
              "author": "岸明日香",
              "content": "\r\n            &#x5F37;&#x570B;&#x5341;&#x5E7E;&#x5104;&#x4EBA;\r\n            <br>&#x5168;&#x88F8;+&#x8EAB;&#x4EFD;&#x8B49;&#x505A;&#x62B5;&#x62BC;&#x7A76;&#x7ADF;&#x6709;&#x54A9;&#x5F71;&#x97FF;&#x529B;?\r\n            <br>&#x5481;&#x6613;&#x50B3;&#x5F97;&#x8FD4;&#x53BB;&#x8A72;&#x7701;&#x5E02;&#x5531;&#x689D;&#x5973; &#x5C31;&#x5514;&#x6703;&#x5481;&#x591A;&#x5916;&#x7701;&#x4EBA;&#x53BB;&#x5EE3;&#x6771;&#x505A;&#x96DE;&#x5566;\r\n            <br>\r\n            <br>&#x5176;&#x5BE6;&#x5373;&#x4FC2;&#x4FFE;&#x9322;&#x7747;j&#x5716; (&#x524D;&#x984C;&#x4FC2;&#x597D;j)\r\n            <br>&#x6536;&#x5F97;&#x8FD4;&#x672C;&#x91D1;&#x7576;bonus",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507416"
            },
            {
              "author": "manaman",
              "content": "\r\n            <img class=\"Image\" src=\"/images/mobile/camera.png\" onclick=\"javascript: ViewImage(this, &#x27;&#x5716;&#x7247;&#x7DB2;&#x5740;&#x27;)\" show=\"0\" alt=\"[img]&#x5716;&#x7247;&#x7DB2;&#x5740;[/img]\">",
              "date": "28日",
              "gender": "male",
              "images": [
                "圖片網址"
              ],
              "replyId": "258507443"
            },
            {
              "author": "扭波王(已切)",
              "content": "\r\n            10 GB <img src=\"/faces/tongue.gif\" alt=\":P\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507532"
            },
            {
              "author": "六合狂徒",
              "content": "\r\n            <blockquote>10 GB <img src=\"/faces/tongue.gif\" alt=\":P\" border=\"0\"></blockquote><br><br>&#x4F46;&#x4FC2;&#x6C38;&#x9060;&#x5187;&#x9AD8;&#x767B;&#x4EFD;<img src=\"/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507746"
            },
            {
              "author": "揭示板",
              "content": "\r\n            &#x50B3;<img src=\"/faces/clown.gif\" alt=\":o)\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507782"
            },
            {
              "author": "DAOSHI116",
              "content": "\r\n            &#x7559;&#x540D;",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507823"
            },
            {
              "author": "富二代",
              "content": "\r\n            &#x7559;&#x540D;&#x7B49;&#x670B;&#x53CB;<img src=\"/faces/lomore/tongue.gif\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507868"
            },
            {
              "author": "高登論",
              "content": "\r\n            <img src=\"/faces/bouncer.gif\" alt=\"[bouncer]\" border=\"0\"><img src=\"/faces/bouncer.gif\" alt=\"[bouncer]\" border=\"0\"><img src=\"/faces/bouncer.gif\" alt=\"[bouncer]\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507882"
            },
            {
              "author": "屯門毒jj",
              "content": "\r\n            <blockquote>&#x7559;&#x540D;&#x7B49;&#x670B;&#x53CB;<img src=\"/faces/lomore/tongue.gif\" border=\"0\"></blockquote><br>&#x81EA;&#x5DF1;google &quot;&#x88F8;&#x689D;&#x9580;&quot;<img src=\"/faces/angel.gif\" alt=\"O:-)\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258507976"
            },
            {
              "author": "鐸叔",
              "content": "\r\n            <img src=\"/faces/dead.gif\" alt=\"xx(\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508115"
            },
            {
              "author": "DGCNYO",
              "content": "\r\n            10GB 1080P&#x7247;&#x90FD;&#x6210;&#x5E7E;&#x500B;&#x9418;....<img src=\"/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508146"
            },
            {
              "author": "抽昨",
              "content": "\r\n            &#x4E00;&#x9375;&#x7559;&#x540D;&#x5F85;&#x4E01;&#x5927;&#x4E0D;&#x81F3;",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508201"
            },
            {
              "author": "胸圍店女店長",
              "content": "\r\n            Xboxone Contana&#x7559;&#x540D;&#x7CFB;&#x7D71;&#x555F;&#x52D5; &#x8ACB;&#x52FF;&#x56DE;&#x8986;&#x3002;",
              "date": "28日",
              "gender": "female",
              "images": [],
              "replyId": "258508240"
            },
            {
              "author": "艾菲爾學生",
              "content": "\r\n            &#x53C8;&#x5187;&#x9AD8;&#x767B;&#x4EFD;",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508310"
            },
            {
              "author": "離地毒撚",
              "content": "\r\n            <blockquote><blockquote>&#x7559;&#x540D;&#x7B49;&#x670B;&#x53CB;<img src=\"/faces/lomore/tongue.gif\" border=\"0\"></blockquote>\r\n                <br>&#x81EA;&#x5DF1;google &quot;&#x88F8;&#x689D;&#x9580;&quot;<img src=\"/faces/angel.gif\" alt=\"O:-)\" border=\"0\"></blockquote>\r\n            <br>&#x6435;&#x5514;&#x5230;link down<img src=\"/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508399"
            },
            {
              "author": "正氣師",
              "content": "\r\n            &#x7559;&#x540D;",
              "date": "28日",
              "gender": "female",
              "images": [],
              "replyId": "258508416"
            },
            {
              "author": "[email protected]/* <![CDATA[ */!function(t,e,r,n,c,a,p){try{t=document.currentScript||function(){for(t=document.getElementsByTagName('script'),e=t.length;e--;)if(t[e].getAttribute('data-cfhash'))return t[e]}();if(t&&(c=t.previousSibling)){p=t.parentNode;if(a=c.getAttribute('data-cfemail')){for(e='',r='0x'+a.substr(0,2)|0,n=2;a.length-n;n+=2)e+='%'+('0'+('0x'+a.substr(n,2)^r).toString(16)).slice(-2);p.replaceChild(document.createTextNode(decodeURIComponent(e)),c)}p.removeChild(t)}}catch(u){}}()/* ]]> */",
              "content": "\r\n            <img src=\"/faces/kiss.gif\" alt=\"^3^\" border=\"0\">",
              "date": "28日",
              "gender": "female",
              "images": [],
              "replyId": "258508448"
            },
            {
              "author": "大腿張開",
              "content": "\r\n            <blockquote>&#x6BCF;&#x6B21;&#x5462;&#x7A2E;&#x7DB2;&#x7D61;&#x760B;&#x50B3;&#x90FD;&#x7121;&#x9AD8;&#x767B;&#x4EFD;</blockquote><br>Agger<img src=\"/faces/dead.gif\" alt=\"xx(\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508464"
            },
            {
              "author": "屯門毒jj",
              "content": "\r\n            &#x6211;&#x4E4B;&#x524D;down&#x5497;&#x843D;&#x9ECE;&#x4F46;del&#x5497;&#x90E8;&#x4EFD;&#x6A23;&#x8870;&#x5514;&#x597D;j&#x5605;",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508470"
            },
            {
              "author": "Alex_Hunter",
              "content": "\r\n            <blockquote>&#x6211;&#x4E4B;&#x524D;down&#x5DE6;&#x843D;&#x9ECE;&#x4F46;del&#x5DE6;&#x90E8;&#x4EFD;&#x6A23;&#x8870;&#x5514;&#x597D;jo&#x65E2;</blockquote><br>&#x671B;&#x4F60;&#x80FD;&#x76E1;&#x5FEB;&#x6551;&#x4F2F;&#x6BCD;<img src=\"/faces/sosad.gif\" alt=\"[sosad]\" border=\"0\">",
              "date": "28日",
              "gender": "male",
              "images": [],
              "replyId": "258508578"
            }
          ]
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 9
        expected.title = '內地女學生網上借貸 傳10GB「裸照」抵押品流出'
        test.deepEqual result, expected
        test.done()

  'test parse thread with custom preprocessor': (test) ->

    parser = require '../index'
    cheerio = require('cheerio')
    mobileGoldenParser = new parser.MobileGoldenParser({
      contentPreprocessors: [{
        preprocess: (ele) ->
          $ = cheerio.load(ele)
          $(ele).empty()
      }]
    })

    fs.readFile './test/viewFixtures/thread.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseThread data, (result) ->

        expected = []
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 9
        expected.title = '內地女學生網上借貸 傳10GB「裸照」抵押品流出'
        test.deepEqual result, expected
        test.done()

  'test parse thread with multiple preprocessor': (test) ->

    parser = require '../index'
    cheerio = require('cheerio')
    test.expect 28
    mobileGoldenParser = new parser.MobileGoldenParser({
      contentPreprocessors: [{
        preprocess: (ele) ->
          $ = cheerio.load(ele)
          $(ele).empty();
      }, {
        preprocess: (ele) ->
          test.ok(true);
      }]
    })

    fs.readFile './test/viewFixtures/thread.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseThread data, (result) ->

        expected = []
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 9
        expected.title = '內地女學生網上借貸 傳10GB「裸照」抵押品流出'
        test.deepEqual result, expected
        test.done()

  'test parse thread with custom preprocessor as function': (test) ->

    parser = require '../index'
    cheerio = require('cheerio')
    mobileGoldenParser = new parser.MobileGoldenParser({
      contentPreprocessors: [(ele) ->
          $ = cheerio.load(ele)
          $(ele).empty()
        ]
    })

    fs.readFile './test/viewFixtures/thread.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseThread data, (result) ->

        expected = []
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 9
        expected.title = '內地女學生網上借貸 傳10GB「裸照」抵押品流出'
        test.deepEqual result, expected
        test.done()

  'test parse types': (test) ->
    parser = require '../index'
    mobileGoldenParser = new parser.MobileGoldenParser()
    fs.readFile './test/viewFixtures/types.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseTypes data, (result) ->
        expected = {
        types: [
          {
            "key": "BW",
            "name": "吹水台"
          },
          {
            "key": "HT",
            "name": "熱 門"
          },
          {
            "key": "ET",
            "name": "娛樂台"
          },
          {
            "key": "CA",
            "name": "時事台"
          },
          {
            "key": "FN",
            "name": "財經台"
          },
          {
            "key": "GM",
            "name": "遊戲台"
          },
          {
            "key": "HW",
            "name": "硬件台"
          },
          {
            "key": "IN",
            "name": "電訊台"
          },
          {
            "key": "SW",
            "name": "軟件台"
          },
          {
            "key": "MP",
            "name": "手機台"
          },
          {
            "key": "AP",
            "name": "APPs台"
          },
          {
            "key": "SP",
            "name": "體育台"
          },
          {
            "key": "LV",
            "name": "感情台"
          },
          {
            "key": "SY",
            "name": "講故台"
          },
          {
            "key": "ED",
            "name": "飲食台"
          },
          {
            "key": "BB",
            "name": "親子台"
          },
          {
            "key": "PT",
            "name": "寵物台"
          },
          {
            "key": "TR",
            "name": "旅遊台"
          },
          {
            "key": "CO",
            "name": "潮流台"
          },
          {
            "key": "AN",
            "name": "動漫台"
          },
          {
            "key": "TO",
            "name": "玩具台"
          },
          {
            "key": "MU",
            "name": "音樂台"
          },
          {
            "key": "VI",
            "name": "影視台"
          },
          {
            "key": "DC",
            "name": "攝影台"
          },
          {
            "key": "ST",
            "name": "學術台"
          },
          {
            "key": "SC",
            "name": "校園台"
          },
          {
            "key": "WK",
            "name": "上班台"
          },
          {
            "key": "TS",
            "name": "汽車台"
          },
          {
            "key": "RA",
            "name": "電  台"
          },
          {
            "key": "AU",
            "name": "成人台"
          },
          {
            "key": "MB",
            "name": "站務台"
          },
          {
            "key": "AC",
            "name": "活動台"
          },
          {
            "key": "JT",
            "name": "直播台"
          },
          {
            "key": "EP",
            "name": "創意台"
          }
        ]}
        test.deepEqual result, expected
        test.done()