import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:FlutterProject/project/models/article.dart';
import 'package:FlutterProject/project/service/api/home_api.dart';

import 'home_content_list.dart';

class WybHomePage extends StatefulWidget {
  @override
  _WybHomePageState createState() => _WybHomePageState();
}

class _WybHomePageState extends State<WybHomePage> {
  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return EasyRefresh.custom(
      // firstRefresh: true,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return WybContentListItem(article[index]);
            },
            childCount: article.length,
          ),
        ),
      ],
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 3), () {
          _onRefreshData();
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 3), () {
          _onLoadData();
        });
      },
    );
  }

  @override
  void initState() {
    _onRefreshData();
  }

  List<Data> article = [];

  int page = 1;

  void _onRefreshData() {
    page = 1;
    getArticleTopData(page).then((res) {
      setState(() {
        article.clear();
        article.addAll(res); // = res.data;
      });
      //print(res);
    });
  }

  void _onLoadData() {
    page++;
    getArticleListData(page).then((res) {
      setState(() {
        article.addAll(res);
      });
    });
  }

}
