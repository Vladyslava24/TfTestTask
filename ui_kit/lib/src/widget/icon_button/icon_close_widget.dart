import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/themes.dart';

class IconCloseWidget extends StatelessWidget {

  static const double splashRadius = 18.0;
  static const double iconSize = 24.0;
  static const double defaultPadding = 7.0;

  final Function? action;
  final EdgeInsets padding;

  const IconCloseWidget({
    this.padding = const EdgeInsets.only(right: defaultPadding),
    required this.action,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return action != null ? Container(
      padding: padding,
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () => action!(),
        splashRadius: splashRadius,
        splashColor: AppColorScheme.colorBlack3,
        highlightColor: AppColorScheme.colorBlack3,
        iconSize: iconSize,
        icon: const Icon(
          Icons.close,
          color: AppColorScheme.colorPrimaryWhite,
        ),
      ),
    ) : const SizedBox();
  }
}
