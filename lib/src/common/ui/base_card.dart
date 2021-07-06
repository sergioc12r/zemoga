import 'package:flutter/material.dart';
import 'package:zemoga/src/common/utils/colors.dart';

class BaseCard extends StatelessWidget {
  final EdgeInsets? padding, margin;
  final Widget? child;
  final Color backgroundColor;
  final double radius;
  final List<BoxShadow> boxShadow;
  final DecorationImage? backgroundImage;
  final BoxConstraints? constraints;
  final Gradient? gradient;

  const BaseCard({
    Key? key,
    this.padding: const EdgeInsets.all(10),
    this.margin,
    this.backgroundColor: Colors.white,
    this.radius: 12,
    this.child,
    this.boxShadow: const [ZemogaColors.defaultShadow],
    this.constraints,
    this.backgroundImage,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
          color: gradient == null ? backgroundColor : null,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: boxShadow,
          gradient: gradient,
          image: backgroundImage),
      child: Material(
        color: gradient == null ? backgroundColor : Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(radius),
        child: Padding(padding: padding!, child: child),
      ),
    );
  }
}
