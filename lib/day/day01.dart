import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WYBapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: WYBHomePage());
  }
}

/**
 * widget:有/无状态(一般不采用widget)
 *        StatelessWidget:无状态
 *        StatefulWidget:有状态
 */

class WYBHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("第一个flutter"),
        ),
        body: WYBCenterBody());
  }
}

class WYBCenterBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WYBStatefulBody();
  }
}

class WYBStatefulBody extends State<StatefulWidget> {
  var value = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //required:命名可选参数必须选
          Checkbox(
            value: value,
            onChanged: (value) {
              setState(() {
                this.value = value;
              });

            },
          ),
          Text("Flutter")
        ],
      ),
    );
  }
}