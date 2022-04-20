import 'package:core/core.dart';
import 'package:workout_api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/remote/remote_storage_impl.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalfit/model/profile_workout_summary_bundle.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';


abstract class ProgramProgressBlocEvent {
  @override
  String toString() => runtimeType.toString();
}

class OnProgramFinished extends ProgramProgressBlocEvent {
  final FinishProgramResponse response;

  OnProgramFinished(this.response);
}

class OnWorkoutSummaryLoaded extends ProgramProgressBlocEvent {
  final WorkoutSummaryBundle bundle;

  OnWorkoutSummaryLoaded(this.bundle);
}

class Loading extends ProgramProgressBlocEvent {}

class Error extends ProgramProgressBlocEvent {
  final TfException exception;

  Error(this.exception);
}

class ProgramProgressBlock extends Bloc<dynamic, ProgramProgressBlocEvent> {
  final RemoteStorage remoteStorage = RemoteStorageImpl.sInstance;
  final WorkoutApi workoutApi = DependencyProvider.get<WorkoutApi>();

  ProgramProgressBlock() : super(null);

  @override
  Stream<ProgramProgressBlocEvent> mapEventToState(dynamic action) async* {
    yield Loading();
    try {
      if (action is FinishProgramAction) {
        final response = await remoteStorage.finishProgram(action.programId);
        yield OnProgramFinished(response);
      } else {
        final loadCompletedWorkoutAction = action as LoadWorkoutSummaryAction;
        final progressResponse =
            await remoteStorage.getProgress(formatDateTime(DateTime.parse((loadCompletedWorkoutAction.startedAt))));
        final progress = progressResponse.workoutProgress
            .firstWhere((p) => p.id == loadCompletedWorkoutAction.workoutProgressId, orElse: () => null);
        final workout = await workoutApi.fetchWorkout(progress.workout.id);
        var bundle = WorkoutSummaryBundle(
          workout: workout,
          progress: progress,
          workoutPhase: progress.workoutPhase,
          hexagonState: progressResponse.hexagonState,
        );
        yield OnWorkoutSummaryLoaded(bundle);
      }
    } catch (e) {
      print(e.toString());
      TfException ex;
      if (e is TfException) {
        ex = e;
      } else {
        ex = TfException(
            action is FinishProgramAction ? ErrorCode.ERROR_FINISH_PROGRAM : ErrorCode.ERROR_LOAD_WORKOUT_SUMMARY,
            e.toString());
      }
      yield Error(ex);
    }
  }
}

class FinishProgramAction {
  final int programId;

  FinishProgramAction(this.programId);
}

class LoadWorkoutSummaryAction {
  final String workoutProgressId;
  final String startedAt;

  LoadWorkoutSummaryAction({@required this.workoutProgressId, @required this.startedAt});
}
