import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/project/models/article.dart';

class WybContentListItem extends StatefulWidget {
  final Data article;

  WybContentListItem(this.article);

  @override
  _WybContentListItemState createState() => _WybContentListItemState();
}

class _WybContentListItemState extends State<WybContentListItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.article.type == 1) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 5, 10, 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildArticleTitle(), buildArticleWidget()],
        ),
      );
    } else if (widget.article.type == 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 5, 10, 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(height: 1.0, color: Color(0xcccccccc)),
            buildArticleTitle(),
            buildArticleWidget()
          ],
        ),
      );
    }
  }

  Widget buildArticleTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Text(
        widget.article.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildArticleWidget() {
    return Container(
        child: Row(

      children: buildArticleWidgetChild(),
    ));
  }

  List<Widget> buildArticleWidgetChild() {
    List<Widget> wChilds = [];

    if (widget.article.type == 1) {
      wChilds.add(
        Text(
          "置顶",
          style: TextStyle(
            fontSize: 12,
            color: Colors.red,
          ),
        ),
      );
      wChilds.add(
        SizedBox(
          width: 5,
        ),
      );
    }
    wChilds.add(Text(
      "${widget.article.author}${widget.article.shareUser}",
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    ));
    wChilds.add(SizedBox(
      width: 5,
    ));
    wChilds.add(Text(
      widget.article.niceDate,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    ));

//    wChilds.add(Padding(
//      padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
//      child: Text(
//          widget.article.niceDate,
//          style: TextStyle(
//            fontSize: 12,
//            color: Colors.grey,
//          ),
//      ),
//    ));

    return wChilds;
  }
}
