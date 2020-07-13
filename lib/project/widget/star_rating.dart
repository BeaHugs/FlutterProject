import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WybStarWidget extends StatefulWidget {
  final double starSize;
  final Color unstarColor;
  final Color isstarColor;
  final double rating;
  final double maxRating;
  final int count;

  final Widget unWidget;
  final Widget isWidget;

  WybStarWidget({
    @required this.rating,
    this.maxRating = 10,
    this.count = 5,
    this.starSize = 40,
    this.unstarColor = Colors.grey,
    this.isstarColor = Colors.red,
    Widget unWidget,
    Widget isWidget,
  })  : unWidget = unWidget ??
            Icon(
              Icons.star_border,
              size: starSize,
              color: unstarColor,
            ),
        isWidget = isWidget ??
            Icon(
              Icons.star,
              size: starSize,
              color: isstarColor,
            );

  @override
  _WybStarWidgetState createState() => _WybStarWidgetState();
}

class _WybStarWidgetState extends State<WybStarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _unselected(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _isselected(),
        ),
      ],
    );
  }

  List<Widget> _unselected() {

   final unWidget =  widget.unWidget;

    return List.generate(widget.count, (index) {
      return unWidget;
    });
  }

  List<Widget> _isselected() {

    final isWidget =  widget.isWidget;

    List<Widget> stars = [];

    //一颗星的值
    double oneValue = widget.maxRating / widget.count;

    //选中的星  比如3.5 等于3颗整的
    int count = (widget.rating / oneValue).floor();

    //添加选中的星
    for (int i = 0; i < count; i++) {
      stars.add(isWidget);
    }

    //小于一颗的星需要裁减(裁减的比例)
    double leftWidth = ((widget.rating / oneValue) - count) * widget.starSize;

    final halfStar = ClipRect(
        clipper: WybCustomRect(width: leftWidth),
        child: isWidget);

    stars.add(halfStar);

    return stars;
  }
}

/**
 * 裁减
 */
class WybCustomRect extends CustomClipper<Rect> {
  double width;

  WybCustomRect({this.width});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(WybCustomRect oldClipper) {
    return oldClipper.width != this.width;
  }
}
