import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';

class SingleWorkoutsFilterIconWidget extends StatelessWidget {
  final Function callback;
  final EdgeInsets margin;

  const SingleWorkoutsFilterIconWidget({
    @required this.callback,
    this.margin = const EdgeInsets.only(left: 16.0, right: 8.0),
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColorScheme.colorBlack4,
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          filterIcon,
        ),
        onPressed: callback,
      ),
    );
  }
}
