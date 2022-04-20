import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ExerciseCategoryHeaderWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const ExerciseCategoryHeaderWidget({
    required this.title,
    required this.subTitle,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null ? Text(
            title!,
            textAlign: TextAlign.left,
            style: title20.copyWith(color: AppColorScheme.colorPrimaryWhite),
          ) : const SizedBox.shrink(),
          const SizedBox(height: 4.0),
          subTitle != null ?
          Text(
            subTitle!,
            textAlign: TextAlign.left,
            style: textRegular10.copyWith(color: AppColorScheme.colorBlack7),
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }
}
