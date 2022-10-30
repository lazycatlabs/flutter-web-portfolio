import 'package:flutter/material.dart';

import '../../utils/utils.dart';

enum DisplayType {
  desktop,
  tablet,
  mobile,
}

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  ) builder;

  static DisplayType displayTypeOf(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= const RefinedBreakpoints().desktopNormal) {
      return DisplayType.desktop;
    } else if (width >= const RefinedBreakpoints().tabletNormal) {
      return DisplayType.tablet;
    } else {
      return DisplayType.mobile;
    }
  }

  /// Returns a boolean if we are in a display of [DisplayType.desktop]. Used to
  /// build adaptive and responsive layouts.
  static bool isDesktop(BuildContext context) {
    return displayTypeOf(context) == DisplayType.desktop;
  }

  /// Returns a boolean if we are in a display of [DisplayType.mobile]. Used to
  /// build adaptive and responsive layouts.
  static bool isMobile(BuildContext context) {
    return displayTypeOf(context) == DisplayType.mobile;
  }

  static bool isTablet(BuildContext context) {
    return displayTypeOf(context) == DisplayType.tablet;
  }

  @override
  Widget build(BuildContext context) {
    log.d("Display type ${displayTypeOf(context)}");
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, constraints);
      },
    );
  }
}

class RefinedBreakpoints {
  final double mobileSmall;
  final double mobileNormal;
  final double mobileLarge;
  final double mobileExtraLarge;

  final double tabletSmall;
  final double tabletNormal;
  final double tabletLarge;
  final double tabletExtraLarge;

  final double desktopSmall;
  final double desktopNormal;
  final double desktopLarge;
  final double desktopExtraLarge;

  const RefinedBreakpoints({
    this.mobileSmall = 320,
    this.mobileNormal = 375,
    this.mobileLarge = 414,
    this.mobileExtraLarge = 480,
    this.tabletSmall = 600,
    this.tabletNormal = 768,
    this.tabletLarge = 850,
    this.tabletExtraLarge = 900,
    this.desktopSmall = 950,
    this.desktopNormal = 1366,
    this.desktopLarge = 3840,
    this.desktopExtraLarge = 4096,
  });

  @override
  String toString() {
    return "Desktop: Small - $desktopSmall Normal - $desktopNormal Large - $desktopLarge ExtraLarge - $desktopExtraLarge\nTablet: Small - $tabletSmall Normal - $tabletNormal Large - $tabletLarge ExtraLarge - $tabletExtraLarge\nMobile: Small - $mobileSmall Normal - $mobileNormal Large - $mobileLarge ExtraLarge - $mobileExtraLarge";
  }
}
