import 'package:flutter/material.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/data/datasources/datasources.dart';
import 'package:lazycatlabs/di/di.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveSize(
          context,
          Dimens.space24,
          context.widthInPercent(15),
          tablet: context.widthInPercent(13),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: responsiveSize(
              context,
              Dimens.space50,
              Dimens.space120,
              tablet: Dimens.space72,
            ),
            top: responsiveSize(context, -10, -40, tablet: -20),
            child: Icon(
              Icons.format_quote,
              color: Theme.of(context).cardColor,
              size: responsiveSize(
                context,
                Dimens.space50,
                Dimens.space150,
                tablet: Dimens.space72,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextBox(
                text: Strings.of(context)!.hello,
                textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: responsiveSize(
                        context,
                        Dimens.space36,
                        Dimens.h1,
                        tablet: Dimens.h3,
                      ),
                    ),
                animationController: animationController,
              ),
              AnimatedWidgetShape(
                animationController: animationController,
                width: context.widthInPercent(100),
                height: responsiveSize(
                  context,
                  Dimens.space200,
                  Dimens.space150,
                  tablet: Dimens.space120,
                ),
                child: RichText(
                  text: TextSpan(
                    text: Strings.of(context)!.profileTitle,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: responsiveSize(
                            context,
                            Dimens.body1,
                            Dimens.h6,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                    children: [
                      TextSpan(
                        text: Strings.of(context)!.profileDesc,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: responsiveSize(
                                context,
                                Dimens.body2,
                                Dimens.space17,
                              ),
                            ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              if (sl<PrefManager>().locale != "en")
                SpacerV(value: Dimens.space16),
              AnimatedWidgetShape(
                width: Dimens.space250,
                height: Dimens.space24,
                animationController: animationController,
                child: const ProfileButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
