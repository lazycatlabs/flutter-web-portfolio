import 'package:flutter/material.dart';
import 'package:lazycatlabs/data/datasources/datasources.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    super.key,
    required this.listMenu,
    required this.scrollController,
    required this.duration,
  });

  final List<DataHelper> listMenu;
  final ScrollController scrollController;
  final int duration;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: widget.listMenu.asMap().entries.map((e) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.space10),
          child: Row(
            children: [
              AnimatedOpacity(
                opacity: e.value.isSelected ? 1 : 0,
                duration: Duration(milliseconds: widget.duration),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Palette.primary,
                      radius: Dimens.space2,
                    ),
                    SpacerH(value: Dimens.space2),
                  ],
                ),
              ),
              AnimatedTextStrikethrough(
                text: e.value.title ?? "",
                textStyle: Theme.of(context).textTheme.bodyText1!,
                textStyleHover: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w500),
                duration: Duration(milliseconds: widget.duration),
                onTap: () {
                  setState(() {
                    for (final item in widget.listMenu) {
                      item.isSelected = false;
                    }
                    e.value.isSelected = true;

                    widget.scrollController.animateTo(
                      e.key * (context.heightInPercent(100)),
                      duration: Duration(milliseconds: widget.duration),
                      curve: Curves.linear,
                    );
                  });
                },
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
