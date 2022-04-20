import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_kit/src/theme/assets.dart';

class IconBackCircleWidget extends StatelessWidget {
  static const double iconSize = 36.0;

  final Function? action;
  final EdgeInsets margin;

  const IconBackCircleWidget({
    required this.action,
    this.margin = const EdgeInsets.only(left: 2.0),
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return action != null ? Center(
      child: Container(
        margin: margin,
        child: InkWell(
          onTap: () => action!(),
          borderRadius: BorderRadius.circular(iconSize),
          child: SvgPicture.asset(
            arrowBackCircleIcon,
            width: iconSize,
            height: iconSize,
          ),
        ),
      ),
    ) : const SizedBox();
  }
}