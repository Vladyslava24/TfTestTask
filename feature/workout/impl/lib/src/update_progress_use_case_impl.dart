import 'dart:async';

import 'package:core/core.dart';
import 'package:workout_data/data.dart';
import 'package:workout_use_case/use_case.dart';

class UpdateProgressUseCaseImpl implements UpdateProgressUseCase {
  final WorkoutRepository repository;

  UpdateProgressUseCaseImpl(this.repository);

  @override
  Future<Result<UpdateProgressNewResponse>> updateProgress(
      UpdateProgressPayload payload) {
    final requestDto = UpdateProgressRequestDto(
        workoutId: payload.workoutId,
        workoutStage: payload.workoutStage,
        workoutStageProgresses: payload.workoutStageProgresses
            .map((e) => StageProgressDto(
                stageDuration: int.parse(e.stageDuration!),
                roundCount: int.parse(e.roundCount!),
                type: fromWorkoutStageEnumToString(e.type),
                stageExerciseDurations: e.stageExerciseDurations
                    .map((item) => ExerciseDurationDto(
                        exerciseName: item.exerciseName,
                        workoutStage: fromWorkoutStageEnumToString(item.workoutStage),
                        exerciseDuration: item.exerciseDuration))
                    .toList()))
            .toList());
    return repository.updateProgress(requestDto);
  }

  @override
  Future<Result<UpdateProgressNewResponse>> updatePriorityStage() {
    return repository.updatePriorityStage();
  }

  @override
  StreamController<dynamic> workoutFinishStream() {
    return repository.workoutFinishStream();
  }
}
