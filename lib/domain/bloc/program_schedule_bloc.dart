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

abstract class BlocEvent {
  @override
  String toString() => runtimeType.toString();
}

class OnWorkoutSummaryLoaded extends BlocEvent {
  final WorkoutSummaryBundle bundle;

  OnWorkoutSummaryLoaded(this.bundle);
}

class Loading extends BlocEvent {}

class Error extends BlocEvent {
  final TfException exception;

  Error(this.exception);
}

class ProgramScheduleBlock extends Bloc<LoadWorkoutSummaryAction, BlocEvent> {
  final RemoteStorage remoteStorage = RemoteStorageImpl.sInstance;
  final WorkoutApi workoutApi = DependencyProvider.get<WorkoutApi>();

  ProgramScheduleBlock() : super(null);

  @override
  Stream<BlocEvent> mapEventToState(LoadWorkoutSummaryAction action) async* {
    yield Loading();
    try {
      final progressResponse = await remoteStorage.getProgress(formatDateTime(DateTime.parse((action.startedAt))));
      final progress =
          progressResponse.workoutProgress.firstWhere((p) => p.id == action.workoutProgressId, orElse: () => null);
      final workout = await workoutApi.fetchWorkout(progress.workout.id);
      var bundle = WorkoutSummaryBundle(
        workout: workout,
        progress: progress,
        workoutPhase: progress.workoutPhase,
        hexagonState: progressResponse.hexagonState,
      );
      yield OnWorkoutSummaryLoaded(bundle);
    } catch (e) {
      print(e.toString());
      TfException ex;
      if (e is TfException) {
        ex = e;
      } else {
        ex = TfException(ErrorCode.ERROR_LOAD_WORKOUT_SUMMARY, e.toString());
      }
      yield Error(ex);
    }
  }
}

class LoadWorkoutSummaryAction {
  final String workoutProgressId;
  final String startedAt;

  LoadWorkoutSummaryAction({@required this.workoutProgressId, @required this.startedAt});
}
