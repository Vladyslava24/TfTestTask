import 'package:flutter/foundation.dart';
import 'package:workout_use_case/use_case.dart';

import 'download_video_service/download_video_service.dart';

class DownloadWorkoutUseCaseImpl implements DownloadWorkoutUseCase {
  final _downloadVideoService = DownloadVideoService();


  @override
  void download(WorkoutModel workout) {
    _downloadVideoService.download(workout);
  }

  @override
  void dispose() {
    _downloadVideoService.cancelDownload();
  }

  @override
  bool isWorkoutDownloaded(WorkoutModel workout) {
    return _downloadVideoService.isWorkoutDownloaded(workout);
  }

  @override
  ValueNotifier<WorkoutModel?> downloadableWorkoutNotifier() =>
      _downloadVideoService.downloadableWorkout;

  @override
  ValueNotifier<Set<String>> downloadedExercisesNotifier() =>
      _downloadVideoService.downloadedExercises;

  @override
  ValueNotifier<String> errorNotifier() => _downloadVideoService.error;

  @override
  ValueNotifier<int> selectDownloadedPercentFor(WorkoutModel workout) =>
    _downloadVideoService.getPercentage;

  @override
  Future<void> getInitialStatus(WorkoutModel workout) async {
     _downloadVideoService.getInitialStatus(workout);
  }
}
