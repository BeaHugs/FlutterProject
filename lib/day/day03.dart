import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WybTextSpan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("文本"),
        ),
        body: WybTextSpanBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("悬浮按钮");
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class WybTextSpanBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: "Hello  World",
              style: TextStyle(fontSize: 20, color: Colors.red)),
          WidgetSpan(child: Icon(Icons.ac_unit, color: Colors.red))
        ])),
        RaisedButton(
          onPressed: () {
            print("RaisedButton");
          },
          child: Column(
            children: [
              Icon(
                Icons.volume_up,
                color: Colors.red,
              ),
              Text("RaisedButton"),
            ],
          ),
        ),
        OutlineButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            print("OutlineButton");
          },
          child: Text("OutlineButton 边框"),
        ),
        FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.blue,
          onPressed: () {
            print("FlatButton");
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              Text(
                "喜欢",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        )
      ],
    );
  }
}