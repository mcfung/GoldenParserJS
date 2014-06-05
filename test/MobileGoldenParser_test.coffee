parser = require '../index'
mobileGoldenParser = new parser.MobileGoldenParser()

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
    fs.readFile './test/viewFixtures/topics.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseTopicList data, (topics) ->
        expected = [
          {
            author: '企鵝牧場'
            rating: 0
            title: '[AN/iOS] Divine Gate [70] 10抽8八舞'
            messageId: '5158533'
            totalNumberOfPage: 15
            numberOfReplies: 359
          }
          {
            author: '猩猩伴我行'
            rating: 1,
            title: '好悶 玩下古典占星'
            messageId: '5159835'
            totalNumberOfPage: 4
            numberOfReplies: 92
          }
        ]
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 640
        test.deepEqual topics, expected
        test.done()

  'test parse thread': (test) ->
    fs.readFile './test/viewFixtures/thread.html', {
      encoding: 'utf8'
    }, (err, data) ->
      test.ifError err
      mobileGoldenParser.parseThread data, (result) ->
        expected =
          [
            {
              "author": "有客到",
              "gender": "male",
              "content": "&#x99AC;&#x62C9;&#x5973;&#x6B63;&#x5230;&#x558A; &#x767D; &#x6ED1; &#x9577;&#x817F; Pure <img src=\"http://m3.hkgolden.com/faces/tongue.gif\" alt=\":P\" border=\"0\">\r<br>&#x500B;&#x500B;&#x6BCD;&#x8A9E;&#x90FD;&#x4FC2;&#x6709;&#x82F1;&#x6587;&#x4EFD; &#x6D17;&#x649A;&#x98DF;D&#x507D;ABC&#x6E2F;&#x5973;&#x54A9;<img src=\"http://m3.hkgolden.com/faces/dead.gif\" alt=\"xx(\" border=\"0\"> \r<br>&#x8A8D;&#x70BA;&#x6211;&#x4FC2;&#x6253;&#x624B;&#x5C31;&#x51FA;&#x8FD4;&#x53BB; &#x60F3;&#x7747;&#x6B63;&#x91CE;&#x5C31;&#x62C9;&#x843D;&#x53BB;<img src=\"http://m3.hkgolden.com/faces/agree.gif\" alt=\"#yup#\" border=\"0\"> \r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>\r<br>here<img src=\"http://m3.hkgolden.com/faces/agree.gif\" alt=\"#yup#\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/agree.gif\" alt=\"#yup#\" border=\"0\"> \r<br>\r<br>1.\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10169234_640396919383811_1975478740390909431_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10169234_640396919383811_1975478740390909431_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10014632_608509762572527_1008327956_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10014632_608509762572527_1008327956_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://scontent-b-kul.xx.fbcdn.net/hphotos-xpf1/t1.0-9/1925160_605400672883436_1094390485_n.jpg[/img]\" ng-src=\"https://scontent-b-kul.xx.fbcdn.net/hphotos-xpf1/t1.0-9/1925160_605400672883436_1094390485_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1456782_602015593221944_218243344_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1456782_602015593221944_218243344_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1796592_599365176820319_1714701013_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1796592_599365176820319_1714701013_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1239622_508976229192548_1928333367_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1239622_508976229192548_1928333367_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/10308803_636868833069953_378371863153312182_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/10308803_636868833069953_378371863153312182_n.jpg\">\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1900166_593683997388437_800482416_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1900166_593683997388437_800482416_n.jpg\">\r<br><span style=\"font-size: large;\"><!--start size-->[red]instagram: stellalalav / Facebook:Stella Chen[/red<!--end size[4]--></span>]",
              "images": [
                "https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10169234_640396919383811_1975478740390909431_n.jpg",
                "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10014632_608509762572527_1008327956_n.jpg",
                "https://scontent-b-kul.xx.fbcdn.net/hphotos-xpf1/t1.0-9/1925160_605400672883436_1094390485_n.jpg",
                "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1456782_602015593221944_218243344_n.jpg",
                "https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xfa1/t1.0-9/1796592_599365176820319_1714701013_n.jpg",
                "https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1239622_508976229192548_1928333367_n.jpg",
                "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/10308803_636868833069953_378371863153312182_n.jpg",
                "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1900166_593683997388437_800482416_n.jpg"
              ],
              "date": "6/3/2014 1:02 AM"
            },
            {
              "author": "有客到",
              "gender": "male",
              "content": "2.\r<br>&#x4F9D;&#x500B;&#x771F;&#x4FC2;J&#x51FA;&#x5716;&#x6A23;&#x751C;&#x8072;&#x751C;\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1013318_607113646043067_1538246468_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1013318_607113646043067_1538246468_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/10366284_661600113927753_2533615088426117483_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/10366284_661600113927753_2533615088426117483_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://scontent-a-kul.xx.fbcdn.net/hphotos-xfp1/t1.0-9/10419062_660269964060768_3580564822159980358_n.jpg[/img]\" ng-src=\"https://scontent-a-kul.xx.fbcdn.net/hphotos-xfp1/t1.0-9/10419062_660269964060768_3580564822159980358_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10262024_649021008518997_7458572545891315654_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10262024_649021008518997_7458572545891315654_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/10356421_656859197735178_6128256979438771714_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/10356421_656859197735178_6128256979438771714_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10396299_656374917783606_2430995906127998515_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10396299_656374917783606_2430995906127998515_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/1901685_620220984732333_399372437_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/1901685_620220984732333_399372437_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/10276004_649368515150913_950882928561629018_n.jpg[/img]\" ng-src=\"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/10276004_649368515150913_950882928561629018_n.jpg\">\r<br>\r<br><img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]http://photos-c.ak.instagram.com/hphotos-ak-xfp1/1170306_232844430210130_691814086_n.jpg[/img]\" ng-src=\"http://photos-c.ak.instagram.com/hphotos-ak-xfp1/1170306_232844430210130_691814086_n.jpg\">\r<br><span style=\"font-size: large;\"><!--start size--><span style=\"color: red;\">instagram:thecloverjoys Facebook:&#x56DB;&#x8449;&#x8349;</span><!--end size[4]--></span>\r<br>\r<br><span style=\"font-size: medium;\"><!--start size-->&#x4E00;&#x500B;97&#x4E00;&#x500B;96&#x771F;&#x4FC2;&#x6709;&#x6251;&#x6251;&#x8DA3; <img src=\"http://m3.hkgolden.com/faces/tongue.gif\" alt=\":P\" border=\"0\"> \r<br>&#x73A9;&#x8173;&#x90FD;&#x6709;&#x6392;&#x73A9;<img src=\"http://m3.hkgolden.com/faces/banghead.gif\" alt=\"[banghead]\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/kill.gif\" alt=\"#kill#\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/bomb.gif\" alt=\"[bomb]\" border=\"0\"> <!--end size[3]--></span>",
              "images": [
                "https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/1013318_607113646043067_1538246468_n.jpg",
                "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/t1.0-9/10366284_661600113927753_2533615088426117483_n.jpg",
                "https://scontent-a-kul.xx.fbcdn.net/hphotos-xfp1/t1.0-9/10419062_660269964060768_3580564822159980358_n.jpg",
                "https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10262024_649021008518997_7458572545891315654_n.jpg",
                "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/10356421_656859197735178_6128256979438771714_n.jpg",
                "https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/10396299_656374917783606_2430995906127998515_n.jpg",
                "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xpa1/t1.0-9/1901685_620220984732333_399372437_n.jpg",
                "https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/10276004_649368515150913_950882928561629018_n.jpg",
                "http://photos-c.ak.instagram.com/hphotos-ak-xfp1/1170306_232844430210130_691814086_n.jpg"
              ],
              "date": "6/3/2014 1:03 AM"
            },
            {
              "author": "一直等TY",
              "gender": "male",
              "content": "<img src=\"http://m3.hkgolden.com/faces/bomb.gif\" alt=\"[bomb]\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/bomb.gif\" alt=\"[bomb]\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/bomb.gif\" alt=\"[bomb]\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 1:05 AM"
            },
            {
              "author": "鬥快派報紙",
              "gender": "male",
              "content": "&#x6211;&#x90FD;&#x60F3;&#x8DDF;&#x4F62;&#x5730;&#x5B78;&#x82F1;&#x6587;",
              "images": [],
              "date": "6/3/2014 1:05 AM"
            },
            {
              "author": "相川始Joker",
              "gender": "male",
              "content": "<img src=\"http://m3.hkgolden.com/faces/good.gif\" alt=\"#good#\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/good.gif\" alt=\"#good#\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 1:06 AM"
            },
            {
              "author": "有客到",
              "gender": "male",
              "content": "<div class=\"ViewQuote\">&#x6211;&#x90FD;&#x60F3;&#x8DDF;&#x4F62;&#x5730;&#x5B78;&#x82F1;&#x6587;</div>\r<br>&#x6211;&#x771F;&#x4FC2;&#x79FB;&#x6C11;&#x53BB;&#x99AC;&#x62C9;&#x7B97;<img src=\"http://m3.hkgolden.com/faces/banghead.gif\" alt=\"[banghead]\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/banghead.gif\" alt=\"[banghead]\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 1:12 AM"
            },
            {
              "author": "昆頓塔倫天奴",
              "gender": "male",
              "content": "<img src=\"http://m3.hkgolden.com/faces/tongue.gif\" alt=\":P\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 1:46 AM"
            },
            {
              "author": "迷牆",
              "gender": "male",
              "content": "&#x5481;&#x6B63;&#x90FD;&#x7121;&#x4EBA;&#x6B23;&#x8CDE;<img src=\"http://m3.hkgolden.com/faces/cry.gif\" alt=\":~(\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/cry.gif\" alt=\":~(\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/cry.gif\" alt=\":~(\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/cry.gif\" alt=\":~(\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/cry.gif\" alt=\":~(\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 2:18 AM"
            },
            {
              "author": "憑胸簫塞",
              "gender": "male",
              "content": "<img src=\"http://m3.hkgolden.com/faces/bomb.gif\" alt=\"[bomb]\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 2:44 AM"
            },
            {
              "author": "Shing身鳩毛",
              "gender": "male",
              "content": "&#x864E;&#x7259; &#x771F;&#x4FC2;&#x8CAA;&#x4F62;&#x5920;Young",
              "images": [],
              "date": "6/3/2014 2:50 AM"
            },
            {
              "author": "無雨問蒼天",
              "gender": "male",
              "content": "&#x5514;&#x77E5;&#x7D93;&#x904E;&#x5E7E;&#x591A;&#x91CD;&#x65E2;PS&#x904E;&#x6FFE;&#x5148;&#x6703;&#x8B8A;&#x6210;&#x5481;....\r<br><img src=\"http://m3.hkgolden.com/faces/frown.gif\" alt=\":-(\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 3:35 AM"
            },
            {
              "author": "生生世世二五",
              "gender": "male",
              "content": "&#x8B58;&#x98DF;&#x4E00;&#x5B9A;&#x4FC2;&#x98DF;<span style=\"color: red;\">&#x975A;&#x5973;</span>",
              "images": [],
              "date": "6/3/2014 3:37 AM"
            },
            {
              "author": "李長實",
              "gender": "male",
              "content": "&#x7559;&#x540D;",
              "images": [],
              "date": "6/3/2014 3:40 AM"
            },
            {
              "author": "最後一分鐘",
              "gender": "male",
              "content": "<img src=\"http://m3.hkgolden.com/faces/smile.gif\" alt=\":)\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 3:43 AM"
            },
            {
              "author": "吊李思捷環球",
              "gender": "male",
              "content": "<img src=\"http://m3.hkgolden.com/faces/fire.gif\" alt=\"#fire#\" border=\"0\"> <img src=\"http://m3.hkgolden.com/faces/bomb.gif\" alt=\"[bomb]\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 3:45 AM"
            },
            {
              "author": "Liαr_Gαmer",
              "gender": "female",
              "content": "&#x7559;&#x540D;",
              "images": [],
              "date": "6/3/2014 3:51 AM"
            },
            {
              "author": "冷帽毒角",
              "gender": "male",
              "content": "&#x7559;&#x540D;",
              "images": [],
              "date": "6/3/2014 5:02 AM"
            },
            {
              "author": "C.馬壯",
              "gender": "male",
              "content": "&#x99AC;&#x62C9;&#x4EBA;&#x5481;&#x767D;&#x5AC1;&#x54A9;",
              "images": [],
              "date": "6/3/2014 5:07 AM"
            },
            {
              "author": "阿姆羅_雷",
              "gender": "male",
              "content": "<div class=\"ViewQuote\">&#x99AC;&#x62C9;&#x4EBA;&#x5481;&#x767D;&#x5AC1;&#x54A9;</div>\r<br>&#x5E7E;&#x5343;&#x842C;&#x4EBA;&#x5165;&#x9762;&#x7E3D;&#x6709;1,2&#x500B;&#x65E2;,&#x6A13;&#x4E0A;&#x5C31;&#x4FC2;&#x597D;&#x4F8B;&#x5B50;",
              "images": [],
              "date": "6/3/2014 5:09 AM"
            },
            {
              "author": "我隻貓叫貓貓",
              "gender": "male",
              "content": "<img class=\"Image\" src=\"http://m3.hkgolden.com/images/mobile/camera.png\" alt=\"[img]http://www3.pictures.zimbio.com/gi/Mandy Lieu F5fFcLxiB51m.jpg[/img]\" ng-src=\"http://www3.pictures.zimbio.com/gi/Mandy Lieu F5fFcLxiB51m.jpg\">",
              "images": [
                "http://www3.pictures.zimbio.com/gi/Mandy Lieu F5fFcLxiB51m.jpg"
              ],
              "date": "6/3/2014 5:12 AM"
            },
            {
              "author": "做咩柒姐你",
              "gender": "male",
              "content": "&#x5514;&#x71C3;&#x4FC2;&#x4E0B;<img src=\"http://m3.hkgolden.com/faces/yipes.gif\" alt=\"[yipes]\" border=\"0\"> &#x4E00;&#x500B;97 &#x4E00;&#x500B;96",
              "images": [],
              "date": "6/3/2014 5:17 AM"
            },
            {
              "author": "如霧如電",
              "gender": "female",
              "content": "<img src=\"http://m3.hkgolden.com/faces/donno.gif\" alt=\"#ng#\" border=\"0\"> &#x5629;~ 96&#x5E74;&#x540C;97&#x5E74;? &#x5514;&#x4FC2;&#x8B1B;&#x771F;&#x4E0B;&#x561B;",
              "images": [],
              "date": "6/3/2014 5:22 AM"
            },
            {
              "author": "神射手.藍斯",
              "gender": "male",
              "content": "&#x4EE5;&#x524D;&#x6709;&#x5973;&#x53CB;&#x4FC2;&#x99AC;&#x62C9;&#x59BA;<img src=\"http://m3.hkgolden.com/faces/bye.gif\" alt=\"#bye#\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 6:42 AM"
            },
            {
              "author": "契弟走得磨",
              "gender": "male",
              "content": "&#x7559;&#x540D;",
              "images": [],
              "date": "6/3/2014 6:49 AM"
            },
            {
              "author": "小小明小小明",
              "gender": "female",
              "content": "<img src=\"http://m3.hkgolden.com/faces/369.gif\" alt=\"[369]\" border=\"0\">",
              "images": [],
              "date": "6/3/2014 6:59 AM"
            },
            {
              "author": "黑囉囉",
              "gender": "male",
              "content": "&#x7559;&#x540D;",
              "images": [],
              "date": "6/3/2014 7:42 AM"
            }
          ]
        expected.isNextPageAvailable = true
        expected.isPreviousPageAvailable = false
        expected.totalNumberOfPage = 3
        expected.title = '[J出血][多圖]識食一定係食馬拉女'
        test.deepEqual result, expected
        test.done()
