import 'package:FlutterProject/project/viewmodel/flutter_webview.dart';
import 'package:FlutterProject/project/widget/article_tag.dart';
import 'package:FlutterProject/project/widget/common/article_item.dart';
import 'package:FlutterProject/project/widget/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterProject/project/models/article.dart';
import 'package:quiver/strings.dart';

class WybContentListItem extends StatefulWidget {
  final Data article;

  WybContentListItem(this.article);

  @override
  _WybContentListItemState createState() => _WybContentListItemState();
}

class _WybContentListItemState extends State<WybContentListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
          return WebViewExample(widget.article);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, width: 0.7),
        )),
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildArticleAuthorInfo(context,author: isNotBlank(widget.article.author)
                  ? widget.article.author
                  : widget.article.shareUser ?? '',niceDate:widget.article.niceDate ),
              buildArticleTitle(widget.article.title),
              buildArticleWidget()
            ],
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
      wChilds.add(WybArticleTag("置顶"));
    }

    wChilds.add(Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text(
        (widget.article.superChapterName != null
                ? widget.article.superChapterName + ' · '
                : '') +
            (widget.article.chapterName ?? ''),
        style: TextStyle(
          fontSize: 10,
        ),
      ),
    ));
    return wChilds;
  }

}
