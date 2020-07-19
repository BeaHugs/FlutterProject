import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:FlutterProject/project/widget/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

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
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  __onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: EasyRefresh.custom(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: WrapperImage(
                                imageType: ImageType.random,
                                url: "扔无线",
                                height: 60,
                                width: 60,
                              ),
                            ),


                            Consumer<UserModel>(

                              builder: (ctx,userModel,child){

                                return Text(userModel.user.userName);
                              },

                              //child: ,
                            )

                            //Text("username")
                          ],
                        ),
                      ),
                    ]),
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
