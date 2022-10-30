import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({
    super.key,
    required this.isVisible,
  });

  final Function(bool) isVisible;

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection>
    with TickerProviderStateMixin {
  bool? _temp;
  bool _isVisible = true;
  bool _isFirst = true;
  final int _visibilityPercent = 50;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: durationLong,
  );

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: const Key("portfolio"),
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

          if (_isVisible && _isFirst) {
            _animationController.forward();
            _isFirst = false;
          }
          // log.d('Widget ${info.key} is $visiblePercentage% visible');
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: context.widthInPercent(100),
            minHeight: context.heightInPercent(100),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child:
                    PortfolioTitle(animationController: _animationController),
              ),
              SpacerV(
                value: responsiveSize(context, Dimens.space2, Dimens.space8),
              ),
              PortfolioDescription(
                animationController: _animationController,
              ),
              SpacerV(value: Dimens.space100),
            ],
          ),
        ),
      ),
    );
  }
}
