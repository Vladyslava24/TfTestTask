import 'package:workout_use_case/use_case.dart';

import '../../workout_ui.dart';

class SummaryModel {
  List<dynamic> listItems;
  int? roundCount;
  int? duration;
  List<ExerciseDuration> stageExerciseDuration;
  int? userWeight;
  WorkoutSummaryPayload? workoutSummaryPayload;

  SummaryModel({
    required this.listItems,
    this.roundCount,
    this.duration,
    required this.stageExerciseDuration,
    this.userWeight,
    this.workoutSummaryPayload,
  });

  factory SummaryModel.initialWithPayload(
      WorkoutSummaryPayload workoutSummaryPayload) {


    return SummaryModel(
        listItems: [],
        stageExerciseDuration: [],
        workoutSummaryPayload: workoutSummaryPayload);
  }

  factory SummaryModel.initial(userWeight) => SummaryModel(
      listItems: [], stageExerciseDuration: [], userWeight: userWeight);
}

class HeaderItem {
  HeaderItem({
    required this.workoutName,
    required this.image,
  });

  final String workoutName;
  final String image;
}

class TimeScoreItem {
  final String time;
  final String rounds;
  final WorkoutStageType stageType;

  TimeScoreItem(
      {required this.time, required this.stageType, required this.rounds});
}

class WorkoutResultItem {
  final String duration;
  final int exercises;
  final String calories;

  WorkoutResultItem(
      {required this.duration, required this.exercises, required this.calories});
}

class ExercisesHeaderItem {
  int exercises;
  int rounds;
  WorkoutStage name;
  WorkoutStageType type;

  ExercisesHeaderItem(
      {required this.exercises,
      required this.name,
      required this.rounds,
      required this.type});
}

class ExercisesItem {
  String image;
  String name;
  String duration;

  ExercisesItem({
    required this.duration,
    required this.image,
    required this.name,
  });
}

class BottomPaddingItem {}
