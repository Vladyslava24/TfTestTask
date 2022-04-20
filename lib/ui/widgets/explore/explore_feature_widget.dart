import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';

class ExploreFeatureWidget extends StatelessWidget {
  final String icon;
  final FeatureIcon featureIcon;
  final String title;
  final String description;
  final Function action;

  const ExploreFeatureWidget({
    @required this.icon,
    @required this.action,
    this.featureIcon = FeatureIcon.left,
    this.title,
    this.description,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColorScheme.colorBlack2,
          borderRadius: BorderRadius.circular(cardBorderRadius)
        ),
        child: featureIcon == FeatureIcon.left ?
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 12.0),
                child: SvgPicture.asset(icon)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: title16),
                  SizedBox(height: 4.0),
                  Text(
                    description.toUpperCase(),
                    style: textRegular10.copyWith(
                      color: AppColorScheme.colorPrimaryWhite.withOpacity(.6)
                    )
                  ),
                ],
              ),
            ],
          ) : featureIcon == FeatureIcon.top ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: SvgPicture.asset(
                    icon,
                    width: 32.0,
                    height: 32.0,
                  )
                ),
              ),
              Text(title, style: title16),
              SizedBox(height: 4.0),
              Text(
                description.toUpperCase(),
                style: textRegular10.copyWith(
                  color: AppColorScheme.colorPrimaryWhite.withOpacity(.6)
                )
              )
            ],
          ) : SizedBox(),
      ),
    );
  }
}

enum FeatureIcon { top, left }