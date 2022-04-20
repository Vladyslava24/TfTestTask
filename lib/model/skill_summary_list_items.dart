import 'package:flutter/material.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';

class PageHeaderWorkoutSummaryListItem {
  final String title;
  final String subTitle;
  final Map<MetaHexSegment, double> rateMap;
  final String workoutDuration;
  final int roundCount;
  final String wodType;
  final int totalExercises;
  final int totalPoints;
  final bool showBackArrow;
  final bool finished;

  PageHeaderWorkoutSummaryListItem({
    @required this.title,
    @required this.subTitle,
    @required this.rateMap,
    @required this.workoutDuration,
    @required this.roundCount,
    @required this.wodType,
    @required this.totalExercises,
    @required this.showBackArrow,
    @required this.totalPoints,
    @required this.finished
  });

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is PageHeaderWorkoutSummaryListItem &&
      runtimeType == other.runtimeType &&
      title == other.title &&
      subTitle == other.subTitle &&
      workoutDuration == other.workoutDuration;

  @override
  int get hashCode => title.hashCode ^ subTitle.hashCode ^ workoutDuration.hashCode;
}

class ResultItem {
  final String title;
  final String subTitle;

  ResultItem({@required this.title, @required this.subTitle});
}

class SkillItem {
  final String skillName;
  final String imageUrl;

  SkillItem({@required this.imageUrl, @required this.skillName});
}

class ListBottomPaddingItem {}

class ListTopPaddingItem {}
