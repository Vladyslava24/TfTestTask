import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/src/theme/assets.dart';

class IconLockWidget extends StatelessWidget {

  final double iconSize;
  final EdgeInsets padding;

  const IconLockWidget({
    this.padding = const EdgeInsets.only(right: 14.0),
    this.iconSize = 32.0,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: padding,
        child: SvgPicture.asset(
          lockCircleIcon,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}
