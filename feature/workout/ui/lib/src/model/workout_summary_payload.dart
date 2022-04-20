import 'package:workout_use_case/use_case.dart';

class WorkoutSummaryPayload{

  String id;
  int workoutDuration;
  int warmupStageDuration;
  int wodStageDuration;
  int cooldownStageDuration;
  int roundCount;
  List<StageProgress> stageProgress;
  WorkoutModel workoutModel;
  bool moveToProgressOnClose;

  WorkoutSummaryPayload({
    required this.id,
    required this.workoutDuration,
    required this.warmupStageDuration,
    required this.wodStageDuration,
    required this.cooldownStageDuration,
    required this.roundCount,
    required this.stageProgress,
    required this.workoutModel,
    required this.moveToProgressOnClose
  });

}