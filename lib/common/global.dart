import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences preferences;
var listViews = {
  'news':[{
    'image':'http://imagev2.xmcdn.com/group63/M06/6B/0D/wKgMaF0u0gXiM7eMAAO'
        '-DPWVpEY919.jpg',
    'titile': '曾经得我们,迷失在那漫长得岁月中...',
    'subTitle': '曾经的曾经让我难忘'
  },
  {
    'image':'http://imagev2.xmcdn.com/group50/M00/48/C5/wKgKmVvvmKCRMK-JAAF-6QUkwdE602.jpg',
    'titile': '最难忘的,是你转身离去的背影',
    'subTitle': '背影如此让人失神'
  },
  {
    'image':'http://imagev2.xmcdn.com/group52/M05/64/8D/wKgLcFw9mbaDiHvmAAW9wrlMPlU241.jpg',
    'titile': '我曾经已经拥有了整个世界发现最后连你也失去了',
    'subTitle': '天下是我'
  },
  {
    'image':'http://imagev2.xmcdn.com/group56/M0B/9F/BF/wKgLgFyipRGBId2FAAHMl2Id15c856.jpg',
    'titile': '忘记是最痛苦的事情',
    'subTitle': '痛苦的源头'
  },
  {
    'image':'http://imagev2.xmcdn.com/group59/M0A/AE/A4/wKgLel0_6jSB96guAAQiVnZ8T6o580.jpg',
    'titile': '天下之大,何以安家',
    'subTitle': '安家立命'
  },
  ]
};

List Aphome = [
  {
    'search':[
      {
        "search_type":2,
        "font_color":[
          '#FEFFFE','#000000'
        ],
        "search_colors":[
          '#EE2602','#2F3F25','#C7877B','#0f68B8','#AB2F23'
        ],
        "search_title":[
          'images/history.png',
          'images/menu.png'
        ]
      },
      {
        "font_color":[
          '#D7BDA6','#D7BDA6'
        ],
        "search_colors":[
          '#000000'
        ],
        "search_type":0,
      },
      {
        "search_colors":[
          '#7C939B','#807778','#BABFC8','#454438','#C888A7'
        ],
        "font_color":[
          '#FEFFFE','#FEFFFE'
        ],
        "search_type":1,
        "search_title":[
          '言情',
          '悬疑'
        ]
      },
      {
        "font_color":[
          '#000000','#000000'
        ],
        "search_type":2,
        "search_title":[
          'images/Video.png',
          'images/user.png'
        ]
      },
      {
        "search_colors":[
          '#66B8BC','#B07143','#C7877B','#0f68B8','#AB2F23'
        ],
        "font_color":[
          '#FEFFFE','#FEFFFE'
        ],
        "search_type":1,
        "search_title":[
          '头条',
          '音乐'
        ]
      },
      {
        "search_colors":[
          '#66B8BC','#B07143','#C7877B','#0f68B8','#AB2F23'
        ],
        "font_color":[
          '#FEFFFE','#FEFFFE'
        ],
        "search_type":1,
        "search_title":[
          '故事',
          '儿歌'
        ]
      },
      {
        "search_colors":[
          '#66B8BC','#B07143','#C7877B','#0f68B8','#AB2F23'
        ],
        "font_color":[
          '#FEFFFE','#FEFFFE'
        ],
        "search_type":1,
        "search_title":[
          '相声',
          '评书'
        ]
      },
      {
        "search_colors":[
          '#66B8BC','#B07143','#C7877B','#0f68B8','#AB2F23'
        ],
        "font_color":[
          '#FEFFFE','#FEFFFE'
        ],
        "search_type":1,
        "search_title":[
          '国学',
          '佛学'
        ]
      },
      {
        "search_colors":[
          '#66B8BC','#B07143','#C7877B','#0f68B8','#AB2F23'
        ],
        "font_color":[
          '#FEFFFE','#FEFFFE'
        ],
        "search_type":1,
        "search_title":[
          '正史',
          '野史'
        ]
      },
      {
        "search_colors":[
          '#66B8BC','#B07143','#C7877B','#0f68B8','#AB2F23'
        ],
        "font_color":[
          '#FEFFFE','#FEFFFE'
        ],
        "search_type":1,
        "search_title":[
          '评论',
          '脱口秀'
        ]
      },
    ]
  }
];

var MyCenter =
  {
    'center': [
      {
        'center_name': '个人中心',
        'center_list': [
          {'l_name': '我要录音', 'l_img': 'images/mic.png'},
          {'l_name': '我要直播', 'l_img': 'images/Video.png'},
          {'l_name': '我的作品', 'l_img': 'images/dvd.png'},
          {'l_name': '创作中心', 'l_img': 'images/laptop.png'},
        ]
      },
      {
        'center_name': '我的服务',
        'center_list': [
          {'l_name': '我的钱包', 'l_img': 'images/purse.png'},
          {'l_name': '我的已购', 'l_img': 'images/purse.png'},
          {'l_name': '我的等级', 'l_img': 'images/purse.png'},
          {'l_name': '我的听友圈', 'l_img': 'images/purse.png'},
          {'l_name': '我的客服', 'l_img': 'images/purse.png'},
          {'l_name': '推荐有礼', 'l_img': 'images/purse.png'},
        ]
      },
      {
        'center_name': '必备工具',
        'center_list': [
          {'l_name': '扫一扫', 'l_img': 'images/purse.png'},
          {
            'l_name': '定时关闭',
            'l'
                '_img': 'images/purse.png'
          },
          {'l_name': '未成年模式', 'l_img': 'images/purse.png'},
          {'l_name': '驾驶模式', 'l_img': 'images/purse.png'},
          {
            'l_name': '夜间模式',
            'l_img': 'images/purse.png'
          },
        ]
      },
      {
        'center_name': '其他服务',
        'center_list': [
          {'l_name': '知识大使', 'l_img': 'images/purse.png'},
          {'l_name': '联名信用卡', 'l_img': 'images/purse.png'},
          {'l_name': '免流量特权', 'l_img': 'images/purse.png'},
          {'l_name': '官方商城', 'l_img': 'images/purse.png'},
          {'l_name': '我听福利社', 'l_img': 'images/purse.png'},
          {'l_name': '商家福利', 'l_img': 'images/purse.png'},
          {'l_name': '微信服务', 'l_img': 'images/purse.png'},
        ]
      },
      {
        'center_name': '商务合作与服务',
        'center_list': [
          {'l_name': '配音服务', 'l_img': 'images/purse.png'},
          {'l_name': '开放平台', 'l_img': 'images/purse.png'},
          {'l_name': '广告合作', 'l_img': 'images/purse.png'},
          {'l_name': '万物声合作', 'l_img': 'images/purse.png'},
          {'l_name': '企业版', 'l_img': 'images/purse.png'},
          {'l_name': '会员合作', 'l_img': 'images/purse.png'},
          {'l_name': '版权登记', 'l_img': 'images/purse.png'},
        ]
      },
    ]
  };

var  netWorkImage = [
  'http://imagev2.xmcdn.com/group63/M06/6B/0D/wKgMaF0u0gXiM7eMAAO'
      '-DPWVpEY919.jpg',
  'http://imagev2.xmcdn.com/group50/M00/48/C5/wKgKmVvvmKCRMK-JAAF-6QUkwdE602.jpg',
  'http://imagev2.xmcdn.com/group52/M05/64/8D/wKgLcFw9mbaDiHvmAAW9wrlMPlU241.jpg',
  'http://imagev2.xmcdn.com/group56/M0B/9F/BF/wKgLgFyipRGBId2FAAHMl2Id15c856.jpg',
  'http://imagev2.xmcdn.com/group59/M0A/AE/A4/wKgLel0_6jSB96guAAQiVnZ8T6o580.jpg',
  'http://imagev2.xmcdn.com/group66/M03/72/CB/wKgMdV14SP7id-bGAAZGnMebqfA215.jpg',
];
var   newTitle = ['鬼吹灯之天罚','山海密藏','盗墓笔记之猴赛雷xxxxxxxxxx','老九门','仙逆之我欲封天','天启者'];

var   newTitle1 = ['米小圈上学记·四年级','郭德纲超清经典相声集','姜小牙上学记','易中天说禅','王玥波播讲：雍正剑侠图·第七'
    '部','郭德纲超清经典相声集【 伴随入眠版 】'];

var historyLinster=[
  {
    "h_title":'《肖申克的救赎》：没有什么能够阻挡，你对自由的向往',
    'h_subtitle':'精读100本豆瓣高分电影原著',
    'h_url':'https://imagev2.xmcdn.com/group59/M04/56/7A/wKgLelywO4ui6kAcAA2Dn_a4-Dw097.jpg',
    'h_isover':0,
    'h_youlistine':22,
  },
  {
    "h_title":'《大秦帝国》完整版',
    'h_subtitle':'大秦帝国-第一部-黑色裂变-上-楔子-01',
    'h_url':'https://imagev2.xmcdn.com/group50/M06/1B/0F/wKgKnVvhATKDTX3LAAFIRcIbZms939.jpg',
    'h_isover':1,
    'h_youlistine':8,
  },
  {
    "h_title":'盗墓笔记',
    'h_subtitle':'231《盗墓笔记之六阴山古楼》（二十六）',
    'h_url':'https://imagev2.xmcdn.com/group13/M08/E3/93/wKgDXlaUhK7TaVetAAG_cWVB_2g804.jpg',
    'h_isover':1,
    'h_youlistine':26,
  },
];

