import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';

class ABTestService {
  static ABTestService _instance;
  RemoteConfig _remoteConfig;

  factory ABTestService({@required RemoteConfig config}) =>
    _instance ??= ABTestService._(config: config);

  ABTestService._({RemoteConfig config}) {
    _remoteConfig = config;
    _initRemoteConfig();
  }

  RemoteConfig get remoteConfig => _remoteConfig;

  void _initRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await _remoteConfig.fetchAndActivate();
    await _remoteConfig.setDefaults(<String, dynamic>{
      'onboarding_summary_title': S.current.onboarding_summary_title,
      'onboarding_summary_button_text': S.current.onboarding_summary_button_text,
      'onboarding_summary_cta': S.current.onboarding_summary_cta,
      'paywall_title': S.current.paywall_title,
      'paywall_subtitle_1': S.current.paywall_subtitle_1,
      'paywall_subtitle_2': S.current.paywall_subtitle_2,
      'paywall_button_text': S.current.paywall_button_text,
      'discounts': jsonEncode({
        "paywallProducts": ["tf_1y_5149", "tf_3m_1599", "tf_3m_2_1599"],
      }),
      'discount_value': 0
    });
  }
}