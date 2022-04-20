import 'package:core/core.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:totalfit/ui/screen/main/main_screen.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:totalfit/model/link/app_links.dart';

class PopScreenAction {}

class NavigateToLoginAction {}

class NavigateToOnboardingScreenAction {}

class NavigateToSettings extends TrackableAction {
  @override
  Event event() => Event.PRESSED_SETTINGS;
}

class NavigateToProfileEdit extends TrackableAction {
  @override
  Event event() => Event.PRESSED_EDIT_PROFILE;
}

class NavigateToSoundSetting extends TrackableAction {
  @override
  Event event() => Event.PRESSED_SOUND_SETTINGS;
}

class NavigateToStorageSetting extends TrackableAction {
  @override
  Event event() => Event.PRESSED_STORAGE_SETTINGS;
}

class NavigateToNotificationsSettingsAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_NAVIGATION_SETTINGS;
}

class NavigateToMainScreenAction {}

class ShowMainScreenAction {}

class NavigateToSignUpAction {}

class NavigateToEntryScreenAction {}

class NavigateToExploreWorkoutsListAction {
  final String title;
  final List<WorkoutDto> workouts;

  NavigateToExploreWorkoutsListAction({
    @required this.title,
    @required this.workouts
  });
}

class NavigateToResetPasswordAction extends TrackableAction {
  final ResetPasswordLink deepLink;

  NavigateToResetPasswordAction({this.deepLink});

  @override
  Event event() => Event.PRESSED_RESET_PASSWORD;
}

class NavigateBackToSplashScreenAction {}

class GetProgressListForProfileAction {
  final String userEmail;

  GetProgressListForProfileAction({@required this.userEmail});
}

class UpdateSelectedTab {
  final BottomTab tab;

  UpdateSelectedTab({@required this.tab});
}

class OnUpdateEnvironmentalAction {}

class UpdateProfileAction extends TrackableAction {
  User user;

  UpdateProfileAction({@required this.user});

  @override
  Event event() => Event.PRESSED_EDIT_PROFILE_FROM_SETTINGS;
}

class UpdateProfileImageAction {
  String imagePath;

  UpdateProfileImageAction({@required this.imagePath});
}

class NavigateToProgramShareResultPage extends TrackableAction {
  final FinishProgramResponse response;

  NavigateToProgramShareResultPage(this.response);

  @override
  Event event() => Event.PRESSED_PROGRAM_SUMMARY_SHARE;
}
