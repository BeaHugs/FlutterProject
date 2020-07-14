import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WybArticleTag extends StatelessWidget {


  final String text;
  final Color color;


  WybArticleTag(this.text, {this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        //vertical: 0.5,
        horizontal: 2
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color:color )
      ),
      child: Text(text,style: TextStyle(fontSize: 10,color: color),),
    );
  }
}
