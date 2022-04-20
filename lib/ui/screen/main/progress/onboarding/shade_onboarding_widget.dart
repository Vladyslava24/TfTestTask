import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ShadeOnBoardingWidget extends StatelessWidget {
  const ShadeOnBoardingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColorScheme.colorBlack.withOpacity(0.8));
  }
}
