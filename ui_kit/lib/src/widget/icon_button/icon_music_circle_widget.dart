import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/src/theme/assets.dart';
import 'package:ui_kit/src/theme/colors.dart';

class IconMusicCircleWidget extends StatelessWidget {
  static const double iconSize = 20.0;
  static const double circleSize = 36.0;
  static const double inkRadius = 20.0;

  final Function? action;
  final Alignment position;
  final EdgeInsets margin;

  const IconMusicCircleWidget({
    this.action,
    this.position = Alignment.center,
    this.margin = const EdgeInsets.all(0.0),
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return action != null ? GestureDetector(
      onTap: () => action!(),
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          color: AppColorScheme.colorBlack3,
          shape: BoxShape.circle
        ),
        margin: margin,
        // alignment: position,
        child: Center(
          child: SvgPicture.asset(musicIcon)
        ),
      ),
    ) : const SizedBox();
  }
}
