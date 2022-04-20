import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/themes.dart';

class IconSettingsWidget extends StatelessWidget {

  static const double iconSize = 24.0;
  static const double inkRadius = 18.0;
  static const double defaultLeftPadding = 6.0;
  static const double defaultRightPadding = 8.0;

  final Function? action;
  final Alignment position;
  final EdgeInsets padding;

  const IconSettingsWidget.leading({
    this.action,
    this.position = Alignment.centerLeft,
    this.padding = const EdgeInsets.only(left: defaultLeftPadding),
    Key? key
  }) : super(key: key);

  const IconSettingsWidget.actions({
    this.action,
    this.position = Alignment.centerRight,
    this.padding = const EdgeInsets.only(right: defaultRightPadding),
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return action != null ? Container(
      padding: padding,
      alignment: position,
      child: IconButton(
        onPressed: () => action!(),
        splashRadius: inkRadius,
        iconSize: iconSize,
        splashColor: AppColorScheme.colorBlack3,
        highlightColor: AppColorScheme.colorBlack3,
        icon: const Icon(
          Icons.settings_sharp,
          color: AppColorScheme.colorPrimaryWhite,
        ),
      ),
    ) : const SizedBox();
  }
}