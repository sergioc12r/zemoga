import 'package:flutter/material.dart';
import 'package:zemoga/src/common/ui/base_place_holder_animation.dart';
import 'package:zemoga/src/common/utils/colors.dart';

mixin PlaceholderMixin {
  Widget emptyContainer(
      {double maxWidth: 200,
        double maxHeight: 20,
        EdgeInsets? padding,
        EdgeInsets? margin,
        Color color: ZemogaColors.grayBackground}) {
    return Container(
      padding: padding,
      margin: margin,
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        minWidth: 30,
        minHeight: 12,
      ),
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: ClipRRect(
        child: BasePlaceHolderAnimation(),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        circleContainer(),
        Container(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              emptyContainer(maxHeight: 45, maxWidth: 300),
              Divider(
                height: 26,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget circleContainer({double size: 30}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ZemogaColors.grayBackground,
        ),
        child: ClipRRect(
          child: BasePlaceHolderAnimation(),
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ),
    );
  }
}
