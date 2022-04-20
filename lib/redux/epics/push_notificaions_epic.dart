import 'dart:async';
import 'package:core/core.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository.dart';
import 'package:totalfit/domain/push_notifications/push_notification_service.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/push_notifications_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:rxdart/rxdart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:totalfit/totalfit_app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

AndroidNotificationChannel channel;

void initNotificationsSettings() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  /// Permissions iOS
  // NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  /// if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  ///   print('User granted permission');
  /// } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  ///   print('User granted provisional permission');
  /// } else {
  ///   print('User declined or has not accepted permission');
  /// }
  /// Create an Android Notification Channel.
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    didReceiveRemoteNotificationSubject.add(message);
  }
}

final BehaviorSubject<RemoteMessage> didReceiveRemoteNotificationSubject =
BehaviorSubject<RemoteMessage>();

Epic<AppState> pushNotificationsEpic() {
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  initNotificationsSettings();

  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
      .whereType<SetUserAction>()
      .switchMap(
        (action) => Stream.fromFuture(
          PushNotificationService.newInstance(
              DependencyProvider.get<PushNotificationsRepository>(),
            DeviceInfoPlugin()
          )
      )
      .switchMap((pushNotificationService) => StreamGroup.merge([
        pushNotificationService.onMessageStreamController.stream,
        pushNotificationService.onMessageOpenedAppStreamController.stream,
        didReceiveRemoteNotificationSubject.stream
      ]))
      .asyncMap((message) async {
        print('message_response');
        print(message.messageType);

        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;

        if (notification != null && android != null && !kIsWeb) {
          await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'full screen channel id',
                'full screen channel name',
                'full screen channel description',
                priority: Priority.high,
                importance: Importance.high,
                fullScreenIntent: true
              )
            ),
          );
        }
        return OnPushNotificationReceivedAction(message);
      })
      .takeUntil(actions.whereType<LogoutAction>()));
  };
}