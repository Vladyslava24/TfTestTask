import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalfit/ui/utils/utils.dart';

@immutable
class PreferenceState {
  static const KEY_AUDIO_MODE = "KEY_AUDIO_MODE";
  static const WORKOUT_QUESTION_TIP = "WORKOUT_QUESTION_TIP";
  static const WORKOUT_ONBOARDING = "WORKOUT_ONBOARDING";
  static const KEY_FIRST_LAUNCH = "KEY_FIRST_LAUNCH";
  static const KEY_AMRAP_INTRO_SHOWN = "KEY_AMRAP_INTRO_SHOWN";
  static const KEY_LAUNCH_COUNT = "KEY_LAUNCH_COUNT";
  static const KEY_SHOW_HEX_ONBOARDING = "KEY_SHOW_HEX_ONBOARDING";
  static const KEY_DISPOSED_NEW_FEATURE_POP_UP = "KEY_DISPOSED_NEW_FEATURE_POP_UP";

  final bool showWorkoutQuestionTip;
  final bool showAmrapFinishTip;
  final bool showWorkoutOnboarding;
  final bool isFirstLaunch;
  final int launchCount;
  final bool showHexagonOnBoarding;
  final List<int> disposedNewFeaturesPopUp;

  PreferenceState({
    @required this.showWorkoutQuestionTip,
    @required this.showWorkoutOnboarding,
    @required this.showAmrapFinishTip,
    @required this.isFirstLaunch,
    @required this.launchCount,
    @required this.showHexagonOnBoarding,
    @required this.disposedNewFeaturesPopUp,
  });

  factory PreferenceState.initial(SharedPreferences prefs) {

    var showWorkoutQuestionTip = prefs.containsKey(WORKOUT_QUESTION_TIP) ? prefs.getBool(WORKOUT_QUESTION_TIP) : true;

    var showWorkoutOnboarding = prefs.containsKey(WORKOUT_ONBOARDING) ? prefs.getBool(WORKOUT_ONBOARDING) : true;

    var isFirstLaunch = prefs.containsKey(KEY_FIRST_LAUNCH) ? prefs.getBool(KEY_FIRST_LAUNCH) : true;

    var showAmrapFinishTip = prefs.containsKey(KEY_AMRAP_INTRO_SHOWN) ? !prefs.getBool(KEY_AMRAP_INTRO_SHOWN) : true;

    int launchCount = prefs.getInt(KEY_LAUNCH_COUNT) ?? 0;

    var showHexagonOnBoarding =
        prefs.containsKey(KEY_SHOW_HEX_ONBOARDING) ? prefs.getBool(KEY_SHOW_HEX_ONBOARDING) : true;

    List<int> disposedNewFeaturesPopUp = [];
    final disposedFeaturePopUp = prefs.getString(KEY_DISPOSED_NEW_FEATURE_POP_UP);
    if (disposedFeaturePopUp != null) {
      disposedNewFeaturesPopUp.addAll(List.from(json.decode(disposedFeaturePopUp).cast<int>()));
    }

    return PreferenceState(
        showWorkoutQuestionTip: showWorkoutQuestionTip,
        showWorkoutOnboarding: showWorkoutOnboarding,
        isFirstLaunch: isFirstLaunch,
        launchCount: launchCount,
        showHexagonOnBoarding: showHexagonOnBoarding,
        disposedNewFeaturesPopUp: disposedNewFeaturesPopUp,
        showAmrapFinishTip: showAmrapFinishTip);
  }

  PreferenceState copyWith({
    bool showWorkoutQuestionTip,
    bool showWorkoutOnboarding,
    bool isFirstLaunch,
    bool showAmrapFinishTip,
    int launchCount,
    List<int> disposedNewFeaturesPopUp,
    bool showHexagonOnBoarding,
  }) {
    return PreferenceState(
        showWorkoutQuestionTip: showWorkoutQuestionTip ?? this.showWorkoutQuestionTip,
        isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
        showAmrapFinishTip: showAmrapFinishTip ?? this.showAmrapFinishTip,
        disposedNewFeaturesPopUp: disposedNewFeaturesPopUp ?? this.disposedNewFeaturesPopUp,
        launchCount: launchCount ?? this.launchCount,
        showWorkoutOnboarding: showWorkoutOnboarding ?? this.showWorkoutOnboarding,
        showHexagonOnBoarding: showHexagonOnBoarding ?? this.showHexagonOnBoarding);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferenceState &&
          runtimeType == other.runtimeType &&
          showWorkoutOnboarding == other.showWorkoutOnboarding &&
          launchCount == other.launchCount &&
          deepEquals(disposedNewFeaturesPopUp, other.disposedNewFeaturesPopUp) &&
          showWorkoutQuestionTip == other.showWorkoutQuestionTip &&
          showHexagonOnBoarding == other.showHexagonOnBoarding;

  @override
  int get hashCode =>
      showWorkoutQuestionTip.hashCode ^
      showWorkoutOnboarding.hashCode ^
      launchCount.hashCode ^
      deepHash(disposedNewFeaturesPopUp) ^
      showHexagonOnBoarding.hashCode;
}
