import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';

class SendFailedToInitOneSignalEventAction extends TrackableAction {
  final String notification;

  SendFailedToInitOneSignalEventAction(this.notification);

  @override
  Event event() => Event.FAILED_TO_INIT_ONE_SIGNAL;

  @override
  Map<String, String> parameters() => {"notification": notification};
}

class SendNotificationReceivedEventAction extends TrackableAction {
  final String notification;

  SendNotificationReceivedEventAction(this.notification);

  @override
  Event event() => Event.NOTIFICATION_RECEIVED;

  @override
  Map<String, String> parameters() => {"notification": notification};
}

class SendNotificationOpenedEventAction extends TrackableAction {
  final String notification;

  SendNotificationOpenedEventAction(this.notification);

  @override
  Event event() => Event.NOTIFICATION_OPENED;

  @override
  Map<String, String> parameters() => {"notification": notification};
}
