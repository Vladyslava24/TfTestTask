import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class ListCategoryHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback navigateToWorkoutSelectionPage;

  ListCategoryHeaderWidget(
      {@required this.title, @required this.navigateToWorkoutSelectionPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: title20.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ),
        ),
        CupertinoButton(
          padding: const EdgeInsets.only(right: 12.0),
          onPressed: () {
            navigateToWorkoutSelectionPage();
          },
          child: Row(
            children: <Widget>[
              Text(
                S.of(context).see_all,
                textAlign: TextAlign.left,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorYellow,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColorScheme.colorYellow,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
