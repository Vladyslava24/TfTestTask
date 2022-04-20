import 'package:flutter/material.dart';

class PushNotificationsConfigRequest {
  final String deviceToken;

  const PushNotificationsConfigRequest({ @required this.deviceToken });

  String getToken() => deviceToken;

}