import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../image.dart';

/**
 * 文章标题-->首页列表/收藏列表
 */
Widget buildArticleTitle(String title) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
    child: Text(
      title != null ? title : "文章title",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
      ),
    ),
  );
}


/**
 * 作者信息
 */
Widget buildArticleAuthorInfo(BuildContext context,{String author,String niceDate}) {
  return Row(
    children: [
      ClipOval(
        child: WrapperImage(
          imageType: ImageType.random,
          url: author,
          height: 20,
          width: 20,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          author,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      Expanded(
        child: SizedBox.shrink(),
      ),
      Text(niceDate,
          style: Theme.of(context).textTheme.caption),
    ],
  );
}

