import 'package:workout_ui/src/model/summary_model.dart';
import 'package:workout_use_case/use_case.dart';

class RestData {
  final Rest rest;
  final WorkoutStage stage;
  final RestType restType;

  ///Needed for [RestType.external] to build [nextStageExercises]
  final WorkoutStage? nextStage;
  final MapEntry<String,String>? quote;
  List<ExercisesItem>? nextStageExercises;
  ///

  RestData({
    required this.rest,
    required this.stage,
    this.restType = RestType.external,
    this.nextStageExercises,
    this.nextStage,
    this.quote,
  });
}

enum RestType { external, inner }
