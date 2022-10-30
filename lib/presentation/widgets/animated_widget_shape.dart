import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';

class AnimatedWidgetShape extends StatefulWidget {
  const AnimatedWidgetShape({
    super.key,
    required this.child,
    required this.animationController,
    required this.width,
    required this.height,
    this.visibleAnimationCurve = Curves.fastOutSlowIn,
    this.invisibleAnimationCurve = Curves.fastOutSlowIn,
    this.slideAnimationCurve = Curves.fastOutSlowIn,
    this.visibleBoxAnimation,
    this.invisibleBoxAnimation,
    this.position,
    this.boxShape = BoxShape.rectangle,
  });

  final Widget child;
  final AnimationController animationController;
  final Animation<double>? visibleBoxAnimation;
  final Animation<double>? invisibleBoxAnimation;
  final Animation<Offset>? position;
  final Curve visibleAnimationCurve;
  final Curve invisibleAnimationCurve;
  final Curve slideAnimationCurve;
  final double width;
  final double height;
  final BoxShape boxShape;

  @override
  State<AnimatedWidgetShape> createState() => _AnimatedWidgetShapeState();
}

class _AnimatedWidgetShapeState extends State<AnimatedWidgetShape>
    with SingleTickerProviderStateMixin {
  late Animation<double> visibleAnimation = widget.visibleBoxAnimation ??
      Tween<double>(begin: 0, end: widget.width).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: Interval(
            0,
            0.35,
            curve: widget.visibleAnimationCurve,
          ),
        ),
      );

  late Animation<double> invisibleAnimation =
      invisibleAnimation = widget.invisibleBoxAnimation ??
          Tween<double>(begin: 0, end: widget.width).animate(
            CurvedAnimation(
              parent: widget.animationController,
              curve: Interval(
                0.35,
                0.7,
                curve: widget.invisibleAnimationCurve,
              ),
            ),
          );

  late final Animation<RelativeRect> _textPositionAnimation = RelativeRectTween(
    begin: RelativeRect.fromSize(
      Rect.fromLTWH(0, widget.height, widget.width, widget.height),
      Size(widget.width, widget.height),
    ),
    end: RelativeRect.fromSize(
      Rect.fromLTWH(0, 0, widget.width, widget.height),
      Size(widget.width, widget.height),
    ),
  ).animate(
    CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(0.6, 1.0, curve: widget.invisibleAnimationCurve),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          AnimatedWidgetSlider(
            controller: widget.animationController,
            width: widget.width,
            height: widget.height,
            visibleBoxAnimation: visibleAnimation,
            invisibleBoxAnimation: invisibleAnimation,
            boxShape: widget.boxShape,
          ),
          PositionedTransition(
            rect: _textPositionAnimation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
