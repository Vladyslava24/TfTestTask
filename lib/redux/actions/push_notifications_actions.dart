import 'package:flutter/cupertino.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';

class OnPushNotificationReceivedAction extends TrackableAction {
  final RemoteMessage message;

  OnPushNotificationReceivedAction(this.message);

  @override
  Event event() => Event.MESSAGE_RECEIVED;
}

class OnRemoveFCMToken {}

class SetupPushNotificationsSettingsAction extends TrackableAction {
  final bool wod;
  final bool dailyReading;
  final bool updatesAndNews;

  SetupPushNotificationsSettingsAction({
    @required this.wod,
    @required this.dailyReading,
    @required this.updatesAndNews
  });

  @override
  Event event() => Event.SETUP_PUSH_NOTIFICATIONS_SETTINGS;
}

class GetPushNotificationsConfig {}

class OnChangedLoadingStatus {
  final bool status;

  OnChangedLoadingStatus({ @required this.status });
}

class ClearConfigErrorAction {}

class OnSetupPushNotificationsConfigErrorAction {
  final String error;

  OnSetupPushNotificationsConfigErrorAction({@required this.error});
}