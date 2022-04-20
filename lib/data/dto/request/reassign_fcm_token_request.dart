import 'package:flutter/material.dart';

class ReAssignFCMTokenRequest {
  final String oldDeviceToken;
  final String deviceToken;

  const ReAssignFCMTokenRequest({
    @required this.oldDeviceToken,
    @required this.deviceToken
  });

  Map<String, dynamic> toMap() => {
    "oldDeviceToken": oldDeviceToken,
    "deviceToken": deviceToken
  };
}