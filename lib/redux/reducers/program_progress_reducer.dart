import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/program_progress_dto.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/states/program_progress_state.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';

final programProgressReducer = combineReducers<ProgramProgressState>([
  TypedReducer<ProgramProgressState, OnErrorProgramAction>(_onErrorProgramAction),
  TypedReducer<ProgramProgressState, OnClearProgramsErrorAction>(_onClearProgramsErrorAction),
  TypedReducer<ProgramProgressState, SetActiveProgramAction>(_setActiveProgramAction),
  TypedReducer<ProgramProgressState, SetProgramProgressPageStateAction>(_setProgramProgressPageStateAction),
  TypedReducer<ProgramProgressState, OnProgramUpdatedAction>(_onProgramUpdatedAction),
  TypedReducer<ProgramProgressState, RemoveActiveProgramAction>(_onRemoveActiveProgramAction),
  TypedReducer<ProgramProgressState, LogoutAction>(_onLogoutAction),
  TypedReducer<ProgramProgressState, OnProgramFinishedAction>(_onProgramFinishedAction),
  TypedReducer<ProgramProgressState, OnSharingCompletedEventAction>(_onWorkoutCompleted),
]);

ProgramProgressState _onWorkoutCompleted(ProgramProgressState state, OnSharingCompletedEventAction action) {
  if (state.activeProgram != null &&
      state.activeProgram.workoutOfTheDay.theme.toLowerCase() == action.theme.toLowerCase()) {
    final currentProgress = state.activeProgram.programProgress;
    final updatedProgress = ProgramProgressDto(
        workoutsQuantity: currentProgress.workoutsQuantity, workoutsDone: currentProgress.workoutsDone + 1);

    final workoutsToUpdate = List.of(state.activeProgram.thisWeekWorkouts);

    for (int i = 0; i < workoutsToUpdate.length; i++) {
      final w = workoutsToUpdate[i];
      if (isToday(w.date)) {
        w.workoutProgress.finished = true;
        w.workoutProgress.workoutPhase = WorkoutPhase.FINISHED;
        w.workoutProgress.startedAt = action.startedAt;
        w.workoutProgress.id = action.workoutProgressId;
        break;
      }
    }

    final fullScheduleWorkoutsToUpdate = List.of(state.activeProgram.schedule);

    outerLoop:
    for (int i = 0; i < fullScheduleWorkoutsToUpdate.length; i++) {
      final workoutsToUpdate = fullScheduleWorkoutsToUpdate[i].workouts;
      for (int j = 0; j < workoutsToUpdate.length; j++) {
        final w = workoutsToUpdate[j];
        if (isToday(w.date)) {
          w.workoutProgress.finished = true;
          w.workoutProgress.workoutPhase = WorkoutPhase.FINISHED;
          w.workoutProgress.startedAt = action.startedAt;
          w.workoutProgress.id = action.workoutProgressId;
          break outerLoop;
        }
      }
    }

    final updatedProgram =
        state.activeProgram.copyWith(programProgress: updatedProgress, thisWeekWorkouts: workoutsToUpdate);
    return state.copyWith(program: updatedProgram);
  } else {
    return state;
  }
}

ProgramProgressState _onProgramFinishedAction(ProgramProgressState state, OnProgramFinishedAction action) =>
    ProgramProgressState.initial();

ProgramProgressState _onLogoutAction(ProgramProgressState state, LogoutAction action) => ProgramProgressState.initial();

ProgramProgressState _onProgramUpdatedAction(ProgramProgressState state, OnProgramUpdatedAction action) =>
    state.copyWith(program: action.program);

ProgramProgressState _setActiveProgramAction(ProgramProgressState state, SetActiveProgramAction action) =>
    state.copyWith(program: action.program);

ProgramProgressState _setProgramProgressPageStateAction(
        ProgramProgressState state, SetProgramProgressPageStateAction action) =>
    state.copyWith(listItems: action.listItems);

ProgramProgressState _onErrorProgramAction(ProgramProgressState state, OnErrorProgramAction action) =>
    state.copyWith(showLoading: false, error: action.error);

ProgramProgressState _onClearProgramsErrorAction(ProgramProgressState state, OnClearProgramsErrorAction action) =>
    state.copyWith(error: IdleException());

ProgramProgressState _onRemoveActiveProgramAction(ProgramProgressState state, RemoveActiveProgramAction action) =>
    ProgramProgressState.initial();
