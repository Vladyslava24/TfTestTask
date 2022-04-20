import 'package:workout_use_case/src/model/workout_stage_model.dart';
import 'package:workout_use_case/src/model/workout_stages.dart';

class WorkoutModel {
  final String id;
  final String theme;
  final String image;
  final String difficultyLevel;
  final int estimatedTime;
  final String plan;
  final String badge;
  final WorkoutStage priorityStage;
  final List<String> equipment;
  final List<WorkoutStageModel> stages;

  const WorkoutModel({
    required this.id,
    required this.theme,
    required this.image,
    required this.difficultyLevel,
    required this.estimatedTime,
    required this.plan,
    required this.badge,
    required this.priorityStage,
    required this.equipment,
    required this.stages,
  });

  String get getWorkoutTime => '$estimatedTime min';
}

