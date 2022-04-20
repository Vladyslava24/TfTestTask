import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final EdgeInsets padding;

  const TitleWidget({
    @required this.title,
    this.padding = const EdgeInsets.only(bottom: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(title, style: title30, textAlign: TextAlign.left),
    );
  }
}
