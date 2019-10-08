class FindModel {
  int id;
  String userIcon;
  String userName;
  String userSubtitle;
  String findContent;
  String findPlayurl;
  int findFenxiang;
  int findHuifu;
  int findDianzhan;
  String findQuanzi;
  FindTop findTop;

  FindModel(
      {this.id,
        this.userIcon,
        this.userName,
        this.userSubtitle,
        this.findContent,
        this.findPlayurl,
        this.findFenxiang,
        this.findHuifu,
        this.findDianzhan,
        this.findQuanzi,
        this.findTop});

  FindModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userIcon = json['user_icon'];
    userName = json['user_name'];
    userSubtitle = json['user_subtitle'];
    findContent = json['find_content'];
    findPlayurl = json['find_playurl'];
    findFenxiang = json['find_fenxiang'];
    findHuifu = json['find_huifu'];
    findDianzhan = json['find_dianzhan'];
    findQuanzi = json['find_quanzi'];
    findTop = json['find_top'] != null
        ? new FindTop.fromJson(json['find_top'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_icon'] = this.userIcon;
    data['user_name'] = this.userName;
    data['user_subtitle'] = this.userSubtitle;
    data['find_content'] = this.findContent;
    data['find_playurl'] = this.findPlayurl;
    data['find_fenxiang'] = this.findFenxiang;
    data['find_huifu'] = this.findHuifu;
    data['find_dianzhan'] = this.findDianzhan;
    data['find_quanzi'] = this.findQuanzi;
    if (this.findTop != null) {
      data['find_top'] = this.findTop.toJson();
    }
    return data;
  }
  List<int> dianzan = [99,12313,123,11,123,2452,123,3452,123,743,77345,];
  List<int> huifu = [234,3452,11,31,246355,356,67,345,656,34,234];
  List<int> fenxiang = [234,234,55134,123,12313,2412313,1231234,12313,2424,
    993,8841];
  List<String> context =[
    '虽然不好看，但是我们混搭就对了',
    '为了凑钱结婚,他么的什么都干的出来','朱雀青龙白虎玄武,'
      '四神归位','三生有幸遇见你,纵使悲凉也是情',
    '《目击者追凶》国产悬疑电影中的黑马,结局只有少数人看的懂','天苍苍野茫茫,'
      '风吹草儿，马悠扬','天使的眼泪,你的眼里也是只有我吗？','放弃也是一种美德','人生之若初见','爱情落满地','123123'];
  List<String> uname =['主播雅音可悦','主播小宁','着迷_188','小、习惯','冷饭生炒、ai迷你','天之大',
    '猫小儿FM','萌萌哒小艾','可怜兮兮','晚餐吃什么','蜜汁走位、000'];
  List<String> icon = [
    'https://imagev2.xmcdn.com/group50/M04/7E/56/wKgKnVvZiy7TLq-NAAP2swhQwNc093.jpg',
    'https://imagev2.xmcdn.com/group66/M09/52/C4/wKgMa11j5gWgUw7zAAH0SswotdQ632.jpg',
    'https://imagev2.xmcdn.com/group25/M0A/DD/64/wKgJNlhZKgGDg8YcAAAVSm2r0XE044.jpg',
    'https://imagev2.xmcdn.com/group63/M09/51/DB/wKgMcl1C9-zS4PvVAABpaE8oyyY718'
        '.jpg',
    'https://imagev2.xmcdn.com/group37/M03/AA/AC/wKgJoVo3U4ew8BYoAAEnwL-_cns441.jpg',
    'https://imagev2.xmcdn.com/group10/M03/57/05/wKgDaVXAhVzwZOe0AAG-tTcY-Xs156.jpg',
    'https://imagev2.xmcdn.com/group2/M00/16/11/wKgDr1GoPovws9o5AAVzTMLZNrU531.jpg',
    'https://imagev2.xmcdn.com/group15/M08/80/07/wKgDaFYV5azwbTx_AAMirdWN_yI079.jpg',
    'https://imagev2.xmcdn.com/group4/M04/B6/1E/wKgDs1PrMyGzGkIbAACPbCgEZGQ656.jpg',
    'https://imagev2.xmcdn.com/group59/M09/2F/77/wKgLeFyuA4nDBnfnAAAV5o4jnjM708.jpg',
    'https://imagev2.xmcdn.com/group5/M02/32/9D/wKgDtlORJA_Cfj5LAABqx3VSIC0690.jpg'];

   List<FindModel> getFindModel(){
      List<FindModel> list = new List();
      for(int  i=0; i< icon.length;i++){
        list.add(new FindModel(id: i,userIcon: icon[i],findDianzhan:
        dianzan[i],findHuifu: huifu[i],findFenxiang: fenxiang[i],findQuanzi:
        i%3==0?"愚乐圈v":null,findContent: context[i],userName: uname[i],
            userSubtitle: i%2==0?"你可能感兴趣的领域":"大家都在看",findPlayurl: null,
            findTop: i%4==0?new FindTop(userDianzhan: fenxiang[i],userName:
            uname[i],userIcon:
            icon[i],userContent: '你这样会被人打死知道吗？！！！1111111111111111111111111111'
                '1111')
                :null));
      }
      return list;
  }
}

class FindTop {
  String userName;
  String userIcon;
  String userContent;
  int userDianzhan;

  FindTop({this.userName, this.userIcon, this.userContent, this.userDianzhan});

  FindTop.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userIcon = json['user_icon'];
    userContent = json['user_content'];
    userDianzhan = json['user_dianzhan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_icon'] = this.userIcon;
    data['user_content'] = this.userContent;
    data['user_dianzhan'] = this.userDianzhan;
    return data;
  }
}