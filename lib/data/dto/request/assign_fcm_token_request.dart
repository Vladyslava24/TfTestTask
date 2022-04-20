import 'package:flutter/material.dart';

class AssignFCMTokenRequest {
  final String deviceToken;
  final String platform;
  final String locale;
  final String timeZone;
  final String deviceId;
  final String model;
  final bool isPhysicalDevice;

  AssignFCMTokenRequest({
    @required this.deviceToken,
    @required this.platform,
    @required this.locale,
    @required this.timeZone,
    @required this.deviceId,
    @required this.model,
    @required this.isPhysicalDevice
  });

  Map<String, dynamic> toMap() => {
    "deviceToken": deviceToken,
    "platform": platform.toUpperCase(),
    "locale": locale,
    "timeZone": timeZone,
    "deviceId": deviceId,
    "model": model,
    "isPhysicalDevice": isPhysicalDevice
  };
}