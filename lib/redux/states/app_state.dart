import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'package:totalfit/redux/states/preference_state.dart';
import 'package:totalfit/redux/states/push_notifications_state.dart';
import 'package:totalfit/redux/states/reset_password_state.dart';
import 'package:totalfit/redux/states/sign_up_state.dart';
import 'package:totalfit/redux/states/workout_state.dart';
import 'package:totalfit/redux/states/profile_edit_screen_state.dart';
import 'package:totalfit/redux/states/profile_screen_state.dart';
import 'package:totalfit/redux/states/settings_screen_state.dart';
import 'package:totalfit/redux/states/profile_share_workout_results_state.dart';
import 'package:totalfit/redux/states/profile_workout_summary_state.dart';
import 'package:totalfit/redux/states/program_full_schedule_state.dart';
import 'package:totalfit/redux/states/program_progress_state.dart';
import 'package:totalfit/redux/states/choose_program_screen_state.dart';
import 'package:totalfit/redux/states/program_setup_state.dart';
import 'package:totalfit/redux/states/splash_screen_state.dart';

import '../request_state.dart';
import 'app_config.dart';
import 'login_state.dart';
import 'main_page_state.dart';
import 'session_state.dart';

@immutable
class AppState {
  final SessionState sessionState;
  final SplashScreenState splashState;
  final LoginState loginState;
  final SignUpState signUpState;
  final MainPageState mainPageState;
  final ResetPasswordState resetPasswordState;
  final PreferenceState preferenceState;
  final AppLifecycleState appLifecycleState;
  final WorkoutState workoutState;
  final ProfileShareWorkoutResultsScreenState
      profileShareWorkoutResultsScreenState;
  final SettingsScreenState settingsScreenState;
  final ProfileEditScreenState profileEditScreenState;
  final ProfileScreenState profileScreenState;
  final ProfileWorkoutSummaryState profileWorkoutSummaryState;
  final ChooseProgramScreenState chooseProgramScreenState;
  final ProgramSetupState programSetupState;
  final ProgramProgressState programProgressState;
  final ProgramFullScheduleState programFullScheduleState;
  final RequestState requestState;
  final PushNotificationsState pushNotificationsState;
  final AppConfig config;

  AppState(
      {this.sessionState,
      this.splashState,
      this.loginState,
      this.signUpState,
      this.mainPageState,
      this.resetPasswordState,
      this.appLifecycleState,
      this.settingsScreenState,
      this.workoutState,
      this.preferenceState,
      this.profileEditScreenState,
      this.profileScreenState,
      this.profileShareWorkoutResultsScreenState,
      this.profileWorkoutSummaryState,
      this.chooseProgramScreenState,
      this.programSetupState,
      this.programProgressState,
      this.programFullScheduleState,
      this.requestState,
      this.pushNotificationsState,
      this.config});

  factory AppState.initial(SharedPreferences prefs, String configString) {
    return AppState(
        sessionState: SessionState.initial(),
        splashState: SplashScreenState.initial(),
        loginState: LoginState.initial(),
        signUpState: SignUpState.initial(),
        mainPageState: MainPageState.initial(),
        resetPasswordState: ResetPasswordState.initial(),
        workoutState: null,
        appLifecycleState: null,
        settingsScreenState: SettingsScreenState.initial(),
        profileEditScreenState: ProfileEditScreenState.initial(),
        profileScreenState: ProfileScreenState.initial(),
        profileShareWorkoutResultsScreenState:
            ProfileShareWorkoutResultsScreenState.initial(),
        profileWorkoutSummaryState: ProfileWorkoutSummaryState.initial(),
        chooseProgramScreenState: ChooseProgramScreenState.initial(),
        programSetupState: ProgramSetupState.initial(),
        programProgressState: ProgramProgressState.initial(),
        programFullScheduleState: ProgramFullScheduleState.initial(),
        requestState: RequestState.IDLE,
        preferenceState: PreferenceState.initial(prefs),
        pushNotificationsState: PushNotificationsState.initial(),
        config: AppConfig.init(configString)
    );
  }

  bool isPremiumUser() {
    return FlavorConfig.isDev() ||
        (mainPageState.purchaserInfo != null &&
            mainPageState.purchaserInfo.activeSubscriptions.isNotEmpty) ||
        (loginState.user != null &&
            config.premiumWhiteList
                .contains(loginState.user.email.toLowerCase()));
  }

  @override
  toString() {
    return '$hashCode';
  }

  @override
  int get hashCode =>
      sessionState.hashCode ^
      splashState.hashCode ^
      loginState.hashCode ^
      signUpState.hashCode ^
      mainPageState.hashCode ^
      resetPasswordState.hashCode ^
      appLifecycleState.hashCode ^
      settingsScreenState.hashCode ^
      profileEditScreenState.hashCode ^
      profileScreenState.hashCode ^
      workoutState.hashCode ^
      profileShareWorkoutResultsScreenState.hashCode ^
      profileWorkoutSummaryState.hashCode ^
      chooseProgramScreenState.hashCode ^
      programSetupState.hashCode ^
      programProgressState.hashCode ^
      programFullScheduleState.hashCode ^
      requestState.hashCode ^
      preferenceState.hashCode ^
      pushNotificationsState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          sessionState == other.sessionState &&
          splashState == other.splashState &&
          loginState == other.loginState &&
          signUpState == other.signUpState &&
          mainPageState == other.mainPageState &&
          resetPasswordState == other.resetPasswordState &&
          appLifecycleState == other.appLifecycleState &&
          preferenceState == other.preferenceState &&
          workoutState == other.workoutState &&
          requestState == other.requestState &&
          profileScreenState == other.profileScreenState &&
          profileEditScreenState == other.profileEditScreenState &&
          profileShareWorkoutResultsScreenState ==
              other.profileShareWorkoutResultsScreenState &&
          profileWorkoutSummaryState == other.profileWorkoutSummaryState &&
          chooseProgramScreenState == other.chooseProgramScreenState &&
          programSetupState == other.programSetupState &&
          programProgressState == other.programProgressState &&
          programFullScheduleState == other.programFullScheduleState &&
          settingsScreenState == other.settingsScreenState &&
          pushNotificationsState == other.pushNotificationsState;
}
