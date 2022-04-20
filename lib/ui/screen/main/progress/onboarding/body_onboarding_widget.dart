import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/environment_model.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/ui/screen/main/progress/item_widgets/environmental_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/bagde_onboarding_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';

class BodyOnBoardingWidget extends StatelessWidget {
  const BodyOnBoardingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                bodyHexIc,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                S.of(context).train_your_body,
                textAlign: TextAlign.left,
                style: title20.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                  letterSpacing: 0.015,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 16, bottom: 12),
          child: Row(
            children: [
              Container(
                width: 16.0,
                height: 16.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent, //AppColorScheme.colorYellow,
                        border: Border.all(
                          color: AppColorScheme.colorYellow,
                          width: 2.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4.0,
                      left: 2.5,
                      child: Opacity(
                        opacity: 0.0, //: 1.0,
                        child: SvgPicture.asset(
                          checkIc,
                          width: 12.0,
                          height: 9.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(cardBorderRadius),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        ),
                        child: TfImage(
                            url:
                                "https://totalfit-app-images.s3.eu-west-1.amazonaws.com/All+Equipment+Program/EqProd23.jpg",
                            width: double.infinity,
                            height: 211),
                      ),
                    ),
                    Positioned(
                      bottom: 12.0,
                      left: 12.0,
                      right: 12.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            S.of(context).programs_progress__workout_of_the_day.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: textRegular10.copyWith(
                              letterSpacing: 0.05,
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Purus',
                            textAlign: TextAlign.left,
                            style: title16.copyWith(
                              letterSpacing: 0.0041,
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              BadgeOnBoardingWidget(
                                text: "30 ${S.of(context).min}",
                                color: AppColorScheme.colorBlack4,
                              ),
                              const SizedBox(width: 4.0),
                              BadgeOnBoardingWidget(
                                text: "Intermediate",
                                color: AppColorScheme.colorBlack4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(cardBorderRadius),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: null,
                            splashColor: AppColorScheme.colorYellow.withOpacity(0.3),
                            highlightColor: AppColorScheme.colorYellow.withOpacity(0.1),
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        EnvironmentalListItemWidget(
            item: EnvironmentalListItem(
                environmentModel: EnvironmentModel(
                    environmentalRecord: null,
                    collapsedStateImage: 'https://totalfit-app-images.s3-eu-west-1.amazonaws.com/envir%403x.jpg',
                    expandedStateImage: 'https://totalfit-app-images.s3-eu-west-1.amazonaws.com/envir%403x.jpg',
                    maxValue: 120,
                    minValue: 10,
                    step: 1,
                    minValueTitle: '10 min',
                    maxValueTitle: '2+ hours',
                    isEnable: true)),
            onSaveValue: null),
      ],
    ));
  }
}
