import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class HintOnBoardingWidget extends StatelessWidget {
  final Function doNextStep;
  final String title;
  final String description;

  const HintOnBoardingWidget({@required this.title, @required this.description, @required this.doNextStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppColorScheme.colorPrimaryWhite),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: title20.copyWith(color: AppColorScheme.colorBlack2),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style: textRegular16.copyWith(color: AppColorScheme.colorBlack2, height: 1.5),
          ),
          SizedBox(height: 12.0),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: doNextStep,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColorScheme.colorBlack9),
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                child: Text(
                  S.of(context).all__next,
                  style: title16.copyWith(color: AppColorScheme.colorBlack2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
