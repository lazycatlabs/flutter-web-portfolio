import 'package:flutter/material.dart';
import 'package:lazycatlabs/data/datasources/local/pref_manager.dart';

class DataHelper {
  final String? title;
  final String? desc;
  bool isSelected;
  final String? iconPath;
  final IconData? icon;
  final String? url;
  final String? type;
  final int? id;
  final ActiveTheme activeTheme;
  final AnimationController? animationController;
  Animation? animation;
  ColorTween? colorTween;
  VoidCallback? onPressed;
  Color? iconColor;
  bool onHover;

  DataHelper({
    this.title,
    this.desc,
    this.isSelected = false,
    this.iconPath,
    this.icon,
    this.url,
    this.type,
    this.id,
    this.activeTheme = ActiveTheme.system,
    this.animationController,
    this.animation,
    this.colorTween,
    this.onPressed,
    this.iconColor,
    this.onHover = false,
  }) {
    if (animationController != null && colorTween != null) {
      animation = colorTween!.animate(animationController!);
    }
  }
}
