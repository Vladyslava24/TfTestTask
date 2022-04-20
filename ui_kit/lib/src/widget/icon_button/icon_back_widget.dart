import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/colors.dart';

class IconBackWidget extends StatelessWidget {
  static const double splashRadius = 18.0;
  static const double iconSize = 18.0;
  static const double paddingLeft = 6.0;
  static const double marginIcon = -4.0;

  final Function? action;
  final Color? iconColor;

  const IconBackWidget({
    required this.action,
    this.iconColor = AppColorScheme.colorPrimaryWhite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return action != null ? Container(
      margin: const EdgeInsets.only(left: paddingLeft),
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => action!(),
        splashRadius: splashRadius,
        splashColor: AppColorScheme.colorBlack3,
        highlightColor: AppColorScheme.colorBlack3,
        iconSize: iconSize,
        icon: Stack(
          children: [
            Positioned.fill(
              left: marginIcon,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    ) : const SizedBox();
  }
}