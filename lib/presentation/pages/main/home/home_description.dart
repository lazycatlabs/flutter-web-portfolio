import 'package:flutter/material.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeDescription extends StatelessWidget {
  const HomeDescription({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTextBox(
            animationController: animationController,
            text: "${Constants.get.appName}.",
            maxLines: 3,
            textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: responsiveSize(
                    context,
                    Dimens.space36,
                    Dimens.h1,
                    tablet: Dimens.h2,
                  ),
                ),
          ),
          AnimatedTextBox(
            animationController: animationController,
            text: Strings.of(context)!.appDesc,
            heightFactor: responsiveSize(context, 2, 1),
            maxLines: responsiveSize(context, 2, 1).toInt(),
            textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: responsiveSize(
                    context,
                    Dimens.body2,
                    Dimens.space17,
                  ),
                ),
          ),
          SpacerV(value: Dimens.space24),
          AnimatedWidgetShape(
            animationController: animationController,
            width: Dimens.space150,
            height: Dimens.buttonH,
            child: Button(
              targetWidth: Dimens.space150,
              title: Strings.of(context)!.seeMyBlog,
              onPressed: () {
                launchUrlString(Constants.get.blogUrl);
              },
            ),
          ),
        ],
      ),
    );
  }
}
