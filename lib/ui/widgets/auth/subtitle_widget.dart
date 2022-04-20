import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class SubTitleWidget extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const SubTitleWidget({
    @required this.text,
    this.padding = const EdgeInsets.only(bottom: 20.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(text,
          style: textRegular16.copyWith(color: AppColorScheme.colorBlack9),
          textAlign: TextAlign.left),
    );
  }
}
