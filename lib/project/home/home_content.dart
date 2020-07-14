import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:FlutterProject/project/home/home_page.dart';
import 'package:FlutterProject/project/main/info_bar_item.dart';
import 'package:FlutterProject/project/models/article.dart';
import 'package:FlutterProject/project/models/project_tree.dart';
import 'package:FlutterProject/project/service/api/home_api.dart';
import 'package:FlutterProject/project/service/http_request.dart';
import 'package:FlutterProject/project/widget/dashed_line.dart';
import 'package:FlutterProject/project/widget/star_rating.dart';

import 'home_content_list.dart';

class WybHomeBody extends StatefulWidget {
  @override
  _WybHomeBodyState createState() => _WybHomeBodyState();
}

class _WybHomeBodyState extends State<WybHomeBody>
    with SingleTickerProviderStateMixin {
//  List<Tab> tabs = [
//    Tab(text: "推荐"), Tab(text: "完整项目")
//  ];

  //trees

  @override
  Widget build(BuildContext context) {
    // return Container(
    return DefaultTabController(
        length: trees.length,
        //initialIndex: 1,
        child: Scaffold(
          appBar: TabBar(

            //controller: trees.length == 2 ? tabController : tabControllers,
            tabs: trees.map((e) {
              return Tab(
                text: e.name,
              );
            }).toList(),
            labelPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            //[Tab(text: "推荐",), Tab(text: "完整项目")],
            labelStyle: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
            labelColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900),
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.red,
            isScrollable: true,
            //indicatorWeight: 100,
            onTap: (index) {
              print("当前滑动的位置:${index}");
            },
          ),
          body: TabBarView(
            children: trees.map((TreeData tab) {
              //final String label = tab.text.toLowerCase();
              return Center(child: WybHomePage());
            }).toList(),
            //controller: trees.length == 2 ? tabController : tabControllers,
          ),
        ));
  }

  //TabController tabController, tabControllers;

  @override
  void initState() {
    //tabController = TabController(length: trees.length, vsync: this);
    _getTreeData();
  }

  List<TreeData> trees = [
    TreeData(name: "收藏"),
    TreeData(name: "推荐"),
  ];

  void _getTreeData() {
    getProjectTree().then((res) {
      setState(() {
        trees.addAll(res);
       // tabControllers = TabController(length: trees.length, vsync: this);
      });
    });
  }
}
