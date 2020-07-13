import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class WybHomeTabbarWidget extends StatefulWidget {
  @override
  _WybHomeTabbarWidgetState createState() => _WybHomeTabbarWidgetState();
}

class _WybHomeTabbarWidgetState extends State<WybHomeTabbarWidget> with SingleTickerProviderStateMixin{

  TabController tabController ;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: [Tab(text:"推荐"), Tab(text:"完整项目")],
      labelStyle: TextStyle(fontSize: 15,color: Colors.red,fontWeight:FontWeight.bold),
      labelColor: Colors.red,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelStyle: TextStyle(fontSize: 15,color: Colors.black),
      unselectedLabelColor: Colors.black,
      indicatorColor: Colors.red,
      isScrollable: true,
      //indicatorWeight: 100,
      onTap: (index){
        print("当前滑动的位置:${index}");
      },
    );
  }
}





