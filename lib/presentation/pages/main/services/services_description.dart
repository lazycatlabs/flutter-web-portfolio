import 'package:flutter/material.dart';
import 'package:lazycatlabs/data/datasources/datasources.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

class ServicesDescription extends StatelessWidget {
  const ServicesDescription({
    super.key,
    required this.animationController,
    required this.listServices,
  });

  final AnimationController animationController;
  final List<DataHelper> listServices;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveSize(
          context,
          Dimens.space30,
          Dimens.space200,
          tablet: Dimens.space180,
        ),
      ),
      child: AnimatedWidgetShape(
        animationController: animationController,
        width: context.widthInPercent(100),
        height: responsiveSize(
          context,
          context.heightInPercent(70),
          Dimens.space250,
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: responsiveSize(context, -10, -40),
              child: Icon(
                Icons.format_quote,
                color: Theme.of(context).cardColor,
                size: responsiveSize(context, Dimens.space100, Dimens.space150),
              ),
            ),
            Positioned(
              left: 0,
              bottom: responsiveSize(context, -10, -40),
              child: RotatedBox(
                quarterTurns: 90,
                child: Icon(
                  Icons.format_quote,
                  color: Theme.of(context).cardColor,
                  size:
                      responsiveSize(context, Dimens.space100, Dimens.space150),
                ),
              ),
            ),
            Center(
              child: Wrap(
                spacing: responsiveSize(
                  context,
                  Dimens.space50,
                  Dimens.space64,
                ),
                runSpacing: Dimens.space16,
                children: listServices.map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Responsive.isMobile(context)) ...{
                        _mobile(context, e)
                      } else ...{
                        ..._desktop(context, e)
                      },
                      const SpacerV(),
                      Text(
                        e.desc ?? "",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: responsiveSize(
                                context,
                                Dimens.body2,
                                Dimens.subtitle1,
                              ),
                            ),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobile(BuildContext context, DataHelper e) => Row(
        children: [
          Icon(e.icon, size: Dimens.space36),
          SpacerH(value: Dimens.space16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Dimens.space250,
              maxHeight: Dimens.space50,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: Dimens.space8,
                  child: Opacity(
                    opacity: 0.05,
                    child: Text(
                      e.title ?? "",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: Dimens.space36,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    e.title ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: Dimens.space30),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  List<Widget> _desktop(BuildContext context, DataHelper e) => [
        Icon(e.icon, size: Dimens.space50),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Dimens.space300,
            maxHeight: Dimens.bottomBar - Dimens.space16,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: Dimens.space8,
                child: Opacity(
                  opacity: 0.05,
                  child: Text(
                    e.title ?? "",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  e.title ?? "",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
      ];
}
