import 'package:FlutterProject/project/models/banner.dart';
import 'package:FlutterProject/project/viewmodel/flutter_webview.dart';
import 'package:FlutterProject/project/widget/banner_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:FlutterProject/project/models/article.dart';
import 'package:FlutterProject/project/service/api/home_api.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
          delegate: SliverChildListDelegate([
            Container(
              height: 180.0,
              child: ScrollNotificationInterceptor(
                child: Swiper(
                    duration: 2000,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                            return WebViewExample(banners[index]);
                          }));
                        },
                        child: WybBannerItem(banners[index].imagePath));
                  },
                  itemCount: banners.length,
                  //viewportFraction: 0.8,
                  //scale: 0.9,
                  autoplay: true,
                  autoplayDelay: 7000,

                ),
              ),
            ),
          ]),
        ),
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

    _getBanner();
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


  List<BannerData> banners = [];
  void _getBanner(){
    getBanner().then((res){
      banners.addAll(res);
    });
  }


}
