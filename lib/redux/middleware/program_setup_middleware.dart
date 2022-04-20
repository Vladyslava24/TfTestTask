import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';

import '../actions/choose_program_actions.dart';
import '../../model/program_days_of_week.dart';

List<Middleware<AppState>> programSetupMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  return [
    TypedMiddleware<AppState, OnStopProgramClickAction>(_onStopProgramClickAction(remoteStorage, logger)),
    TypedMiddleware<AppState, OnProgramInterruptedAction>(_onProgramInterruptedAction(logger)),
    TypedMiddleware<AppState, LoadInitDaysPageStateAction>(_initDaysPageStateAction()),
  ];
}

Middleware<AppState> _initDaysPageStateAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    store.dispatch(SetInitDaysPageStateAction(days: DayOfWeek.LIST));
  };
}

Middleware<AppState> _onStopProgramClickAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      next(SetProgramLoadingAction(isLoading: true));
      await remoteStorage.interruptProgram();
      logger.logInfo("_onStopProgramClickAction request success");
      next(RemoveActiveProgramAction());

      var updatedProgram = store.state.programSetupState.program.copyWith(isActive: false, workoutProgress: null);
      next(SetProgramAction(program: updatedProgram));
      next(RefreshProgramOnListAction(isNeedToRefresh: true));
      next(SetProgramLoadingAction(isLoading: false));
      next(NavigateToChooseProgramLevelPageAction());
    } catch (e) {
      if (e is ApiException && e.serverErrorCode == 404) {
        next(SetProgramLoadingAction(isLoading: false));
      } else {
        logger.logError("$action _onStopProgramClickAction ${e.toString()}");
        next(ErrorReportAction(
            where: "programSetupMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
        next(OnErrorProgramAction(error: e));
      }
    }
  };
}

Middleware<AppState> _onProgramInterruptedAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo("_onProgramInterruptedAction");
    next(RemoveActiveProgramAction());
    next(RefreshProgramOnListAction(isNeedToRefresh: true));
    next(SwitchProgramTabAction(showActiveProgram: false));
  };
}
