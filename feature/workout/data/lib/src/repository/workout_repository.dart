import 'dart:async';

import 'package:core/core.dart';
import 'package:workout_data/src/model/workout_dto.dart';

import '../../data.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutDto>> fetchWorkouts();

  Future<Result<UpdateProgressNewResponse>> updateProgress(
      UpdateProgressRequestDto request);

  Future<WorkoutDto> fetchWorkoutById(int id);

  Stream<dynamic> progressUpdateStream();

  StreamController<dynamic> workoutFinishStream();

  Future<Result<UpdateProgressNewResponse>> updatePriorityStage();
}
