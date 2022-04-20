import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AlternateAuthWidget extends StatelessWidget {
  final String text;
  final String actionText;
  final Function onPressed;

  const AlternateAuthWidget(
      {@required this.text,
      @required this.actionText,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColorScheme.colorBlack7)),
          Container(width: 2.0),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            child: Container(
              constraints: BoxConstraints(minWidth: 50.0),
              height: 24,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  actionText,
                  textAlign: TextAlign.center,
                  style: title16.copyWith(color: AppColorScheme.colorYellow),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
