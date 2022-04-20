import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class TitleOnBoardingWidget extends StatelessWidget {
  const TitleOnBoardingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: S.of(context).progress_header_item_title,
        style: title20.copyWith(
          color: AppColorScheme.colorPrimaryWhite,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Today',
            style: TextStyle(
              color: AppColorScheme.colorYellow,
            ),
          ),
        ],
      ),
    );
  }
}
