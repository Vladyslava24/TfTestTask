import 'package:workout_use_case/src/model/exercise_model.dart';
import 'package:workout_use_case/src/model/stage_option.dart';
import 'package:workout_use_case/src/model/workout_stages.dart';

class WorkoutStageModel {
  final WorkoutStage stageName;
  final WorkoutStageType stageType;
  final List<ExerciseModel> exercises;
  final StageOption stageOption;

  const WorkoutStageModel({
    required this.stageName,
    required this.stageType,
    required this.exercises,
    required this.stageOption,
  });
}
