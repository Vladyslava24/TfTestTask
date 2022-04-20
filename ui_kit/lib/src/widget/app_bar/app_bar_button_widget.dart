import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/themes.dart';

class AppBarButtonWidget extends StatelessWidget {
  final String? text;
  final Function? action;
  final bool withArrow;
  final ButtonType buttonType;

  const AppBarButtonWidget({
    required this.text,
    this.action,
    this.withArrow = false,
    this.buttonType = ButtonType.text,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buttonType == ButtonType.text && action != null ? CupertinoButton(
      alignment: Alignment.centerLeft,
      onPressed: () => action!(),
      child: text != null ? Row(
        children: [
          Text(
            text!,
            style: title14.copyWith(color: AppColorScheme.colorYellow, height: 1.5),
            textAlign: TextAlign.left,
          ),
          withArrow ?
            Container(
              margin: const EdgeInsets.only(left: 2.0),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.0,
                color: AppColorScheme.colorYellow,
              ),
            ) :
            const SizedBox.shrink()
        ],
      ) : const SizedBox()
    ) : action != null ? GestureDetector(
      onTap: () => action!(),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: AppColorScheme.colorYellow,
          ),
          child: text != null ?
          Text(
            text!,
            style: title14.copyWith(color: AppColorScheme.colorBlack, height: 1),
          ) : const SizedBox(),
        ),
      ),
    ) : const SizedBox();
  }
}

enum ButtonType { text, elevated }