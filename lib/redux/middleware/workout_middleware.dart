import 'package:core/core.dart';
import 'package:impl/impl.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/source/local/local_storage.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/selectors/progress_selectors.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:workout_use_case/use_case.dart';

List<Middleware<AppState>> workoutMiddleware(
    LocalStorage localStorage, TFLogger logger) {
  final onShowSelectedWorkoutPageAction =
      _onShowSelectedWorkoutPageAction(logger);

  return [
    TypedMiddleware<AppState, NavigateToWorkoutPreviewPageAction>(
        onShowSelectedWorkoutPageAction),
  ];
}

Middleware<AppState> _onShowSelectedWorkoutPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action workoutMiddleware");
    final showPageAction = action as NavigateToWorkoutPreviewPageAction;
    try {
      //TODO: Add Actual Dependency if needed ???
      final workout = showPageAction.workout;
      WorkoutProgressDto progress = selectProgress(store, workout);
      final downloadedPercent = 100;
     // next(InitWorkoutStateAction(workout, progress, downloadedPercent));
      next(action);
    } catch (e) {
      next(ErrorReportAction(
          where: "_onShowSelectedWorkoutPageAction",
          trigger: showPageAction.runtimeType,
          errorMessage: e.toString()));
    }
  };
}
