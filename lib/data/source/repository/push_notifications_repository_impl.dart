import 'dart:async';

import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/request/assign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_config_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_settings_request.dart';
import 'package:totalfit/data/dto/request/reassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/unassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/response/push_notifications_settings_response.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PushNotificationsRepositoryImpl implements PushNotificationsRepository {
  final RemoteStorage remoteStorage;
  final FlutterSecureStorage localStorage;

  static const fieldTokenFCM = 'fieldTokenFCM';

  PushNotificationsRepositoryImpl({
    @required this.remoteStorage,
    @required this.localStorage
  });

  @override
  FutureOr<Null> assignFCMToken(AssignFCMTokenRequest assignFCMTokenRequest) async {
    await remoteStorage.assignFCMToken(assignFCMTokenRequest);
  }

  @override
  Future<void> reAssignFCMToken(ReAssignFCMTokenRequest reAssignFCMTokenRequest) async {
    await remoteStorage.reassignFCMToken(reAssignFCMTokenRequest);
  }

  @override
  Future<void> unAssignFCMToken(UnAssignFCMTokenRequest unAssignFCMTokenRequest) async {
    await remoteStorage.unAssignFCMToken(unAssignFCMTokenRequest);
  }

  @override
  Future<String> getFCMTokenFromStorage() async {
    return localStorage.read(key: fieldTokenFCM);
  }

  @override
  Future<void> removeFCMTokenFromStorage() async {
    await localStorage.delete(key: fieldTokenFCM);
  }

  @override
  Future<void> saveFCMTokenToStorage(String fcmToken) async {
    // print('saveFCMTokenToStorage');
    // print(fcmToken);
    await localStorage.write(key: fieldTokenFCM, value: fcmToken);
  }

  @override
  Future<PushNotificationsSettingsResponse> setupPushNotificationsSettings(PushNotificationsSettingsRequest pushNotificationsSettingsRequest) async {
    return remoteStorage.setupPushNotificationsConfig(pushNotificationsSettingsRequest);
  }

  @override
  Future<PushNotificationsSettingsResponse> getPushNotificationsConfig(PushNotificationsConfigRequest pushNotificationsConfigRequest) async {
    return remoteStorage.getPushNotificationsConfig(pushNotificationsConfigRequest);
  }
}