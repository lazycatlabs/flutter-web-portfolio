import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazycatlabs/core/localization/localization.dart';
import 'package:lazycatlabs/data/datasources/datasources.dart';
import 'package:lazycatlabs/di/di.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PortfolioDescription extends StatefulWidget {
  const PortfolioDescription({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  State<PortfolioDescription> createState() => _PortfolioDescriptionState();
}

class _PortfolioDescriptionState extends State<PortfolioDescription> {
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(viewportFraction: 0.9);

  List<Data> _portfolioEn = [];
  List<Data> _portfolioId = [];
  List<Data> _portfolio = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final id =
          await rootBundle.loadString("assets/static_api/portfolio_id.json");
      if (!mounted) return;
      final en =
          await rootBundle.loadString("assets/static_api/portfolio_en.json");

      _portfolioEn = PortfolioResponse.fromJson(jsonDecode(en)).data ?? [];
      _portfolioId = PortfolioResponse.fromJson(jsonDecode(id)).data ?? [];
      _portfolio =
          sl<PrefManager>().locale == "en" ? _portfolioEn : _portfolioId;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _portfolio = sl<PrefManager>().locale == "en" ? _portfolioEn : _portfolioId;
  }

  int _indexPageView = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedWidgetShape(
          animationController: widget.animationController,
          width: context.widthInPercent(100),
          height: context.heightInPercent(responsiveSize(context, 68, 65)),
          child: SizedBox(
            height: context.heightInPercent(responsiveSize(context, 68, 65)),
            child: Responsive.isMobile(context)
                ? PageView.builder(
                    controller: pageController,
                    itemCount: _portfolio.length,
                    onPageChanged: (currentIndex) {
                      setState(() {
                        for (final element in _portfolio) {
                          element.onClick = false;
                        }
                        _indexPageView = currentIndex;
                      });
                    },
                    itemBuilder: (_, index) {
                      return AnimatedContainer(
                        duration: durationShort,
                        margin: EdgeInsets.only(
                          left: Dimens.space4,
                          right: Dimens.space4,
                          top: _indexPageView == index ? 0 : Dimens.space30,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Dimens.cornerRadius),
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildItemHeader(index),
                            _buildItemFooter(index),
                          ],
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _portfolio.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        onEnter: (_) => setState(() {
                          _portfolio[index].onHover = true;
                        }),
                        onExit: (_) => setState(() {
                          _portfolio[index].onHover = false;
                          _portfolio[index].onClick = false;
                        }),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: Dimens.space400,
                          margin: EdgeInsets.only(
                            left: index == 0 ? Dimens.space100 : Dimens.space12,
                            right: index == _portfolio.length - 1
                                ? Dimens.space100
                                : Dimens.space12,
                            top: (_portfolio[index].onHover ||
                                    _portfolio[index].onClick)
                                ? 0
                                : Dimens.space30,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimens.cornerRadius),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildItemHeader(index),
                              _buildItemFooter(index),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        SpacerV(value: Dimens.space16),
        ScrollIndicator(
          width: Dimens.space16,
          height: Dimens.space12,
          alignment: const Alignment(0, 0.95),
          indicatorWidth: Dimens.space24,
          scrollController: scrollController,
          pageController: pageController,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.cornerRadius),
            ),
          ),
          indicatorDecoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.cornerRadius),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItemHeader(int index) {
    return AnimatedContainer(
      duration: durationShort,
      width: double.maxFinite,
      height: _portfolio[index].onClick
          ? context.heightInPercent(responsiveSize(context, 68, 65))
          : responsiveSize(
              context,
              Dimens.space120,
              Dimens.space200,
              tablet: Dimens.space180,
            ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.space16),
          topRight: Radius.circular(Dimens.space16),
          bottomLeft: Radius.circular(
            _portfolio[index].onClick ? Dimens.space16 : 0,
          ),
          bottomRight: Radius.circular(
            _portfolio[index].onClick ? Dimens.space16 : 0,
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              itemCount: _portfolio[index].images!.length,
              onPageChanged: (int active) {
                setState(() {
                  _portfolio[index].activeIndex = active;
                });
              },
              scrollDirection: Responsive.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              itemBuilder: (_, indexImage) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      width: double.maxFinite,
                      _portfolio[index].images![indexImage],
                      fit: _portfolio[index].onClick
                          ? BoxFit.fitWidth
                          : BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            if (!_portfolio[index].onClick) ...{
                              Colors.black12,
                              Colors.black45,
                              Colors.black54,
                            } else ...{
                              Colors.transparent,
                            },
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              left: -2,
              right: -2,
              bottom: -2,
              child: Container(
                padding: EdgeInsets.all(Dimens.space16),
                color: _portfolio[index].onClick
                    ? Colors.black45
                    : Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _portfolio[index].title!,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Palette.white,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      for (int i = 0; i < _portfolio[index].images!.length; i++)
                        IndicatorSlider(
                          isActive: i == _portfolio[index].activeIndex,
                        ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimens.space16),
                    bottomLeft: Radius.circular(Dimens.space16),
                  ),
                  color: Colors.black45,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.space4,
                  vertical: Dimens.space8,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        splashRadius: Dimens.space8,
                        icon: Icon(
                          _portfolio[index].onClick
                              ? Icons.zoom_in_map
                              : Icons.zoom_out_map,
                        ),
                        color: Palette.white,
                        onPressed: () {
                          setState(() {
                            _portfolio[index].onClick =
                                !_portfolio[index].onClick;
                          });
                        },
                      ),
                    ),
                    if (Responsive.isMobile(context)) ...{
                      const SpacerV(),
                      for (int i = 0; i < _portfolio[index].images!.length; i++)
                        IndicatorSlider(
                          isActive: i == _portfolio[index].activeIndex,
                        ),
                    }
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemFooter(int index) {
    return Expanded(
      child: Visibility(
        visible: !_portfolio[index].onClick,
        child: Padding(
          padding: EdgeInsets.all(Dimens.space16),
          child: Stack(
            children: [
              Text(
                _portfolio[index].descriptions ?? "",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  runSpacing: Dimens.space16,
                  spacing: Dimens.space16,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: Dimens.space8,
                      spacing: Dimens.space8,
                      children: [
                        Text(
                          Strings.of(context)!.tags,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        for (final String item in _portfolio[index].tag ?? [])
                          Chip(
                            label: Text(
                              item,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          )
                      ],
                    ),
                    Wrap(
                      spacing: Dimens.space16,
                      runSpacing: Dimens.space8,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (_portfolio[index].playStore!.isNotEmpty)
                          Button(
                            targetWidth: Dimens.space120,
                            title: Constants.get.playStore,
                            onPressed: () {
                              launchUrlString(
                                _portfolio[index].playStore!,
                              );
                            },
                          ),
                        if (_portfolio[index].appStore!.isNotEmpty)
                          Button(
                            targetWidth: Dimens.space120,
                            title: Constants.get.appStore,
                            onPressed: () {
                              launchUrlString(
                                _portfolio[index].appStore!,
                              );
                            },
                          )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
