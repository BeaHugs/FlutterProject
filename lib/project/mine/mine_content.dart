import 'package:FlutterProject/project/login/page/login_page.dart';
import 'package:FlutterProject/project/login/widgets/my_text_field.dart';
import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:FlutterProject/project/widget/image.dart';
import 'package:common_utils/common_utils.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();


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
                      GestureDetector(
                        child: Container(
                          child: new Stack(
                            children: <Widget>[
                              ClipPath(
                                clipper: new TopBarClipper(
                                    MediaQuery.of(context).size.width, 200.0),
                                child: new SizedBox(
                                  width: double.infinity,
                                  height: 200.0,
                                  child: new Container(
                                    width: double.infinity,
                                    height: 240.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              // 名字
                              Container(
                                margin: new EdgeInsets.only(top: 60.0),
                                child: new Center(
                                  child: Consumer<UserModel>(
                                    builder: (ctx, userModel, child) {
                                      return Text(userModel.user.data  == null?"未登录":userModel.user.data.nickname);
                                    },
                                    //child: ,
                                  ),
                                ),
                              ),
                              // 图标
                              Container(
                                margin: new EdgeInsets.only(top: 100.0),
                                child: new Center(
                                    child: new Container(
                                  width: 60.0,
                                  height: 60.0,
                                  child: new PreferredSize(
                                    child: new Container(
                                      child: new ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        child: new Container(
                                          color: Colors.white,
                                          child: WrapperImage(
                                            imageType: ImageType.random,
                                            url: "扔无线",
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                      ),
                                    ),
                                    preferredSize: new Size(80.0, 80.0),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(new  MaterialPageRoute(builder: (ctx){
                            return LoginPage();
                          }));

                        },
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

// 顶部栏裁剪
class TopBarClipper extends CustomClipper<Path> {
  // 宽高
  double width;
  double height;

  TopBarClipper(this.width, this.height);

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(width, 0.0);
    path.lineTo(width, height / 2);
    path.lineTo(0.0, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
