import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BaseSocialButton extends StatelessWidget {
  final Function onTap;
  final Icon icon;
  final double size;
  final double iconW;
  final double iconH;
  final double radius;
  final Color color;

  BaseSocialButton({
    @required this.icon,
    @required this.onTap,
    this.size = 48.0,
    this.iconW = 18.0,
    this.iconH = 18.0,
    this.radius = elButtonBorderRadius,
    this.color = AppColorScheme.colorPrimaryWhite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: icon != null ? Center(child: icon) : SizedBox.shrink(),
      ),
    );
  }
}
