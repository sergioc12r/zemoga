import 'dart:math';
import 'package:flutter/material.dart';

class BasePlaceHolderAnimation extends StatefulWidget {

  const BasePlaceHolderAnimation({Key? key}) : super(key: key);

  @override
  _BasePlaceHolderAnimationState createState() =>
      _BasePlaceHolderAnimationState();
}

class _BasePlaceHolderAnimationState extends State<BasePlaceHolderAnimation>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? alpha;


  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),)
      ..addStatusListener(animationListener);
    controller?.repeat();

    alpha = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller!, curve: MyCurve()));




    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: alpha!, child: Container(color: Colors.white),);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void animationListener(AnimationStatus status) {
    if(status == AnimationStatus.completed)
      controller?.reverse();
  }
}

class MyCurve extends Curve {
  @override
  double transform(double t) {
    return (1-cos(2*pi*t))*0.25+0.1;
  }
}
