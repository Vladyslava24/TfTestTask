import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/remote/remote_storage_impl.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OnboardingSummaryEvent {
  @override
  String toString() => runtimeType.toString();
}

class OnRequestCompleted extends OnboardingSummaryEvent {
  final ActiveProgram program;
  final WorkoutProgressDto workoutProgress;

  OnRequestCompleted(this.program, this.workoutProgress);
}

class Loading extends OnboardingSummaryEvent {}

class Error extends OnboardingSummaryEvent {
  final TfException exception;

  Error(this.exception);
}

class OnboardingSummaryBlock extends Bloc<BlockAction, OnboardingSummaryEvent> {
  final RemoteStorage remoteStorage = RemoteStorageImpl.sInstance;

  OnboardingSummaryBlock() : super(null);

  @override
  Stream<OnboardingSummaryEvent> mapEventToState(BlockAction action) async* {
    yield Loading();
    try {
      final response = await remoteStorage.startProgram(action.request);
      var activeProgram = ActiveProgram(
        allWorkoutsDone: response.allWorkoutsDone,
        daysAWeek: response.daysAWeek,
        difficultyLevel: response.difficultyLevel,
        daysOfTheWeek: response.daysOfTheWeek,
        id: response.id,
        name: response.name,
        numberOfWeeks: response.numberOfWeeks,
        schedule: response.schedule,
        thisWeekWorkouts: response.thisWeekWorkouts,
        maxWeekNumber: response.maxWeekNumber,
        levels: response.levels,
        workoutOfTheDay: response.workoutProgress != null ? response.workoutProgress.workout : null,
        programProgress: response.programProgress,
      );
      yield OnRequestCompleted(activeProgram, response.workoutProgress);
    } catch (e) {
      print(e.toString());
      TfException ex;
      if (e is TfException) {
        ex = e;
      } else {
        ex = TfException(ErrorCode.ERROR_START_PROGRAM, e.toString());
      }
      yield Error(ex);
    }
  }
}

class BlockAction<T> {
  final T request;

  BlockAction({this.request});
}
