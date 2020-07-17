import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class WyMineBody extends StatefulWidget {
  @override
  _WybHomeBodyState createState() => _WybHomeBodyState();
}

const APPBAR_SCROLL_OFFSET = 100;

class _WybHomeBodyState extends State<WyMineBody> {
  double appBarAlpha = 0;

  __onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                //只有当是更新状态下和是第0个child的时候才会调用
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  __onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: EasyRefresh.custom(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      List.generate(50, (index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Text("ces"),
                        );
                      }),
                    ),
                  )
                ],
              ),
            )),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "个人中心",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
