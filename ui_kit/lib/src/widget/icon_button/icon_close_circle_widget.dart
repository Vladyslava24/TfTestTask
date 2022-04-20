import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/themes.dart';

class IconCloseCircleWidget extends StatelessWidget {
  final Function action;
  final Color backgroundColor;
  final Color iconColor;
  final EdgeInsets margin;

  const IconCloseCircleWidget({
    required this.action,
    this.backgroundColor = AppColorScheme.colorBlack3,
    this.iconColor = AppColorScheme.colorPrimaryWhite,
    this.margin = const EdgeInsets.only(right: 14.0),
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36.0,
        height: 36.0,
        margin: margin,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: InkResponse(
            onTap: () => action(),
            radius: 18.0,
            child: Icon(
              Icons.close,
              color: iconColor,
              size: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
