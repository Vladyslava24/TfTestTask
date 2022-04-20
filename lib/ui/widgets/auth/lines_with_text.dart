import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class LinesWithText extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const LinesWithText(
      {@required this.text, this.padding = const EdgeInsets.all(0.0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 57.0, height: 1.0, color: AppColorScheme.colorBlack4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(text,
                style:
                    textRegular16.copyWith(color: AppColorScheme.colorBlack7)),
          ),
          Container(
              width: 57.0, height: 1.0, color: AppColorScheme.colorBlack4),
        ],
      ),
    );
  }
}
