import 'package:flutter/material.dart';

class ScreenSize {
  final double width;
  final double height;
  static const SMALL = ScreenSize._(360, 600);
  static const MEDIUM = ScreenSize._(400, 680);
  static const LARGE = ScreenSize._(480, 730);
  static const EXTRA_LARGE = ScreenSize._(600, 790);

  const ScreenSize._(this.width, this.height);

  static ScreenSize getFor(double width) {
    if (width < MEDIUM.width) {
      return SMALL;
    }
    if (width < LARGE.width) {
      return MEDIUM;
    }
    if (width < EXTRA_LARGE.width) {
      return LARGE;
    }
    return EXTRA_LARGE;
  }

  static ScreenSize getForHeight(double height) {
    if (height < MEDIUM.height) {
      return SMALL;
    }
    if (height < LARGE.height) {
      return MEDIUM;
    }
    if (height < EXTRA_LARGE.height) {
      return LARGE;
    }
    return EXTRA_LARGE;
  }
}

bool isScreenSmall(Size size) => (size.height < 700);