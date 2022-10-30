import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';

///*********************************************
/// Created by ukieTux on 23/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/Lzyct <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Button extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final double? startWidth;
  final double targetWidth;
  final double height;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final Color? splashColor;
  final Offset startOffset;
  final Offset targetOffset;
  final Widget? child;
  final Duration duration;
  final BorderRadiusGeometry startBorderRadius;
  final BorderRadiusGeometry? endBorderRadius;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.titleColor,
    this.fontSize,
    this.splashColor,
    this.startOffset = Offset.zero,
    this.targetOffset = const Offset(0.1, 0),
    this.startWidth = 45,
    this.targetWidth = 150,
    this.height = 45,
    this.child,
    this.duration = const Duration(
      milliseconds: 300,
    ),
    this.startBorderRadius =
        const BorderRadius.all(Radius.circular(Dimens.cornerButton)),
    this.endBorderRadius,
    this.color,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  late Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: widget.startOffset,
    end: widget.targetOffset,
  ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
    ..addListener(() {
      setState(() {});
    });

  bool _isHovering = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setOnHover(isHover: true),
      onExit: (_) => setOnHover(),
      child: SlideTransition(
        position: offsetAnimation,
        child: InkWell(
          hoverColor: Colors.transparent,
          onTap: widget.onPressed,
          onTapDown: (_) => setOnHover(isHover: true),
          onTapCancel: () => setOnHover(),
          onTapUp: (_) => setOnHover(),
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimens.cornerButton)),
          child: SizedBox(
            width: widget.targetWidth,
            height: widget.height,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: AnimatedContainer(
                    duration: widget.duration,
                    width: _isHovering ? widget.targetWidth : widget.startWidth,
                    alignment: Alignment.centerLeft,
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: widget.color ??
                          Theme.of(context).buttonTheme.colorScheme?.background,
                      borderRadius: _isHovering
                          ? (widget.endBorderRadius ?? widget.startBorderRadius)
                          : widget.startBorderRadius,
                    ),
                  ),
                ),
                Positioned(
                  top: widget.height / 3,
                  width: widget.targetWidth,
                  child: Center(
                    child: widget.child ??
                        Text(
                          widget.title.toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setOnHover({bool isHover = false}) {
    setState(() {
      if (isHover) {
        _isHovering = true;
        controller.forward();
      } else {
        _isHovering = false;
        controller.reverse();
      }
    });
  }
}
