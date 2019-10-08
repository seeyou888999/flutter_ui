import 'package:flutter/material.dart';

class MainTabViewList extends StatefulWidget {
  final int pageIndex;
  final TabController _tabController;

  MainTabViewList(this._tabController, this.pageIndex);

  @override
  _MainTabViewListState createState() => _MainTabViewListState();
}

class _MainTabViewListState extends State<MainTabViewList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TabBarView(controller: widget._tabController, children: <Widget>[
        Text(
          '张三',
          style: TextStyle(color: Colors.cyan),
        ),
        Text(
          '张三',
          style: TextStyle(color: Colors.orange),
        ),
        Text(
          '张三',
          style: TextStyle(color: Colors.black54),
        ),
        Text(
          '张三',
          style: TextStyle(color: Colors.black54),
        ),
//      ListView(
//        children: <Widget>[
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//        ],
//      ),
//      ListView(
//        children: <Widget>[
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//        ],
//      ),
//      ListView(
//        children: <Widget>[
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//          ListTile(
//            title: Text('你好'),
//            leading: Icon(Icons.access_alarm),
//          ),
//        ],
//      ),
//      ListView(children: <Widget>[
//        ListTile(
//          title: Text('你好'),
//          leading: Icon(Icons.access_alarm),
//        ),
//        ListTile(
//          title: Text('你好'),
//          leading: Icon(Icons.access_alarm),
//        ),
//        ListTile(
//          title: Text('你好'),
//          leading: Icon(Icons.access_alarm),
//        ),
//        ListTile(
//          title: Text('你好'),
//          leading: Icon(Icons.access_alarm),
//        ),
//        ListTile(
//          title: Text('你好'),
//          leading: Icon(Icons.access_alarm),
//        ),
//        ListTile(
//          title: Text('你好'),
//          leading: Icon(Icons.access_alarm),
//        ),
//        ListTile(
//          title: Text('你好'),
//          leading: Icon(Icons.access_alarm),
//        ),
//      ])
    ]);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
