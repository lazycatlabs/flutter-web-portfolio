import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/data/data.dart';
import 'package:lazycatlabs/di/di.dart';
import 'package:lazycatlabs/presentation/pages/main/main_popup_menu.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';

///*********************************************
/// Created by ukietux on 25/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/Lzyct <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late ActiveTheme _selectedTheme;

  late final List<DataHelper> _listLanguage = [
    DataHelper(title: Constants.get.english, type: "en"),
    DataHelper(title: Constants.get.bahasa, type: "id"),
  ];
  late DataHelper _selectedLanguage =
      sl<PrefManager>().locale == "en" ? _listLanguage[0] : _listLanguage[1];

  List<DataHelper> _listAppbarMenu = [];

  final List<ActiveTheme> _listTheme = [
    ActiveTheme.system,
    ActiveTheme.light,
    ActiveTheme.dark,
  ];

  final int _duration = 400;
  int _selectedMenu = 0;

  late final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    /// Set saved theme
    _selectedTheme = sl<MainCubit>().getActiveTheme();
    context.read<MainCubit>().updateTheme(_selectedTheme);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listAppbarMenu = [
      DataHelper(
        title: Strings.of(context)!.home,
        isSelected: true,
        animationController: AnimationController(
          duration: const Duration(seconds: 1),
          vsync: this,
          reverseDuration: Duration(microseconds: _duration),
        ),
        colorTween: ColorTween(
          begin: Theme.of(context).canvasColor,
          end: Theme.of(context).cardColor,
        ),
      ),
      DataHelper(
        title: Strings.of(context)!.profile,
        animationController: AnimationController(
          duration: const Duration(seconds: 1),
          vsync: this,
          reverseDuration: Duration(microseconds: _duration),
        ),
        colorTween: ColorTween(
          begin: Theme.of(context).canvasColor,
          end: Theme.of(context).cardColor,
        ),
      ),
      DataHelper(
        title: Strings.of(context)!.services,
        animationController: AnimationController(
          duration: const Duration(seconds: 1),
          vsync: this,
          reverseDuration: Duration(microseconds: _duration),
        ),
        colorTween: ColorTween(
          begin: Theme.of(context).canvasColor,
          end: Theme.of(context).cardColor,
        ),
      ),
      DataHelper(
        title: Strings.of(context)!.portfolio,
        animationController: AnimationController(
          duration: const Duration(seconds: 1),
          vsync: this,
          reverseDuration: Duration(microseconds: _duration),
        ),
        colorTween: ColorTween(
          begin: Theme.of(context).canvasColor,
          end: Theme.of(context).cardColor,
        ),
      ),
    ];
    _updateIsSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title:
          "${Constants.get.appName} | ${_listAppbarMenu[_selectedMenu].title}",
      color: Theme.of(context).textTheme.bodyText1!.color!,
      child: Parent(
        scaffoldKey: _scaffoldKey,
        drawer: Responsive.isMobile(context)
            ? MainDrawer(
                scaffold: _scaffoldKey,
                listMenu: _listAppbarMenu,
                duration: _duration,
                scrollController: _scrollController,
                listActiveTheme: _listTheme,
                onSelectedTheme: (data) {
                  setState(() {
                    _selectedTheme = data;
                  });
                },
                listLanguage: _listLanguage,
                onSelectedLanguage: (data) {
                  setState(() {
                    _selectedLanguage = data;
                  });
                },
              )
            : null,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 3024, maxHeight: 1440),
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                actions: _actionMenu(),
                pinned: true,
                elevation: Dimens.zero,
                centerTitle: false,
                leading: const SizedBox(),
                leadingWidth: Dimens.zero,
                title: SvgPicture.asset(
                  Images.icLogoTextOneline,
                  height: kToolbarHeight - Dimens.space24,
                ),
              ),
              HomeSection(
                isVisible: (isVisible) {
                  if (isVisible) {
                    _selectedMenu = 0;
                    _updateIsSelected();
                  }
                },
                onScrollTap: () {
                  _scrollController.animateTo(
                    context.heightInPercent(100),
                    duration: Duration(milliseconds: _duration),
                    curve: Curves.linear,
                  );
                },
              ),
              ProfileSection(
                isVisible: (isVisible) {
                  if (isVisible) {
                    _selectedMenu = 1;
                    _updateIsSelected();
                  }
                },
              ),
              ServicesSection(
                isVisible: (isVisible) {
                  if (isVisible) {
                    _selectedMenu = 2;
                    _updateIsSelected();
                  }
                },
              ),
              PortfolioSection(
                isVisible: (isVisible) {
                  if (isVisible) {
                    _selectedMenu = 3;
                    _updateIsSelected();
                  }
                },
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }

  void _updateIsSelected() {
    setState(() {
      for (final item in _listAppbarMenu) {
        item.isSelected = false;
      }
      _listAppbarMenu[_selectedMenu].isSelected = true;
    });
  }

  List<Widget> _actionMenu() {
    return [
      AnimatedSwitcher(
        duration: Duration(milliseconds: _duration),
        child: Responsive.isMobile(context)
            ? IconButton(
                onPressed: () {
                  if (_scaffoldKey.currentState == null) return;

                  if (_scaffoldKey.currentState!.isDrawerOpen) {
                    _scaffoldKey.currentState!.closeDrawer();
                  } else {
                    _scaffoldKey.currentState!.openDrawer();
                  }
                },
                icon: SvgPicture.asset(
                  Images.icMenu,
                  color: Theme.of(context).iconTheme.color,
                ),
              )
            : const SizedBox(),
      ),
      if (!Responsive.isMobile(context)) ...{
        AnimatedSwitcher(
          duration: Duration(milliseconds: _duration),
          child: Responsive.isMobile(context)
              ? const SizedBox()
              : MainMenu(
                  scrollController: _scrollController,
                  duration: _duration,
                  listMenu: _listAppbarMenu,
                ),
        ),
        MainPopupMenu(
          listTheme: _listTheme,
          selectedTheme: _selectedTheme,
          selectedLanguage: _selectedLanguage,
          listLanguage: _listLanguage,
          onSelectedLanguage: (language) {
            _selectedLanguage = language;
          },
          onSelectedTheme: (activeTheme) {
            _selectedTheme = activeTheme;
          },
        ),
        const SpacerH(),
      },
    ];
  }
}
