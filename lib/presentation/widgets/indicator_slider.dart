import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';

// ignore: must_be_immutable
class IndicatorSlider extends StatelessWidget {
  final bool isActive;
  Color? activeColour;
  Color? inActiveColour;

  IndicatorSlider({
    super.key,
    required this.isActive,
    this.activeColour,
    this.inActiveColour,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.all(Dimens.space2),
      width: isActive ? Dimens.space10 : Dimens.space8,
      height: isActive ? Dimens.space10 : Dimens.space8,
      decoration: BoxDecoration(
        color: isActive
            ? activeColour ?? Palette.offWhite
            : inActiveColour ?? Palette.offWhite.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}
