import 'package:flutter/foundation.dart' show ChangeNotifier;
class HomeVipModel with ChangeNotifier {


  List<Map> Aphome = <Map>[
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
            {'images/history.png'},
            {'images/menu.png'},
          ]
        },
        {
          "font_color":[
            '#FEFFFE','#FEFFFE'
          ],
          "search_colors":[
            '#7C939B','#2F3F25','#C7877B','#0f68B8','#AB2F23'
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
            {'言情'},
            {'悬疑'},
          ]
        },
        {
          "font_color":[
            '#FEFFFE','#FEFFFE'
          ],
          "search_type":2,
          "search_title":[
            {'images/Video,png'},
            {'images/user.png'},
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
            {'故事'},
            {'儿歌'},
          ]
        },
        {
          "search_type":1,
          "search_title":[
            {'头条'},
            {'音乐'},
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
            {'相声'},
            {'评书'},
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
            {'国学'},
            {'佛学'},
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
            {'正史'},
            {'野史'},
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
            {'评论'},
            {'脱口秀'},
          ]
        },
      ]
    }
  ];
  int _index = 0;
  int get index =>_index;
  int  _currIndex = 0;
  int get currIndex => _currIndex;

  Map getMapHome(int index){
    return Aphome[index];
  }

  setCurrIndexVip(int index){
    _currIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}