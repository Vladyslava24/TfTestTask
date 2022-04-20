import 'package:flutter/material.dart';
import 'package:totalfit/redux/actions/app_state_actions.dart';
import 'package:totalfit/redux/reducers/login_reducer.dart';
import 'package:totalfit/redux/reducers/push_notifications_reducer.dart';
import 'package:totalfit/redux/reducers/session_reducer.dart';
import 'package:totalfit/redux/reducers/program_full_schedule_reducer.dart';
import 'package:totalfit/redux/reducers/program_progress_reducer.dart';
import 'package:totalfit/redux/reducers/choose_program_screen_reducer.dart';
import 'package:totalfit/redux/reducers/program_setup_reducer.dart';
import 'package:totalfit/redux/reducers/splash_screen_reducer.dart';
import 'package:totalfit/redux/reducers/workout_state_reducer.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/redux/reducers/profile_edit_screen_reducer.dart';
import 'package:totalfit/redux/reducers/profile_screen_reducer.dart';
import 'package:totalfit/redux/reducers/settings_screen_reducer.dart';
import 'package:totalfit/redux/reducers/profile_share_workout_results_reducer.dart';
import 'package:totalfit/redux/reducers/profile_workout_summary_state_reducer.dart';
import 'main_page_reducers.dart';
import 'preference_reducers.dart';
import 'reset_password_reducers.dart';
import 'sign_up_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    sessionState: sessionReducer(state.sessionState, action),
    splashState: splashScreenReducer(state.splashState, action),
    loginState: loginReducer(state.loginState, action),
    signUpState: signUpReducer(state.signUpState, action),
    mainPageState: mainPageReducer(state.mainPageState, action),
    workoutState: workoutStateReducer(state.workoutState, action),
    resetPasswordState: resetPasswordReducer(state.resetPasswordState, action),
    appLifecycleState: appLifecycleStateReducer(state.appLifecycleState, action),
    settingsScreenState: settingsScreenReducer(state.settingsScreenState, action),
    preferenceState: preferenceReducer(state.preferenceState, action),
    profileEditScreenState: profileEditScreenReducer(state.profileEditScreenState, action),
    profileScreenState: profileScreenReducer(state.profileScreenState, action),
    profileShareWorkoutResultsScreenState:
        profileShareScreenReducer(state.profileShareWorkoutResultsScreenState, action),
    profileWorkoutSummaryState: profileWorkoutSummaryStateReducer(state.profileWorkoutSummaryState, action),
    chooseProgramScreenState: chooseProgramScreenReducer(state.chooseProgramScreenState, action),
    programSetupState: programSetupReducer(state.programSetupState, action),
    programProgressState: programProgressReducer(state.programProgressState, action),
    programFullScheduleState: programFullScheduleReducer(state.programFullScheduleState, action),
    pushNotificationsState: pushNotificationsReducer(state.pushNotificationsState, action),
    config: state.config,
  );
}

AppLifecycleState appLifecycleStateReducer(AppLifecycleState state, dynamic action) {
  if (action is OnAppStateChangedAction) {
    return action.state;
  }
  return state;
}
