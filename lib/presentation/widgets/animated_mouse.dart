import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';

class AnimatedMouse extends StatefulWidget {
  const AnimatedMouse({super.key});

  @override
  State<AnimatedMouse> createState() => _AnimatedMouseState();
}

class _AnimatedMouseState extends State<AnimatedMouse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Alignment> _animatedAlign =
      Tween(begin: Alignment.topCenter, end: const Alignment(0, 0.45))
          .animate(_animationController);

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: Dimens.space30,
          height: Dimens.space36 * 1.3,
          alignment: _animatedAlign.value,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.space30),
            border: Border.all(
              color: Palette.hint,
              width: Dimens.space3,
            ),
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity:
                _animationController.status == AnimationStatus.forward ? 1 : 0,
            child: Container(
              width: Dimens.space4,
              height: Dimens.space12,
              decoration: BoxDecoration(
                color: Palette.hint,
                borderRadius: BorderRadius.circular(Dimens.space8),
              ),
            ),
          ),
        );
      },
    );
  }
}
