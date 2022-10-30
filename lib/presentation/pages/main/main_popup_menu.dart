import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/data/datasources/datasources.dart';
import 'package:lazycatlabs/presentation/presentation.dart';

class MainPopupMenu extends StatelessWidget {
  const MainPopupMenu({
    super.key,
    required this.listTheme,
    required this.selectedTheme,
    required this.onSelectedTheme,
    required this.selectedLanguage,
    required this.listLanguage,
    required this.onSelectedLanguage,
  });

  final List<ActiveTheme> listTheme;
  final ActiveTheme selectedTheme;
  final Function(ActiveTheme) onSelectedTheme;
  final DataHelper selectedLanguage;

  final List<DataHelper> listLanguage;
  final Function(DataHelper) onSelectedLanguage;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      splashRadius: Dimens.space20,
      icon: const Icon(Icons.more_vert_outlined),
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: PopupMenuButton<ActiveTheme>(
            initialValue: selectedTheme,
            padding: EdgeInsets.zero,
            itemBuilder: (context) => listTheme
                .map(
                  (data) => PopupMenuItem(
                    value: data,
                    onTap: () {
                      onSelectedTheme.call(data);
                      context.read<MainCubit>().updateTheme(data);
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(data.icon),
                        const SpacerH(),
                        Text(
                          _getThemeName(data, context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            child: Padding(
              padding: EdgeInsets.all(Dimens.space16),
              child: Row(
                children: [
                  Text(
                    Strings.of(context)!.chooseTheme,
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_right_rounded),
                ],
              ),
            ),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: PopupMenuButton<DataHelper>(
            initialValue: selectedLanguage,
            padding: EdgeInsets.zero,
            itemBuilder: (context) => listLanguage
                .map(
                  (data) => PopupMenuItem(
                    value: data,
                    onTap: () {
                      onSelectedLanguage.call(data);

                      /// Reload theme
                      context
                          .read<MainCubit>()
                          .updateLanguage(data.type ?? "en");

                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      data.title ?? "-",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                )
                .toList(),
            child: Padding(
              padding: EdgeInsets.all(Dimens.space16),
              child: Row(
                children: [
                  Text(
                    Strings.of(context)!.chooseLanguage,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_right_rounded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getThemeName(ActiveTheme activeTheme, BuildContext context) {
    if (activeTheme == ActiveTheme.system) {
      return Strings.of(context)!.themeSystem;
    } else if (activeTheme == ActiveTheme.dark) {
      return Strings.of(context)!.themeDark;
    } else {
      return Strings.of(context)!.themeLight;
    }
  }
}
