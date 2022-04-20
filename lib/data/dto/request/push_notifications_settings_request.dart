import 'package:flutter/material.dart';

class PushNotificationsSettingsRequest {
  final String deviceToken;
  final bool wod;
  final bool dailyReading;
  final bool updatesAndNews;

  const PushNotificationsSettingsRequest({
    @required this.deviceToken,
    @required this.wod,
    @required this.dailyReading,
    @required this.updatesAndNews
  });

  Map<String, dynamic> toMap() => {
    "deviceToken": deviceToken,
    "wod": wod,
    "dailyReading": dailyReading,
    "updatesAndNews": updatesAndNews,
  };
}