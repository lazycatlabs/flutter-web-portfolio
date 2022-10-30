import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    super.key,
    required this.isVisible,
  });

  final Function(bool) isVisible;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection>
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
        key: const Key("profile"),
        onVisibilityChanged: (VisibilityInfo info) {
          final visiblePercentage = info.visibleFraction * 100;

          if (_temp == null) {
            _temp = visiblePercentage > _visibilityPercent;
            widget.isVisible(_temp ?? true);
            setState(() {
              _isVisible = _temp ?? true;
            });
          } else {
            if (_temp != visiblePercentage.isVisible()) {
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
                child: ProfileTitle(animationController: _animationController),
              ),
              SpacerV(
                value: responsiveSize(
                  context,
                  Dimens.space16,
                  Dimens.space50,
                  tablet: Dimens.space30,
                ),
              ),
              ProfileDescription(animationController: _animationController),
              SpacerV(value: Dimens.space100),
            ],
          ),
        ),
      ),
    );
  }
}
