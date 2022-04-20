import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

Widget premiumIndicator({bool leftPositioned = false}) => Positioned(
    top: 12,
    left: leftPositioned ? 12.0 : null,
    right: leftPositioned ? null : 2.0,
    child: SafeArea(child: IconLockWidget()));
