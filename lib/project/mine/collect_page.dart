import 'package:FlutterProject/project/home/home_content_list.dart';
import 'package:FlutterProject/project/login/page/login_page.dart';
import 'package:FlutterProject/project/models/article.dart';
import 'package:FlutterProject/project/models/article_list.dart';
import 'package:FlutterProject/project/service/http_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("收藏"),
          centerTitle: true,
        ),
        body: EasyRefresh.custom(
          // firstRefresh: true,
          slivers: [
            SliverList(delegate: SliverChildBuilderDelegate(
              (context, index) {
                return WybContentListItem(article[index]);
              },
              childCount: article.length
            ))
          ],

          onLoad: () {},
          onRefresh: () {},
        ));
  }

  List<Data> article = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpRequest.requestNetWork("lg/collect/list/0/json", onSuccess: (data) {

      setState(() {
        article.addAll(ArticleList.fromJson(data).data.datas);
      });
    },onError: (code,msg){
      if(code == -1001){
        Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
          return LoginPage();
        }));
      }
    });
  }
}
