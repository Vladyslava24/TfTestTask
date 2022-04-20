import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final Icon? icon;
  final bool isEnable;
  final String? fontFamily;
  final FontWeight fontWeight;
  final double letterSpacing;
  final double height;
  final double width;

  const ActionButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.fontFamily,
    this.padding = const EdgeInsets.all(16),
    this.color = AppColorScheme.colorYellow,
    this.textColor = AppColorScheme.colorPrimaryBlack,
    this.isEnable = true,
    this.fontWeight = FontWeight.w400,
    this.letterSpacing = 0,
    this.height = 48,
    this.width = double.infinity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Padding(
            padding: padding,
            child: FlatButton(
                disabledColor: AppColorScheme.colorBlack4,
                disabledTextColor: AppColorScheme.colorPrimaryBlack,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: SizedBox(
                    width: width,
                    height: height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icon != null
                            ? Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: icon,
                              )
                            : Container(),
                        Center(
                          child: Text(
                            text,
                            style: TextStyle(
                              color: isEnable
                                  ? textColor
                                  : AppColorScheme.colorPrimaryBlack,
                              fontFamily: fontFamily ?? 'Roboto',
                              letterSpacing: letterSpacing,
                              fontWeight: fontWeight,
                            ),
                          ),
                        ),
                      ],
                    )),
                color: color,
                onPressed: isEnable ? () => onPressed() : null)),
      ],
    );
  }
}
