import 'package:flutter/material.dart';
import 'package:lazycatlabs/utils/helper/common.dart';

class AnimatedTextStrikethrough extends StatefulWidget {
  const AnimatedTextStrikethrough({
    super.key,
    required this.text,
    required this.textStyle,
    required this.textStyleHover,
    required this.duration,
    this.thickness = 2,
    required this.onTap,
  });

  final String text;
  final TextStyle textStyle;
  final TextStyle textStyleHover;
  final Duration duration;
  final VoidCallback onTap;
  final double thickness;

  @override
  State<AnimatedTextStrikethrough> createState() =>
      _AnimatedTextStrikethroughState();
}

class _AnimatedTextStrikethroughState extends State<AnimatedTextStrikethrough>
    with TickerProviderStateMixin {
  late final AnimationController _forwardController =
      AnimationController(vsync: this, duration: widget.duration)
        ..addListener(() {
          setState(() {});
        });

  late final AnimationController _backwardController =
      AnimationController(vsync: this, duration: widget.duration)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _backwardController.reset();
            _forwardController.reset();
          }
        });

  late final double _textWidth =
      textSize(text: widget.text, style: widget.textStyle).width;
  late final double _textHeight =
      textSize(text: widget.text, style: widget.textStyle).height;

  late final Animation<double> _forwardAnimation =
      Tween<double>(begin: 0, end: _textWidth).animate(
    CurvedAnimation(parent: _forwardController, curve: Curves.fastOutSlowIn),
  );
  late final Animation<double> _backwardAnimation =
      Tween<double>(begin: 0, end: _textWidth).animate(
    CurvedAnimation(parent: _backwardController, curve: Curves.fastOutSlowIn),
  );

  bool _isHover = false;

  @override
  void dispose() {
    _forwardController.dispose();
    _backwardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap.call,
      hoverColor: Colors.transparent,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: Stack(
          children: [
            Positioned(
              top: (_textHeight / 2) - widget.thickness,
              child: Container(
                height: widget.thickness,
                color: Theme.of(context).textTheme.bodyText1?.color,
                width: _forwardAnimation.value,
              ),
            ),
            Positioned(
              top: (_textHeight / 2) - widget.thickness,
              child: Container(
                height: widget.thickness,
                color: Theme.of(context).scaffoldBackgroundColor,
                width: _backwardAnimation.value,
              ),
            ),
            Text(
              widget.text,
              style: _isHover ? widget.textStyleHover : widget.textStyle,
            ),
          ],
        ),
      ),
    );
  }

  void _onHover(bool hovering) {
    if (hovering) {
      setState(() {
        _forwardController.forward();
        _isHover = hovering;
      });
    } else {
      setState(() {
        _backwardController.forward();
        _isHover = hovering;
      });
    }
  }
}
