import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WybDashedLine extends StatelessWidget {


  final Axis axis;
  final double dashedWidth;
  final double dashedHeight;
  final int count;
  final Color color;
  WybDashedLine({
    this.axis = Axis.horizontal,
    this.dashedHeight = 1,
    this.dashedWidth = 1,
    this.color = Colors.red,
    this.count = 10
});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: axis,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(count, (index){
        return SizedBox(
          width: dashedWidth,
          height: dashedHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
          ),

        );

      }),

    );
  }


}
