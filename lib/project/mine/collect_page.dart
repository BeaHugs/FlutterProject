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
            slivers: [SliverList(delegate: SliverChildListDelegate([




            ]))]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpRequest.requestNetWork("lg/collect/list/0/json", onSuccess: (data) {
      print("收藏 : ${data}");
    });
  }
}
