

import 'package:impl/src/download_workout/download_video_service/result.dart';

import 'cache_task.dart';

class TaskList {
  static const TAG = 'CacheQueue';

  List<CacheTask> _tasks = [];

  final Function(String) onExerciseDownloaded;
  final Function(dynamic) onError;
  final Function onComplete;

  TaskList(
      {required Set<String> exercises,
      required this.onExerciseDownloaded,
      required this.onError,
      required this.onComplete}) {
    _tasks.addAll(exercises.map((e) => CacheTask(url: e)));
  }

  void execute() async {
    int completedCount = 0;
    _tasks.forEach((task) {
      task.execute().then((result) {
        if (result is SuccessResult) {
          onExerciseDownloaded(result.filePath);
          completedCount++;

          if (completedCount == _tasks.length) {
            _closeIsolates();
            onComplete();
          }
        } else {
          _closeIsolates();
          onError((result as ErrorResult).reason);
        }
      }).onError((error, stackTrace) {
        _closeIsolates();
        onError(error);
      });
    });
  }

  void _closeIsolates() {
    print("$TAG. closeIsolates");
    _tasks.forEach((t) {
      t.close();
    });
  }

  void cancel() {
    _closeIsolates();
  }
}
