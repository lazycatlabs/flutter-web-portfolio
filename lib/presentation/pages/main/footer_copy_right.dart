import 'package:flutter/material.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

class FooterCopyRight extends StatelessWidget {
  const FooterCopyRight({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: Dimens.space16),
      child: Column(
        children: [
          Text(
            "\u00a9 ${DateTime.now().year} ${Constants.get.appName}",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${Strings.of(context)!.createdWith} ",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const Icon(Icons.favorite, color: Palette.red),
              Text(
                " ${Strings.of(context)!.and} ",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const FlutterLogo(),
            ],
          ),
        ],
      ),
    );
  }
}
