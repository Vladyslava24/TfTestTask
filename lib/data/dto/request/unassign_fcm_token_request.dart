import 'package:flutter/material.dart';

class UnAssignFCMTokenRequest {
  final String deviceToken;

  UnAssignFCMTokenRequest({
    @required this.deviceToken,
  });

  Map<String, dynamic> toMap() => {
    "deviceId": deviceToken,
  };
}