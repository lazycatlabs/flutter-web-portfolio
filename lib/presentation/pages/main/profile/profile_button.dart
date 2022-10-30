import 'package:flutter/material.dart';
import 'package:lazycatlabs/data/data.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DataHelper> buttons = [
      DataHelper(
        title: Constants.get.linkedIn,
        iconPath: Images.icLinkedIn,
        iconColor: Palette.linkedIn,
        url: Constants.get.linkedInUrl,
      ),
      DataHelper(
        title: Constants.get.upwork,
        iconPath: Images.icUpwork,
        url: Constants.get.upworkUrl,
      ),
      DataHelper(
        title: Constants.get.github,
        iconPath: Images.icGithub,
        iconColor: Theme.of(context).textTheme.bodyText1?.color,
        url: Constants.get.githubUrl,
      ),
    ];

    return Wrap(
      runSpacing: Dimens.space16,
      spacing: Dimens.space16,
      children: buttons
          .asMap()
          .entries
          .map(
            (element) => Wrap(
              children: [
                AnimatedTextStrikethrough(
                  text: element.value.title ?? "",
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(decoration: TextDecoration.underline),
                  textStyleHover: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w500),
                  duration: const Duration(milliseconds: 400),
                  onTap: () {
                    launchUrlString(element.value.url!);
                  },
                ),
                if (element.key < buttons.length - 1) ...{
                  SpacerH(value: Dimens.space16),
                  Text(
                    "/",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                }
              ],
            ),
          )
          .toList(),
    );
  }
}
