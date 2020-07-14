



import 'package:flutter/cupertino.dart';
import 'package:FlutterProject/project/home/home_content.dart';
import 'package:FlutterProject/project/home/home_page.dart';
import 'package:FlutterProject/project/mine/mine_content.dart';

import 'bottom_bar_item.dart';

List<WybBottomBarItem> bottomBars = [
  WybBottomBarItem("首页","home"),
  WybBottomBarItem("我的","profile"),

];


List<Widget> pageItems =[

  WybHomeBody(),
  WyMineBody(),
];