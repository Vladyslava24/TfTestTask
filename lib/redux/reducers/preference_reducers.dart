import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/redux/actions/preference_actions.dart';
import 'package:totalfit/redux/states/preference_state.dart';

final preferenceReducer = combineReducers<PreferenceState>([
  TypedReducer<PreferenceState, OnHideWorkoutQuestionTipAction>(_onHideWorkoutQuestionTipAction),
  TypedReducer<PreferenceState, OnHideWorkoutOnboardingAction>(_onHideShowWorkoutOnboardingAction),
  TypedReducer<PreferenceState, OnHideAmrapFinishTipAction>(_onHideAmrapFinishTipAction),
  TypedReducer<PreferenceState, SessionStartAction>(_onSessionStartAction),
  TypedReducer<PreferenceState, UpdateShowHexagonOnBoardingAction>(_onUpdateShowHexagonOnBoardingAction),
  TypedReducer<PreferenceState, OnNewFeatureShownAction>(_onNewFeatureShownAction),
]);

PreferenceState _onUpdateShowHexagonOnBoardingAction(PreferenceState state, UpdateShowHexagonOnBoardingAction action) =>
    state.copyWith(showHexagonOnBoarding: action.status);

PreferenceState _onHideShowWorkoutOnboardingAction(PreferenceState state, OnHideWorkoutOnboardingAction action) =>
    state.copyWith(showWorkoutOnboarding: false);

PreferenceState _onHideAmrapFinishTipAction(PreferenceState state, OnHideAmrapFinishTipAction action) =>
    state.copyWith(showAmrapFinishTip: false);

PreferenceState _onHideWorkoutQuestionTipAction(PreferenceState state, OnHideWorkoutQuestionTipAction action) =>
    state.copyWith(showWorkoutQuestionTip: false);

PreferenceState _onSessionStartAction(PreferenceState state, SessionStartAction action) {
  return state.copyWith(launchCount: state.launchCount + 1);
}

PreferenceState _onNewFeatureShownAction(PreferenceState state, OnNewFeatureShownAction action) {
  final disposedNewFeaturesPopUp = List<int>.of(state.disposedNewFeaturesPopUp);
  disposedNewFeaturesPopUp.add(action.featureHash);
  return state.copyWith(disposedNewFeaturesPopUp: disposedNewFeaturesPopUp);
}
