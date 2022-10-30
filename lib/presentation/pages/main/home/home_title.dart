import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShape(
      animationController: animationController,
      width: responsiveSize(
        context,
        Dimens.space130 + Dimens.space12,
        Dimens.space200 + Dimens.space12,
        tablet: Dimens.space150 + Dimens.space12,
      ),
      height: responsiveSize(
        context,
        Dimens.space130 + Dimens.space12,
        Dimens.space200 + Dimens.space12,
        tablet: Dimens.space150 + Dimens.space12,
      ),
      boxShape: BoxShape.circle,
      child: Stack(
        children: [
          CircleAvatar(
            radius: Dimens.space24,
            backgroundColor: Theme.of(context).cardColor,
          ),
          CircleAvatar(
            radius: responsiveSize(
                  context,
                  Dimens.space64,
                  Dimens.space150,
                  tablet: Dimens.space72,
                ) +
                Dimens.space12,
            backgroundColor: Theme.of(context).cardColor,
            child: CircleAvatar(
              backgroundImage: AssetImage(Images.icAvatar),
              radius: responsiveSize(
                context,
                Dimens.space58,
                Dimens.space92,
                tablet: Dimens.space72,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
