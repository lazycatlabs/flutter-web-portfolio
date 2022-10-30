import 'package:flutter/material.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/data/data.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({
    super.key,
    required this.isVisible,
  });

  final Function(bool) isVisible;

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  bool? _temp;
  bool _isVisible = true;
  bool _isFirst = true;
  final int _visibilityPercent = 50;

  List<DataHelper> _listServices = [];
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: durationLong,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listServices = [
      DataHelper(
        title: Strings.of(context)!.buildTitle,
        desc: Strings.of(context)!.buildDesc,
        icon: Icons.build_circle,
      ),
      DataHelper(
        title: Strings.of(context)!.fixTitle,
        desc: Strings.of(context)!.fixDesc,
        icon: Icons.bug_report_rounded,
      ),
      DataHelper(
        title: Strings.of(context)!.continueTitle,
        desc: Strings.of(context)!.continueDesc,
        icon: Icons.next_plan,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: const Key("services"),
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
                child: ServicesTitle(animationController: _animationController),
              ),
              SpacerV(
                value: responsiveSize(context, Dimens.space8, Dimens.space50),
              ),
              ServicesDescription(
                animationController: _animationController,
                listServices: _listServices,
              ),
              SpacerV(value: Dimens.space100),
            ],
          ),
        ),
      ),
    );
  }
}
