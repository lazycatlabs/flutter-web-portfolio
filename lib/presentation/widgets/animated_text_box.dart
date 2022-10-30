import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/helper/common.dart';

class AnimatedTextBox extends StatefulWidget {
  const AnimatedTextBox({
    super.key,
    required this.text,
    required this.textStyle,
    required this.animationController,
    this.maxLines = 1,
    this.widthFactor = 1,
    this.heightFactor = 1,
    this.width = double.infinity,
    this.visibleAnimationCurve = Curves.fastOutSlowIn,
    this.invisibleAnimationCurve = Curves.fastOutSlowIn,
    this.slideAnimationCurve = Curves.fastOutSlowIn,
    this.visibleBoxAnimation,
    this.invisibleBoxAnimation,
    this.position,
    this.textAlign,
  });

  final String text;
  final TextStyle textStyle;
  final AnimationController animationController;
  final Animation<double>? visibleBoxAnimation;
  final Animation<double>? invisibleBoxAnimation;
  final Animation<Offset>? position;
  final Curve visibleAnimationCurve;
  final Curve invisibleAnimationCurve;
  final Curve slideAnimationCurve;
  final double width;
  final int maxLines;
  final double heightFactor;
  final double widthFactor;
  final TextAlign? textAlign;

  @override
  State<AnimatedTextBox> createState() => _AnimatedTextBoxState();
}

class _AnimatedTextBoxState extends State<AnimatedTextBox>
    with SingleTickerProviderStateMixin {
  late final Size _size = textSize(
    text: widget.text,
    style: widget.textStyle,
    maxWidth: widget.width,
    maxLines: widget.maxLines,
  );
  late final double _textWidth = _size.width * widget.widthFactor;

  late final double _textHeight = _size.height * widget.heightFactor;

  late Animation<double> visibleAnimation = widget.visibleBoxAnimation ??
      Tween<double>(begin: 0, end: _textWidth).animate(
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
          Tween<double>(begin: 0, end: _textWidth).animate(
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
      Rect.fromLTWH(0, _textHeight, _textWidth, _textHeight),
      Size(_textWidth, _textHeight),
    ),
    end: RelativeRect.fromSize(
      Rect.fromLTWH(0, 0, _textWidth, _textHeight),
      Size(_textWidth, _textHeight),
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
      height: _textHeight,
      child: Stack(
        children: [
          AnimatedBoxSlider(
            controller: widget.animationController,
            width: _textWidth,
            height: _textHeight,
            visibleBoxAnimation: visibleAnimation,
            invisibleBoxAnimation: invisibleAnimation,
          ),
          PositionedTransition(
            rect: _textPositionAnimation,
            child: Text(
              widget.text,
              style: widget.textStyle,
              textAlign: widget.textAlign,
            ),
          ),
        ],
      ),
    );
  }
}
