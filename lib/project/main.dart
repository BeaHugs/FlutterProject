import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'main/info_bar_item.dart';
import 'models/user.dart';

main(){

  runApp(WybRunApp());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

}

class WybRunApp extends StatefulWidget {
  @override
  _WybState createState() => _WybState();
}

class _WybState extends State<WybRunApp> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create :(ctx) => UserModel(User("wangyibo")))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
//          appBar: AppBar(
//            title: Text("底部导航"),
//          ),
            body: IndexedStack(
              index: indexPage,
              children: pageItems,
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 15,
              unselectedFontSize: 15,
              iconSize: 15,
              selectedLabelStyle: TextStyle(color: Colors.red),
              unselectedLabelStyle: TextStyle(color: Colors.black),
              currentIndex: indexPage,
              type: BottomNavigationBarType.fixed,
              items: bottomBars,
              onTap: (index) {
                setState(() {
                  indexPage = index;
                });
              },
            ),
          ),
          localizationsDelegates: [
            GlobalEasyRefreshLocalizations.delegate,

            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('zh', 'CN'),
          ]),
    );
  }
}
