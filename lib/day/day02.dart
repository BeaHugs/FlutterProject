
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WybApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WybHomePage(),
    );
  }
}

class WybHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品列表"),
      ),
      body: WybContent(),
    );
  }
}

class WybContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          WybHomeProductItem(
            title: "商品",
            desc: "商品内容",
            img:
            "https://t9.baidu.com/it/u=86853839,3576305254&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1594117283&t=9b0b5f9570e0a23fbc4b419443445610",
          ),
          WybCountItem("传递参数")
        ],
      ),
    );
  }
}

class WybHomeProductItem extends StatelessWidget {
  final String title;
  final String desc;
  final String img;

  final style1 = TextStyle(fontSize: 30, color: Colors.red);

  final style2 = TextStyle(fontSize: 20, color: Colors.blue);

  WybHomeProductItem({this.title, this.desc, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration:
      BoxDecoration(border: Border.all(width: 5, color: Colors.red)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(title, style: style1),
          Text(desc, style: style2),
          Image.network(img)
        ],
      ),
    );
  }
}

class WybCountItem extends StatefulWidget {
  String name;

  WybCountItem(String name) {
    this.name = name;
    print("1.构造函数");
  }

  @override
  _WybCountItemState createState() {
    print("2.createState");
    return _WybCountItemState();
  }
}

class _WybCountItemState extends State<WybCountItem> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    print("3.initState");
  }

  @override
  void dispose() {
    super.dispose();
    print("5.dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("4.build");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _getCountWidget(),
        Text("${this.widget.name}总数量:$_count")
      ],
    );
  }

  Widget _getCountWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      RaisedButton(
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      RaisedButton(
        onPressed: () {
          setState(() {
            _count--;
          });
        },
        child: Text(
          "-",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ]);
  }
}
