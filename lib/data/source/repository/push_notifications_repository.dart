import 'dart:async';

import 'package:totalfit/data/dto/request/assign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_config_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_settings_request.dart';
import 'package:totalfit/data/dto/request/reassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/unassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/response/push_notifications_settings_response.dart';

abstract class PushNotificationsRepository {
  FutureOr<Null> assignFCMToken(AssignFCMTokenRequest assignFCMTokenRequest);
  Future<void> reAssignFCMToken(ReAssignFCMTokenRequest reAssignFCMTokenRequest);
  Future<void> unAssignFCMToken(UnAssignFCMTokenRequest unAssignFCMTokenRequest);

  Future<String> getFCMTokenFromStorage();
  Future<void> saveFCMTokenToStorage(String fcmToken);
  Future<void> removeFCMTokenFromStorage();

  Future<PushNotificationsSettingsResponse> getPushNotificationsConfig(PushNotificationsConfigRequest pushNotificationsConfigRequest);
  Future<PushNotificationsSettingsResponse> setupPushNotificationsSettings(PushNotificationsSettingsRequest pushNotificationsSettingsRequest);
}