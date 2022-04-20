import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';

class SingleWorkoutsErrorWidget extends StatelessWidget {
  final Function callback;

  const SingleWorkoutsErrorWidget({
    @required this.callback,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.infinity,
        height: 214.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColorScheme.colorBlack2
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                reloadIcon
              ),
              SizedBox(height: 8.0),
              Text(
                S.of(context).explore_error_btn_text,
                style: textRegular16.copyWith(color: AppColorScheme.colorBlack9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
