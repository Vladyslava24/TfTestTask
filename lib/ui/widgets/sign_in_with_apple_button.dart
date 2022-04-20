import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

//Todo check it for relevance in the Future
/// A `Sign in with Apple` button according to the Apple Guidelines.
///
/// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/
class SignInWithAppleActionButton extends StatelessWidget {
  const SignInWithAppleActionButton(
      {Key key,
      @required this.onPressed,
      this.text = 'Sign in with Apple',
      this.icon,
      this.isEnable = true,
      this.color = AppColorScheme.colorYellow,
      this.textColor = AppColorScheme.colorPrimaryBlack,
      this.padding = const EdgeInsets.all(16)})
      : assert(text != null),
        super(key: key);

  final EdgeInsets padding;
  final Color color;
  final Color textColor;
  final bool isEnable;
  final Icon icon;

  /// The callback that is be called when the button is pressed.
  final VoidCallback onPressed;

  /// The text to display next to the Apple logo.
  ///
  /// Defaults to `Sign in with Apple`.
  final String text;

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
              child: Container(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon != null
                        ? Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: icon,
                          )
                        : Container(),
                    Center(
                      child: Text(
                        text.toUpperCase(),
                        style: TextStyle(
                            color: isEnable
                                ? textColor
                                : AppColorScheme.colorPrimaryBlack),
                      ),
                    ),
                  ],
                ),
              ),
              color: color,
              onPressed: isEnable ? () => onPressed() : null),
        ),
      ],
    );
  }
}
