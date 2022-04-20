import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';


class BaseCheckBoxCircleWidget extends StatelessWidget {
  final double size;
  final double iconSize;
  final Color background;
  final Color iconColor;
  final EdgeInsets iconPadding;

  const BaseCheckBoxCircleWidget(
      {this.size = 36.0,
      this.iconSize = 28.0,
      this.background = Colors.transparent,
      this.iconColor = AppColorScheme.colorPrimaryWhite,
      this.iconPadding = const EdgeInsets.all(0.0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: iconPadding,
        child: Icon(
          Icons.done,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
