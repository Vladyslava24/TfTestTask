import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class DotWidget extends StatelessWidget {
  final Color color;

  const DotWidget({
    this.color = AppColorScheme.colorPrimaryWhite,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
    );
  }
}
