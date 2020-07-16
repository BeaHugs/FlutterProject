import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main/info_bar_item.dart';

main() => runApp(WybRunApp());

class WybRunApp extends StatefulWidget {
  @override
  _WybState createState() => _WybState();
}

class _WybState extends State<WybRunApp> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        ]);
  }
}
