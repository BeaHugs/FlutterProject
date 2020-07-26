import 'package:FlutterProject/project/viewmodel/flutter_webview.dart';
import 'package:FlutterProject/project/widget/article_tag.dart';
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
          return WebViewExample(widget.article.link);
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
              _buildArticleAuthorInfo(),
              buildArticleTitle(),
              buildArticleWidget()
            ],
        ),
      ),
    );
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

  Widget _buildArticleAuthorInfo() {
    
    return Row(
      children: [
        ClipOval(
          child: WrapperImage(
            imageType: ImageType.random,
            url: widget.article.author,
            height: 20,
            width: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            isNotBlank(widget.article.author)
                ? widget.article.author
                : widget.article.shareUser ?? '',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Expanded(
          child: SizedBox.shrink(),
        ),
        Text(widget.article.niceDate,
            style: Theme.of(context).textTheme.caption),
      ],
    );
  }
}
