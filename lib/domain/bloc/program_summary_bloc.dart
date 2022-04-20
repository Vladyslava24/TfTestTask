import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/remote/remote_storage_impl.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalfit/data/dto/response/active_program_response.dart';
import 'package:totalfit/ui/screen/main/programs/setup/summary/program_setup_summary_screen.dart';

abstract class UpdateProgramEvent {
  @override
  String toString() => runtimeType.toString();
}

class OnRequestCompleted extends UpdateProgramEvent {
  final ActiveProgram program;
  final WorkoutProgressDto workoutProgress;

  OnRequestCompleted(this.program, this.workoutProgress);
}

class Loading extends UpdateProgramEvent {}

abstract class Error extends UpdateProgramEvent {
  final TfException exception;

  Error(this.exception);
}

class UpdateProgramError extends Error {
  UpdateProgramError(TfException exception) : super(exception);
}

class QuitProgramError extends Error {
  QuitProgramError(TfException exception) : super(exception);
}

class ProgramSummaryBlock extends Bloc<BlockAction, UpdateProgramEvent> {
  final RemoteStorage remoteStorage = RemoteStorageImpl.sInstance;

  ProgramSummaryBlock() : super(null);

  @override
  Stream<UpdateProgramEvent> mapEventToState(BlockAction action) async* {
    yield Loading();
    try {
      ActiveProgramResponse response;
      if (action.mode == ProgramSummaryMode.Start) {
        response = await remoteStorage.startProgram(action.request);
      } else {
        response = await remoteStorage.updateProgram(action.request);
      }
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
        ex = TfException(
            action.mode == ProgramSummaryMode.Start ? ErrorCode.ERROR_START_PROGRAM : ErrorCode.ERROR_UPDATE_PROGRAM,
            e.toString());
      }
      yield UpdateProgramError(ex);
    }
  }
}

class BlockAction<T> {
  final ProgramSummaryMode mode;
  final T request;

  BlockAction(this.mode, {this.request});
}
