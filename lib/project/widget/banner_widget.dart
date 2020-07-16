import 'package:FlutterProject/project/service/config/image_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WybBannerItem extends StatelessWidget {
  final String url;
  final BoxFit fit;

  WybBannerItem(this.url, {this.fit: BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: Card(
        child: CachedNetworkImage(
            imageUrl: ImageHelper.wrapUrl(url),
            placeholder: (context, url) =>
                Center(child: CupertinoActivityIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: fit),
      ),
    );
  }
}