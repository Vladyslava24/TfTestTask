import 'package:workout_use_case/use_case.dart';
import 'package:flutter/foundation.dart';

abstract class DownloadWorkoutUseCase {
  ValueNotifier<WorkoutModel?> downloadableWorkoutNotifier();

  ValueNotifier<Set<String>> downloadedExercisesNotifier();

  ValueNotifier<String> errorNotifier();

  ValueNotifier<int> selectDownloadedPercentFor(WorkoutModel workout);

  void download(WorkoutModel workout);

  void dispose();

  bool isWorkoutDownloaded(WorkoutModel workout);

  Future<void> getInitialStatus(WorkoutModel workout);
}
