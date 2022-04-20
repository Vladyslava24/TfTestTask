import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';


class BadgeOnBoardingWidget extends StatelessWidget {
  final String text;
  final Color color;

  const BadgeOnBoardingWidget({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 6.0,
          ),
          color: color,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: textRegular12.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ),
      ),
    );
  }
}
