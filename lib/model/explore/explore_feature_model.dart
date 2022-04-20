import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';

class ExploreFeatureModel {
  final ExploreFeatureType type;
  final Function action;
  final String title;
  final String description;

  const ExploreFeatureModel({
    @required this.type,
    @required this.action,
    this.title,
    this.description
  });

  String getIcon(ExploreFeatureType type) {
    switch(type) {
      case ExploreFeatureType.exercise:
        return exerciseIcon;
      case ExploreFeatureType.wod:
        return wodIcon;
      case ExploreFeatureType.weeklyPlan:
        return weeklyPlanIcon;
      default:
        return '';
    }
  }
}

enum ExploreFeatureType { exercise, wod, weeklyPlan }