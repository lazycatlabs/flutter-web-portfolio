import 'package:flutter/material.dart';

const double _hiddenFactor = 3;

class AnimatedBoxSlider extends AnimatedWidget {
  const AnimatedBoxSlider({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
    this.visibleBoxAnimation,
    this.invisibleBoxAnimation,
    this.visibleBoxCurve = Curves.fastOutSlowIn,
    this.invisibleBoxCurve = Curves.fastOutSlowIn,
  }) : super(listenable: controller);

  final AnimationController controller;
  final double width;
  final double height;
  final Curve visibleBoxCurve;
  final Curve invisibleBoxCurve;
  final Animation<double>? visibleBoxAnimation;
  final Animation<double>? invisibleBoxAnimation;

  Animation<double> get _visibleAnimation =>
      visibleBoxAnimation ??
      Tween<double>(begin: 0, end: width - (_hiddenFactor * 2)).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0, 0.5, curve: visibleBoxCurve),
        ),
      );

  Animation<double> get _invisibleAnimation =>
      Tween<double>(begin: 0, end: width).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 1.0, curve: invisibleBoxCurve),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            top: _hiddenFactor,
            left: _hiddenFactor,
            child: Container(
              width: (_visibleAnimation.value > (_hiddenFactor * 2))
                  ? _visibleAnimation.value - (_hiddenFactor * 2)
                  : _visibleAnimation.value,
              height: height - (_hiddenFactor * 2),
              color: controller.isCompleted
                  ? Colors.transparent
                  : Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: controller.isCompleted ? 0 : _invisibleAnimation.value,
              height: controller.isCompleted ? 0 : height,
              color: controller.isCompleted
                  ? Colors.transparent
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
