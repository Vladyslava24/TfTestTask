import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/ui/utils/utils.dart';

abstract class BasicWorkoutListItem {}

class SpaceWorkoutListItem implements BasicWorkoutListItem {}

class PageHeaderBasicWorkoutListItem implements BasicWorkoutListItem {
  final String title;
  final List<String> equipment;
  final String level;
  final int duration;
  final String image;
  final WorkoutPhase workoutPhase;
  final bool isLockedPremium;

  PageHeaderBasicWorkoutListItem(
      {@required this.title,
      @required this.equipment,
      @required this.level,
      @required this.duration,
      @required this.workoutPhase,
      @required this.isLockedPremium,
      @required this.image});

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageHeaderBasicWorkoutListItem &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          image == other.image;

  @override
  int get hashCode => title.hashCode ^ image.hashCode;
}

abstract class AbsBasicWorkoutCategoryListItem implements BasicWorkoutListItem {
  //dedicated stage is used for String title selection
  final WorkoutPhase dedicatedPhase;
  final WorkoutDto workout;
  final bool isCompleted;

  AbsBasicWorkoutCategoryListItem({@required this.workout, @required this.dedicatedPhase, @required this.isCompleted});
}

class ExerciseCategoryItem extends AbsBasicWorkoutCategoryListItem {
  final List<Exercise> exercises;

  ExerciseCategoryItem({@required this.exercises, @required isCompleted, @required workout, @required dedicatedStage})
      : super(workout: workout, dedicatedPhase: dedicatedStage, isCompleted: isCompleted);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseCategoryItem &&
          runtimeType == other.runtimeType &&
          dedicatedPhase == other.dedicatedPhase &&
          deepEquals(exercises);

  @override
  int get hashCode => dedicatedPhase.hashCode ^ deepHash(exercises);
}

class StoryItemModel {
  final String name;
  final String story;
  String truthToRemember;
  bool shared;

  StoryItemModel({@required this.name, @required this.story});

  StoryItemModel.fromMap(jsonMap)
      : name = jsonMap["name"],
        story = jsonMap["story"],
        truthToRemember = jsonMap["truthToRemember"],
        shared = jsonMap["shared"];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryItemModel && runtimeType == other.runtimeType && name == other.name && story == other.story;

  @override
  int get hashCode => name.hashCode ^ story.hashCode;
}
