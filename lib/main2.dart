import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()=>runApp(aaaa());

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class _Page {
  _Page({this.label});

  final String label;

  String get id => label[0];

  @override
  String toString() => '$runtimeType("$label")';
}

class _CardData {
  const _CardData({this.title, this.imageAsset, this.imageAssetPackage});

  final String title;
  final String imageAsset;
  final String imageAssetPackage;
}

final Map<_Page, List<_CardData>> _allPages = <_Page, List<_CardData>>{
  new _Page(label: 'LEFT'): <_CardData>[
    const _CardData(
      title: 'Vintage Bluetooth Radio',
      imageAsset: 'shrine/products/radio.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Sunglasses',
      imageAsset: 'shrine/products/sunnies.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Clock',
      imageAsset: 'shrine/products/clock.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Red popsicle',
      imageAsset: 'shrine/products/3.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Folding Chair',
      imageAsset: 'shrine/products/lawn_chair.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Green comfort chair',
      imageAsset: 'shrine/products/chair.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Old Binoculars',
      imageAsset: 'shrine/products/binoculars.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Teapot',
      imageAsset: 'shrine/products/teapot.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Blue suede shoes',
      imageAsset: 'shrine/products/chucks.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],
//  new _Page(label: 'RIGHT'): <_CardData>[
//    const _CardData(
//      title: 'Beachball',
//      imageAsset: 'shrine/products/beachball.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//    ),
//    const _CardData(
//      title: 'Dipped Brush',
//      imageAsset: 'shrine/products/brush.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//    ),
//    const _CardData(
//      title: 'Perfect Goldfish Bowl',
//      imageAsset: 'shrine/products/fish_bowl.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//    ),
//  ],
};

class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  static const double height = 272.0;
  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Align(
              alignment:
              page.id == 'L' ? Alignment.centerLeft : Alignment.centerRight,
              child: new CircleAvatar(child: new Text('${page.id}')),
            ),
            new SizedBox(
              width: 144.0,
              height: 144.0,
              child: new Image.asset(
                data.imageAsset,
                package: data.imageAssetPackage,
                fit: BoxFit.contain,
              ),
            ),
            new Center(
              child: new Text(
                data.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class aaaa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '吊你老母',
      home:ScrollViewDemo() ,
    );
  }
}


class ScrollViewDemo extends StatefulWidget {
  @override
  _ScrollViewDemoState createState() => _ScrollViewDemoState();
}

class _ScrollViewDemoState extends State<ScrollViewDemo> {
  static const String routeName = '/material/tabs';
  ScrollController _controller = new ScrollController();
  ScrollController _controller2 = new ScrollController();

  double h = 0;
  double d15;
  double d20;
  double d25;
  double d30;
  double d35;
  double d40;
  double d45;
  double d50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      d15 = ScreenUtil().setWidth(15);

      d20 = ScreenUtil().setWidth(20);
      d25 = ScreenUtil().setWidth(25);

      d30 = ScreenUtil().setWidth(30);
      d35 = ScreenUtil().setWidth(35);

      d50 = ScreenUtil().setWidth(50);

      d40 = ScreenUtil().setWidth(40);
      d45 = ScreenUtil().setWidth(45);

      double d60 = ScreenUtil().setWidth(60);
      double d70 = ScreenUtil().setWidth(70);

      double d80 = ScreenUtil().setWidth(80);
      double d85 = ScreenUtil().setWidth(85);

      double d90 = ScreenUtil().setWidth(90);

      double d100 = ScreenUtil().setWidth(100);

      setState(() {
        if ((_controller.offset > d100)) {
          h = d50;
        } else if ((_controller.offset > d90)) {
          h = d45;
        } else if ((_controller.offset > d80)) {
          h = d40;
        } else if ((_controller.offset > d70)) {
          h = d35;
        } else if ((_controller.offset > d60)) {
          h = d30;
        } else if ((_controller.offset > d50)) {
          h = d25;
        } else if ((_controller.offset > d40)) {
          h = d20;
        } else if ((_controller.offset > d30)) {
          h = d15;
        } else {
          h = ScreenUtil().setWidth(0);
        }
      });
    });
    double start = 0;
    _controller2.addListener(() {
//      print("---->_controller2:${_controller2.offset}");
      if ((_controller2.offset - start).abs() > 3) {
        _controller.jumpTo(_controller2.offset);
        start = _controller2.offset;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: new NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.share),
                      tooltip: 'Add new entry',
                      onPressed: () {
                        /* ... */
                      },
                    ),
                  ],
                  leading: Container(
                    child: Icon(Icons.backspace),
                    width: 0,
                    alignment: Alignment.center,
                  ),
                  title: Text("这是一个标题"),
                  pinned: true,
                  //固定在顶部
                  expandedHeight: ScreenUtil().setWidth(260),
                  // 这个高度必须比flexibleSpace高度大
                  // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
                  flexibleSpace: new Container(
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            height: ScreenUtil().setWidth(170),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.asset(
                                  "images/1.png",
                                  fit: BoxFit.cover,
                                  height: ScreenUtil().setWidth(150),
                                ),
                              ],
                            ),
                            width: double.infinity,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: _allPages.keys.map((_Page page) {
              return new SafeArea(
                top: false,
                bottom: false,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new CustomScrollView(
                      controller: _controller2,
                      key: new PageStorageKey<_Page>(page),
                      slivers: <Widget>[
                        new SliverOverlapInjector(
                          handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context),
                        ),
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          sliver: new SliverFixedExtentList(
                            itemExtent: _CardDataItem.height,
                            delegate: new SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                final _CardData data = _allPages[page][index];
                                return new Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: new _CardDataItem(
                                    page: page,
                                    data: data,
                                  ),
                                );
                              },
                              childCount: _allPages[page].length,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
//        body: Column(children: <Widget>[],),
        ),
      ),
    );
  }
}