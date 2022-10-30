import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazycatlabs/data/datasources/datasources.dart';
import 'package:lazycatlabs/di/di.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    super.key,
    required this.scaffold,
    required this.listMenu,
    required this.scrollController,
    required this.duration,
    required this.listActiveTheme,
    required this.onSelectedTheme,
    required this.listLanguage,
    required this.onSelectedLanguage,
  });

  final GlobalKey<ScaffoldState> scaffold;
  final List<DataHelper> listMenu;
  final ScrollController scrollController;
  final int duration;
  final List<ActiveTheme> listActiveTheme;
  final Function(ActiveTheme) onSelectedTheme;
  final List<DataHelper> listLanguage;

  final Function(DataHelper) onSelectedLanguage;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Drawer(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimens.space16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Images.icLogoTextOneline,
                    height: Dimens.space30,
                  ),
                  InkWell(
                    onTap: () => widget.scaffold.currentState?.closeDrawer(),
                    child: SvgPicture.asset(
                      Images.icClose,
                      height: Dimens.space24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),
            SpacerV(value: Dimens.space16),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimens.space16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: widget.listActiveTheme
                              .map(
                                (data) => IconButton(
                                  onPressed: () {
                                    widget.onSelectedTheme.call(data);
                                    context.read<MainCubit>().updateTheme(data);
                                  },
                                  icon: Icon(
                                    data.icon,
                                    color:
                                        data == sl<MainCubit>().getActiveTheme()
                                            ? Palette.primary
                                            : Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Container(
                          color: Theme.of(context).cardColor,
                          width: Dimens.space16,
                          height: Dimens.space3,
                        ),
                        Column(
                          children: widget.listLanguage
                              .map(
                                (data) => IconButton(
                                  onPressed: () {
                                    widget.onSelectedLanguage.call(data);

                                    /// Reload theme
                                    context
                                        .read<MainCubit>()
                                        .updateLanguage(data.type ?? "en");
                                  },
                                  icon: Text(
                                    (data.type ?? "-").toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          color: data.type ==
                                                  sl<PrefManager>().locale
                                              ? Palette.primary
                                              : Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.listMenu.asMap().entries.map((e) {
                          return TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimens.space20,
                                vertical: Dimens.space20,
                              ),
                              shape: const BeveledRectangleBorder(),
                              backgroundColor:
                                  e.value.animation!.value as Color,
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () {
                              setState(() {
                                for (final item in widget.listMenu) {
                                  item.isSelected = false;
                                }
                                e.value.isSelected = true;

                                Navigator.pop(context);

                                widget.scrollController.animateTo(
                                  e.key * (context.heightInPercent(100)),
                                  duration:
                                      Duration(milliseconds: widget.duration),
                                  curve: Curves.linear,
                                );
                              });
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: widget.duration),
                                    opacity: e.value.isSelected ? 0.2 : 0,
                                    child: Text(
                                      e.value.title ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(
                                            fontSize: Dimens.space42,
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: Dimens.space16),
                                  child: AnimatedOpacity(
                                    duration:
                                        Duration(milliseconds: widget.duration),
                                    opacity: e.value.isSelected ? 1 : 0.3,
                                    child: Text(
                                      e.value.title ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                            fontSize: Dimens.h4,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FooterCopyRight(context: context),
          ],
        ),
      ),
    );
  }
}
