import 'package:flutter/material.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

class PortfolioTitle extends StatelessWidget {
  const PortfolioTitle({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShape(
      animationController: animationController,
      width: responsiveSize(
        context,
        context.widthInPercent(45),
        context.widthInPercent(32),
        tablet: Dimens.space250,
      ),
      height: responsiveSize(
        context,
        Dimens.space100,
        Dimens.space200,
        tablet: Dimens.space120,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 0,
            child: Icon(
              Icons.circle,
              color: Theme.of(context).cardColor,
              size: responsiveSize(context, Dimens.space72, Dimens.space150),
            ),
          ),
          Positioned(
            left: 0,
            bottom: responsiveSize(
              context,
              Dimens.space20,
              Dimens.space30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Strings.of(context)!.portfolio,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: responsiveSize(
                          context,
                          Dimens.space36,
                          Dimens.h1,
                          tablet: Dimens.h3,
                        ),
                      ),
                ),
                Text(
                  Strings.of(context)!.portfolioDesc,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize:
                            responsiveSize(context, Dimens.body1, Dimens.h6),
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
