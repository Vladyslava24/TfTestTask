// import 'package:flutter/foundation.dart';
// import 'package:totalfit/data/dto/workout_dto.dart';
// import 'package:totalfit/model/exercise_dto.dart';
// import 'package:totalfit/storage/file/file_helper.dart';
// import 'package:logging/logging.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:totalfit/redux/actions/workout_actions.dart';
// import 'package:redux/redux.dart';
//
// class CacheService {
//   CacheQueue _currentQueue;
//   WorkoutDto _currentWorkout;
//
//   CacheQueue buildCacheQueue(
//       WorkoutDto workout, Logger logger, NextDispatcher next) {
//     if (_currentWorkout != workout) {
//       if (_currentQueue != null) {
//         logger.info("CacheQueue terminate queue for: ${_currentWorkout.theme}");
//         _currentQueue.terminateQueue();
//       }
//       _currentWorkout = workout;
//       _currentQueue = CacheQueue(
//           workout: workout,
//           next: next,
//           logger: logger,
//           onError: () {
//             _currentQueue = null;
//             _currentWorkout = null;
//           });
//     }
//
//     return _currentQueue;
//   }
//
//   void resetCache(){
//     _currentQueue = null;
//     _currentWorkout = null;
//   }
// }
//
// class CacheQueue {
//   final WorkoutDto workout;
//   final Logger logger;
//   final NextDispatcher next;
//   List<CacheTaskBulk> _bulks = [];
//   VoidCallback _executeNextBulk;
//   final VoidCallback onError;
//   CacheTaskBulk _currentBulk;
//
//   CacheQueue(
//       {@required this.workout,
//       @required this.next,
//       @required this.logger,
//       @required this.onError}) {
//     _executeNextBulk = () {
//       if (_bulks.length > 0) {
//         _currentBulk = _bulks.removeAt(0);
//         _currentBulk.execute();
//       }
//     };
//
//     final warmUpBulk = CacheTaskBulk(
//         exercises: workout.warmUp,
//         next: next,
//         logger: logger,
//         tag: "WARM UP",
//         target: workout,
//         onError: _onError,
//         onComplete: _executeNextBulk);
//     final skillBulk = CacheTaskBulk(
//         exercises: [workout.skill],
//         next: next,
//         logger: logger,
//         tag: "SKILL",
//         target: workout,
//         onError: _onError,
//         onComplete: _executeNextBulk);
//     final wodBulk = CacheTaskBulk(
//         exercises: workout.wod,
//         next: next,
//         logger: logger,
//         tag: "WOD",
//         target: workout,
//         onError: _onError,
//         onComplete: _executeNextBulk);
//     final coolDownBulk = CacheTaskBulk(
//         exercises: workout.cooldown,
//         next: next,
//         logger: logger,
//         tag: "COOL DOWN",
//         target: workout,
//         onError: _onError,
//         onComplete: _executeNextBulk);
//     _bulks.add(warmUpBulk);
//     _bulks.add(skillBulk);
//     _bulks.add(wodBulk);
//     _bulks.add(coolDownBulk);
//   }
//
//   _onError() {
//     _bulks.clear();
//     onError();
//   }
//
//   void execute() {
//     _executeNextBulk();
//   }
//
//   void terminateQueue() {
//     if (_currentBulk != null) {
//       _currentBulk.terminate();
//     }
//     _bulks.forEach((bulk) => bulk.terminate());
//     _bulks.clear();
//   }
// }
//
// class CacheTaskBulk {
//   final List<Exercise> exercises;
//   final Logger logger;
//   final NextDispatcher next;
//   final VoidCallback onComplete;
//   final VoidCallback onError;
//   final String tag;
//   final WorkoutDto target;
//   bool isTerminated = false;
//
//   CacheTaskBulk({
//     @required this.exercises,
//     @required this.logger,
//     @required this.next,
//     @required this.tag,
//     @required this.target,
//     @required this.onError,
//     @required this.onComplete,
//   });
//
//   Future execute() async {
//     final iterator = exercises.iterator;
//
//     while (iterator.moveNext()) {
//       if (isTerminated) {
//         return;
//       }
//       final exercise = iterator.current;
//       final task = CacheTask(url: exercise.videoVertical, target: target);
//       logger.info("started CacheTask $tag: ${task.url}");
//       final result = await task.execute();
//       if (isTerminated) {
//         logger.info(
//             "delayed result of terminated CacheTask $tag: for target ${target.theme}");
//         return;
//       }
//       logger.info(
//           "completed CacheTask $tag, target ${target.theme}: ${task.url} with result: ${result.runtimeType}");
//       next(UpdateCacheResultAction(result));
//       if (result is ErrorResult) {
//         onError();
//         return;
//       }
//     }
//     logger.info("completed CacheTaskBulk for: $tag");
//     onComplete();
//   }
//
//   terminate() {
//     logger.info("terminated CacheTask $tag: for target ${target.theme}");
//     isTerminated = true;
//   }
// }
//
// class CacheTask {
//   final String url;
//   final WorkoutDto target;
//
//   CacheTask({@required this.url, @required this.target});
//
//   Future<CacheResult> execute() async {
//     try {
//       final cachedFile = await loadFile(url, localDirectory: VIDEO_DIRECTORY);
//       return SuccessResult(
//           filePath: Uri.parse(cachedFile.path).pathSegments.last,
//           target: target);
//     } catch (e) {
//       print("CacheTask: $url. ${e.toString()} ");
//       return ErrorResult(e);
//     }
//   }
// }
//
// abstract class CacheResult {}
//
// class ErrorResult implements CacheResult {
//   dynamic reason;
//
//   ErrorResult(this.reason);
//
//   @override
//   String toString() => reason.toString();
// }
//
// class SuccessResult implements CacheResult {
//   String filePath;
//   WorkoutDto target;
//
//   SuccessResult({@required this.filePath, @required this.target});
// }
