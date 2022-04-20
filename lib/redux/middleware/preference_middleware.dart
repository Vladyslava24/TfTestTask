import 'dart:convert';

import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/redux/actions/preference_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalfit/redux/states/preference_state.dart';

List<Middleware<AppState>> preferenceMiddleware(SharedPreferences prefs, TFLogger logger) {
  final onHideWorkoutQuestionTipAction = _onHideWorkoutQuestionTipAction(prefs, logger);
  final onHideAmrapFinishTipAction = _onHideAmrapFinishTipAction(prefs, logger);
  final onHideWorkoutOnboardingAction = _onHideWorkoutOnboardingAction(prefs, logger);
  final onFirstLaunchEventAction = _onFirstLaunchEventAction(prefs, logger);
  final onSessionStartAction = _onSessionStartAction(prefs, logger);
  final onUpdateShowHexagonOnBoardingMiddleware = _onUpdateShowHexagonOnBoardingMiddleware(prefs, logger);
  final onNewFeatureShownAction = _onNewFeatureShownAction(prefs, logger);

  return [
    TypedMiddleware<AppState, OnHideWorkoutQuestionTipAction>(onHideWorkoutQuestionTipAction),
    TypedMiddleware<AppState, OnHideWorkoutOnboardingAction>(onHideWorkoutOnboardingAction),
    TypedMiddleware<AppState, SendFirstLaunchEventAction>(onFirstLaunchEventAction),
    TypedMiddleware<AppState, OnHideAmrapFinishTipAction>(onHideAmrapFinishTipAction),
    TypedMiddleware<AppState, SessionStartAction>(onSessionStartAction),
    TypedMiddleware<AppState, UpdateShowHexagonOnBoardingAction>(onUpdateShowHexagonOnBoardingMiddleware),
    TypedMiddleware<AppState, OnNewFeatureShownAction>(onNewFeatureShownAction),
  ];
}

Middleware<AppState> _onNewFeatureShownAction(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onNewFeatureShownAction");
    next(action);
    final updateAction = action as OnNewFeatureShownAction;
    final disposedNewFeaturesPopUp = List<int>.of(store.state.preferenceState.disposedNewFeaturesPopUp);
    disposedNewFeaturesPopUp.add(updateAction.featureHash);
    await prefs.setString(PreferenceState.KEY_DISPOSED_NEW_FEATURE_POP_UP, json.encode(disposedNewFeaturesPopUp));
  };
}


Middleware<AppState> _onUpdateShowHexagonOnBoardingMiddleware(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onUpdateShowHexagonOnBoardingMiddleware");
    final updateAction = action as UpdateShowHexagonOnBoardingAction;
    await prefs.setBool(PreferenceState.KEY_SHOW_HEX_ONBOARDING, updateAction.status);
    next(UpdateShowHexagonOnBoardingAction(status: updateAction.status));
    next(action);
  };
}

Middleware<AppState> _onHideWorkoutQuestionTipAction(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onHideWorkoutQuestionTipAction");
    await prefs.setBool(PreferenceState.WORKOUT_QUESTION_TIP, false);
    next(action);
  };
}

Middleware<AppState> _onHideAmrapFinishTipAction(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onHideAmrapFinishTipAction");
    await prefs.setBool(PreferenceState.KEY_AMRAP_INTRO_SHOWN, true);
    next(action);
  };
}

Middleware<AppState> _onHideWorkoutOnboardingAction(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onHideWorkoutOnboardingAction");
    await prefs.setBool(PreferenceState.WORKOUT_ONBOARDING, false);
    next(action);
  };
}

Middleware<AppState> _onFirstLaunchEventAction(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onFirstLaunchEventAction");
    await prefs.setBool(PreferenceState.KEY_FIRST_LAUNCH, false);
    next(action);
  };
}

Middleware<AppState> _onSessionStartAction(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onSessionStartAction");
    final launchCount = store.state.preferenceState.launchCount;
    await prefs.setInt(PreferenceState.KEY_LAUNCH_COUNT, launchCount + 1);
    next(action);
  };
}
