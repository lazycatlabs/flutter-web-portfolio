import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({
    super.key,
    required this.isVisible,
    required this.onScrollTap,
  });

  final Function(bool) isVisible;
  final VoidCallback onScrollTap;

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with TickerProviderStateMixin {
  bool? _temp;
  bool _isVisible = true;
  final int _visibilityPercent = 70;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: durationLong,
  )..forward();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: const Key("home"),
        onVisibilityChanged: (VisibilityInfo info) {
          final visiblePercentage = info.visibleFraction * 100;

          if (_temp == null) {
            _temp = visiblePercentage > _visibilityPercent;
            widget.isVisible(_temp ?? true);
            setState(() {
              _isVisible = _temp ?? true;
            });
          } else {
            if (_temp != visiblePercentage > _visibilityPercent) {
              _temp = visiblePercentage > _visibilityPercent;
              widget.isVisible(_temp ?? true);
              setState(() {
                _isVisible = _temp ?? true;
              });
            }
          }
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: context.widthInPercent(100),
            minHeight: context.heightInPercent(100),
          ),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: context.widthInPercent(100),
                  minHeight: context.heightInPercent(100),
                ),
                child: Align(
                  alignment: Alignment(
                    responsiveSize(context, -1.2, -1.25, tablet: -1.20),
                    responsiveSize(context, -1.3, -1.5, tablet: -1.3),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).cardColor,
                    radius: responsiveSize(
                      context,
                      Dimens.space72,
                      Dimens.space200,
                      tablet: Dimens.space120,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!Responsive.isMobile(context)) const SpacerV(value: 0),
                    Responsive(
                      builder: (_, constrains) {
                        if (constrains.maxWidth <
                            const RefinedBreakpoints().tabletNormal) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HomeTitle(
                                animationController: _animationController,
                              ),
                              HomeDescription(
                                animationController: _animationController,
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsiveSize(
                                context,
                                Dimens.space16,
                                context.widthInPercent(5),
                                tablet: context.widthInPercent(7),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: HomeDescription(
                                    animationController: _animationController,
                                  ),
                                ),
                                HomeTitle(
                                  animationController: _animationController,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    AnimatedOpacity(
                      duration: durationShort,
                      opacity: _isVisible ? 1 : 0,
                      child: Align(
                        alignment: const Alignment(0, 0.8),
                        child: GestureDetector(
                          onTap: widget.onScrollTap,
                          child: const AnimatedMouse(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
