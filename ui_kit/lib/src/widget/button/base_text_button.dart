import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/themes.dart';

class BaseTextButton extends StatelessWidget {
  final String? text;
  final Function? action;
  final bool withArrow;
  final Color textColor;
  final Color arrowColor;

  const BaseTextButton({
    required this.text,
    this.textColor = AppColorScheme.colorYellow,
    this.arrowColor = AppColorScheme.colorYellow,
    this.action,
    this.withArrow = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      alignment: Alignment.centerLeft,
      onPressed: action != null ? () => action!() : null,
      child: text != null ? Row(
        children: [
          Text(
            text!,
            style: title14.copyWith(color: textColor, height: 1.5),
            textAlign: TextAlign.left,
          ),
          withArrow ?
            Container(
              margin: const EdgeInsets.only(left: 2.0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.0,
                color: arrowColor,
              ),
            ) :
            const SizedBox.shrink()
        ],
      ) : const SizedBox()
    );
  }
}