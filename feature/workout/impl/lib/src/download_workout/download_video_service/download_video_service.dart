import 'package:flutter/foundation.dart';
import 'package:impl/src/download_workout/download_video_service/task_list.dart';
import 'package:impl/src/download_workout/download_video_service/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:workout_use_case/use_case.dart';

class DownloadVideoService {
  static const TAG = 'DownloadVideoService';

  ValueNotifier<WorkoutModel?> downloadableWorkout = ValueNotifier(null);
  ValueNotifier<Set<String>> downloadedExercises = ValueNotifier({});
  ValueNotifier<String> error = ValueNotifier('');
  ValueNotifier<int> getPercentage = ValueNotifier(0);

  TaskList? _taskList;

  DownloadVideoService() {
    countDownloadedExercises();
  }

  Future<void> countDownloadedExercises() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final videoDirectory =
          Directory("${documentsDirectory.path}/$VIDEO_DIRECTORY");
      if (await videoDirectory.exists()) {
        final list = videoDirectory.listSync();
        final toUpdate = Set.of(downloadedExercises.value);
        toUpdate.addAll(list.map((e) => Uri.parse(e.path).pathSegments.last));
        downloadedExercises.value = toUpdate;
      }
    } catch (e) {
      print('$TAG $e');
    }
  }

  Future<void> getInitialStatus(WorkoutModel workout) async {
    await countDownloadedExercises();
    downloadableWorkout.value = workout;
    getPercentage.value = selectDownloadedPercentFor(workout);
  }

  void download(WorkoutModel workout) async {
    getPercentage.value = 0;

    if (downloadableWorkout.value != workout) {
      _taskList?.cancel();
    }

    downloadableWorkout.value = workout;
    getPercentage.value = selectDownloadedPercentFor(workout);

    Set<String> exercises = getUniqueExercises(workout);
    exercises.retainWhere((e) =>
        !downloadedExercises.value.contains(Uri.parse(e).pathSegments.last));

    if (exercises.isEmpty) {
      return;
    }

    _taskList = TaskList(
        exercises: exercises,
        onExerciseDownloaded: (path) {
          final toUpdate = Set.of(downloadedExercises.value);
          final name = Uri.parse(path).pathSegments.last;
          toUpdate.add(name);
          downloadedExercises.value = toUpdate;
          print(
              "$TAG total count: ${downloadedExercises.value.length}, downloaded: $name");
          getPercentage.value = selectDownloadedPercentFor(workout);
        },
        onComplete: () {
          _complete();
        },
        onError: (e) {
          _complete();
          error.value = 'Failed to download workout.';
          print('$TAG. Failed to download: $e');
        });
    _taskList?.execute();
  }

  _complete() {
    print('$TAG. download completed');
    downloadableWorkout.value = null;
    _taskList = null;
  }

  void cancelDownload() async {
    print('$TAG cancelDownload');
    _taskList?.cancel();
    downloadableWorkout.value = null;
  }

  int selectDownloadedPercentFor(WorkoutModel workout) {
    Set<String> exercises = getUniqueExercises(workout);
    final cachedList = List.of(exercises);
    String f ='';
    cachedList.retainWhere((e) =>
        downloadedExercises.value.contains(Uri.parse(e).pathSegments.last));
    final downloadedPercent =
        ((cachedList.length / exercises.length) * 100).ceil();
    getPercentage.value = downloadedPercent;
    return downloadedPercent;
  }

  void clearCache() async {
    print('$TAG clearCache');
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final videoDirectory =
          Directory("${documentsDirectory.path}/$VIDEO_DIRECTORY");
      if (await videoDirectory.exists()) {
        await videoDirectory.delete(recursive: true);
      }
      downloadedExercises.value = {};
    } catch (e) {
      print("$TAG. Failed to clear cache, reason: $e");
      countDownloadedExercises();
    }
  }

  bool isWorkoutDownloaded(WorkoutModel workout) =>
      selectDownloadedPercentFor(workout) >= 100;
}
