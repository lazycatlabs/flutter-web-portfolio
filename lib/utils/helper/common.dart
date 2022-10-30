import 'package:flutter/material.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:logger/logger.dart';

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    lineLength: 110,
  ),
);

Size textSize({
  required String text,
  required TextStyle? style,
  int maxLines = 1,
  double maxWidth = double.infinity,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  return textPainter.size;
}

double responsiveSize(
  BuildContext context,
  double mobile,
  double desktop, {
  double? tablet,
}) {
  if (Responsive.isDesktop(context)) {
    return desktop;
  } else if (Responsive.isTablet(context)) {
    return tablet ?? mobile;
  } else {
    return mobile;
  }
}

const durationShort = Duration(milliseconds: 400);
const durationLong = Duration(milliseconds: 1500);
