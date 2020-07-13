import 'package:flutter/cupertino.dart';

class WybBottomBarItem extends BottomNavigationBarItem {
  WybBottomBarItem(String barName, String barIcon)
      : super(

          title: Text(barName),
          icon: Image.asset("assets/images/tabbar/${barIcon}.png", width: 30,gaplessPlayback: true,),
          activeIcon: Image.asset(
            "assets/images/tabbar/${barIcon}_active.png",
            width: 30,
            gaplessPlayback: true,
          ),
        ) ;
}


