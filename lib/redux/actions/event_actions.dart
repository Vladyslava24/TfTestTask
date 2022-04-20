import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';

class SessionStartAction extends TrackableAction {
  final int time;

  SessionStartAction({@required this.time});

  @override
  Event event() => Platform.isIOS ? Event.SESSION_START_IOS : Event.SESSION_START_ANDROID;

  @override
  Map<String, String> parameters() => {'time': time.toString()};
}

class SessionEndAction extends TrackableAction {
  final int duration;

  SessionEndAction(this.duration);

  @override
  Event event() => Event.SESSION_END;

  @override
  Map<String, String> parameters() => {'duration': duration.toString()};
}

class OnPressedTermsOfUseFromSettingsAction extends TrackableAction {
  OnPressedTermsOfUseFromSettingsAction();

  @override
  Event event() => Event.PRESSED_TERMS_OF_USE_FROM_SETTINGS;
}

class OnPressedPrivacyPolicyFromSettingsAction extends TrackableAction {
  OnPressedPrivacyPolicyFromSettingsAction();

  @override
  Event event() => Event.PRESSED_PRIVACY_POLICY_FROM_SETTINGS;
}

class OnPressedSendEmailAction extends TrackableAction {
  OnPressedSendEmailAction();

  @override
  Event event() => Event.PRESSED_SEND_EMAIL_FROM_SETTINGS;
}

class SendFirstLaunchEventAction extends TrackableAction {
  @override
  Event event() => Platform.isIOS ? Event.FIRST_LAUNCH_IOS : Event.FIRST_LAUNCH_ANDROID;
}

class SendGoalsSelectedEventAction extends TrackableAction {
  List<String> goals;

  SendGoalsSelectedEventAction(this.goals);

  @override
  Event event() => Event.INTRO_GOALS_SELECTED;

  @override
  Map<String, String> parameters() => {'goals': json.encode(goals)};
}

class SendLevelSelectedEventAction extends TrackableAction {
  String level;

  SendLevelSelectedEventAction(this.level);

  @override
  Event event() => Event.INTRO_LEVEL_SELECTED;

  @override
  Map<String, String> parameters() => {'level': level};
}

class SendIosNotificationPermissionSelectedEventAction extends TrackableAction {
  bool granted;

  SendIosNotificationPermissionSelectedEventAction(this.granted);

  @override
  Event event() => Event.INTRO_IOS_NOTIFICATION_PERMISSION_SELECTED;

  @override
  Map<String, String> parameters() => {'granted': granted.toString()};
}

class SendIntroShownEventAction extends TrackableAction {
  String screenName;

  SendIntroShownEventAction(this.screenName);

  @override
  Event event() => Event.INTRO_SCREEN_SHOWN;

  @override
  Map<String, String> parameters() => {'screenName': screenName};
}

class SendPressedAmrapFinishedEventAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_AMRAP_FINISHED;
}

class SendScheduleNextWorkoutSkippedEventAction extends TrackableAction {
  @override
  Event event() => Event.SCHEDULE_NEXT_WORKOUT_SKIPPED;
}

class SendScheduleNextWorkoutScheduledEventAction extends TrackableAction {
  final DateTime dateTime;

  SendScheduleNextWorkoutScheduledEventAction(this.dateTime);

  @override
  Event event() => Event.NEXT_WORKOUT_SCHEDULED;

  @override
  Map<String, String> parameters() => {'dateTime': dateTime.toString()};
}

class SendOnboardingEventAction extends TrackableAction {
  final Event onboardingEvent;
  final Map<String, String> attrs;

  SendOnboardingEventAction(this.onboardingEvent, this.attrs);

  @override
  Event event() => onboardingEvent;

  @override
  Map<String, String> parameters() => attrs;
}
