import 'dart:math';

import 'package:FlutterProject/project/models/user.dart';
import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import 'day/day01.dart';
import 'day/day02.dart';
import 'day/day03.dart';

main() => runApp(WybStackDemo());

class WybStackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create :(ctx) => UserModel(User("wangyibo")))
      ],
      child: MaterialApp(
          home: Scaffold(
//        appBar: AppBar(
//          title: Text("Stack"),
//        ),
            body: WybGridView(),
          ),

      ),
    );
  }
}

class WybGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("SliverAppBars"),
                background: Image.network(
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593756402855&di=3c2ea7a5a777951dd6b223df0c869a70&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Stack(
                  children: [
                    FadeInImage(
                      fadeInDuration: Duration(milliseconds: 100),
                      fadeOutDuration: Duration(milliseconds: 100),
                      placeholder: AssetImage("assets/images/timg.jpg"),
                      image: NetworkImage(
                          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593756402855&di=3c2ea7a5a777951dd6b223df0c869a70&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          //alignment: AlignmentGeometry.lerp(a, b, t),
                          color: Color.fromARGB(100, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("文本",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                );
              }, childCount: 9),
            ),
//        ListView(
////      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
////          crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
//          children: List.generate(10, (index) {
//            return Container(
//              child: Stack(
//                children: [
//                  FadeInImage(
//                    fadeInDuration: Duration(milliseconds: 100),
//                    fadeOutDuration: Duration(milliseconds: 100),
//                    placeholder: AssetImage("assets/images/timg.jpg"),
//                    image: NetworkImage(
//                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593756402855&di=3c2ea7a5a777951dd6b223df0c869a70&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"),
//                  ),
//                  Positioned(
//                      bottom: 0,
//                      left: 0,
//                      right: 0,
//                      child: Container(
//                        padding: EdgeInsets.symmetric(horizontal: 8),
//                        //alignment: AlignmentGeometry.lerp(a, b, t),
//                        color: Color.fromARGB(100, 0, 0, 0),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Text("文本",
//                                style: TextStyle(
//                                    fontSize: 20, color: Colors.white)),
//                            IconButton(
//                              icon: Icon(
//                                Icons.favorite,
//                                color: Colors.white,
//                              ),
//                            )
//                          ],
//                        ),
//                      )),
//                ],
//              ),
//            );
//          }),
//        ),
            SliverSafeArea(
              sliver: SliverPadding(
                padding: EdgeInsets.all(8),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext content, int index) {
                    if (index % 2 == 0) {
                      return Container(
                        color: Color.fromARGB(255, Random().nextInt(256),
                            Random().nextInt(256), Random().nextInt(256)),
                      );
                    }
                    return Container(
                      child: Stack(
                        children: [
                          FadeInImage(
                            fadeInDuration: Duration(milliseconds: 100),
                            fadeOutDuration: Duration(milliseconds: 100),
                            placeholder: AssetImage("assets/images/timg.jpg"),
                            image: NetworkImage(
                                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593756402855&di=3c2ea7a5a777951dd6b223df0c869a70&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"),
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                //alignment: AlignmentGeometry.lerp(a, b, t),
                                color: Color.fromARGB(100, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("文本",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    );
                  }, childCount: 11),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WybStackBadyful extends StatefulWidget {
  @override
  _WybStackfulState createState() => _WybStackfulState();
}

class _WybStackfulState extends State<WybStackBadyful> {
  bool isFavor = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        FadeInImage(
          fadeInDuration: Duration(milliseconds: 100),
          fadeOutDuration: Duration(milliseconds: 100),
          placeholder: AssetImage("assets/images/timg.jpg"),
          image: NetworkImage(
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593756402855&di=3c2ea7a5a777951dd6b223df0c869a70&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              //alignment: AlignmentGeometry.lerp(a, b, t),
              color: Color.fromARGB(100, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("文本",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFavor ? Colors.white : Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavor = !isFavor;
                      });
                    },
                  )
                ],
              ),
            )),
      ],
    );
  }
}
