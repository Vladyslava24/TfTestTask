import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:totalfit/model/reminder_notification.dart';
import 'package:totalfit/totalfit_app.dart';
import 'package:totalfit/ui/utils/time_zone.dart';

const String EMPTY_NOTIFICATION_PAYLOAD = "EMPTY_NOTIFICATION_PAYLOAD";
const String DEFAULT_NOTIFICATION_PAYLOAD = "DEFAULT_NOTIFICATION_PAYLOAD";
const String ID_NOTIFICATION_NEXT_WORKOUT_MESSAGE =
    "ID_NOTIFICATION_NEXT_WORKOUT_MESSAGE";

final BehaviorSubject<ReminderNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject.seeded(DEFAULT_NOTIFICATION_PAYLOAD);

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('ic_notification');

  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReminderNotification(
            id: id, title: title, body: body, payload: payload));
      });

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
    selectNotificationSubject.add(ID_NOTIFICATION_NEXT_WORKOUT_MESSAGE);
  });
}

Future<bool> requestIOSPermissions() {
  return flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

Future<void> turnOffNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> turnOffNotificationById(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    num id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> scheduleNotificationsDailyAtTime(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String title,
    String body,
    tz.TZDateTime notificationTime) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      id, 'Totalfit notifications', 'Totalfit reminders',
      icon: 'ic_notification', styleInformation: BigTextStyleInformation(body));
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      777, title, body, notificationTime, platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime);
}

Future<tz.TZDateTime> scheduledDate(year, month, day, hour, minute) async {
  final timeZone = TimeZone();
  final timeZoneName = await timeZone.getTimeZoneName();
  final location = await timeZone.getLocation(timeZoneName);
  final dateTime = DateTime(year, month, day, hour, minute);
  final scheduledDate = tz.TZDateTime.from(dateTime, location);
  return scheduledDate;
}
