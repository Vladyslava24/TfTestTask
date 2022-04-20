import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:totalfit/data/dto/request/assign_fcm_token_request.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository.dart';
import 'package:totalfit/model/device.dart';
import 'package:totalfit/utils/platform_utils.dart';

class PushNotificationService {
  static PushNotificationService _sInstance;
  FirebaseMessaging _fcm;
  PushNotificationsRepository _pushNotificationsRepository;
  DeviceInfoPlugin _deviceInfoPlugin;

  final StreamController<RemoteMessage> onMessageStreamController =
  StreamController.broadcast();
  final StreamController<RemoteMessage> onMessageOpenedAppStreamController =
  StreamController.broadcast();

  PushNotificationService._(
    this._fcm,
    this._pushNotificationsRepository,
    this._deviceInfoPlugin
  ) {
    _fcm.getToken().then(_handleToken);
    _fcm.onTokenRefresh.listen(_handleToken);
    _fcm.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    FirebaseMessaging.onMessage.listen(_firebaseMessagingMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOpenedAppHandler);
  }

  static Future<PushNotificationService> newInstance(
    PushNotificationsRepository _pushNotificationsRepository,
    DeviceInfoPlugin _deviceInfoPlugin
  ) async {
    if (_sInstance != null) {
      await _sInstance.close();
    }
    _sInstance = PushNotificationService._(
      FirebaseMessaging.instance,
      _pushNotificationsRepository,
      _deviceInfoPlugin
    );
    return _sInstance;
  }

  void _handleToken(String token) async {
    try {
      final oldToken = await _pushNotificationsRepository.getFCMTokenFromStorage()
        .catchError((e) { print('ERROR in read token from prefs $e'); });

      // print('_oldtoken');
      // print(oldToken);
      await _pushNotificationsRepository.saveFCMTokenToStorage(token)
        .catchError((e) {print('Problem with saving: $e');});

      Device deviceData;

      if (Platform.isAndroid) {
        deviceData = readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
      }
      if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
      }

      if (oldToken == null || (oldToken != null && oldToken != token)) {

        final response = await _pushNotificationsRepository.assignFCMToken(
          AssignFCMTokenRequest(
            deviceToken: token,
            platform: getPlatform(),
            locale: getSystemLocale(),
            timeZone: getTimeZone(),
            deviceId: deviceData.identifier,
            model: deviceData.model,
            isPhysicalDevice: deviceData.isPhysicalDevice
          )
        );

        if (response != null) {
          await _pushNotificationsRepository.saveFCMTokenToStorage(token);
          response.catchError((e) { print('ERROR in token assign request $e'); });
        }
      }
    } on PlatformException catch(e) {
      print('Platform exception $e');
    } catch (e) {
      print('ERROR in handling FCM token: $e');
    }
  }

  void _firebaseMessagingMessageHandler(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      onMessageStreamController.add(message);
    }
  }

  void _firebaseMessagingOpenedAppHandler(RemoteMessage message) {
    print('On opened App message!');
    if (message.notification != null) {
      RemoteMessage openedMessage = RemoteMessage(
        senderId: message.senderId,
        category: message.category,
        collapseKey: message.collapseKey,
        contentAvailable: message.contentAvailable,
        data: message.data,
        from: message.from,
        messageId: message.messageId,
        messageType: 'opened',
        mutableContent: message.mutableContent,
        notification: message.notification,
        sentTime: message.sentTime,
        threadId: message.threadId,
        ttl: message.ttl
      );
      onMessageOpenedAppStreamController.add(openedMessage);
    }
  }

  Future close() async {
    await _fcm.deleteToken();
    await onMessageStreamController.close();
    await onMessageOpenedAppStreamController.close();
  }
}