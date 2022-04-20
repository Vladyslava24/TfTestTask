import 'dart:convert';
import 'dart:io';

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_app_store_subscription.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:adjust_sdk/adjust_play_store_subscription.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:core/core.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:totalfit/model/purchase_item.dart';

class AnalyticService {
  static const ADJUST_TOKEN = 'ylos5r8nzb40';
  FirebaseAnalytics _firebaseAnalytics;
  Amplitude _amplitudeAnalytics;
  FirebaseAnalyticsObserver _navigationObserver;
  FacebookAppEvents _facebookAppEvents;

  static AnalyticService _instance;

  static AnalyticService getInstance() {
    if (_instance == null) {
      _instance = AnalyticService._();
    }

    return _instance;
  }

  AnalyticService._() {
    _firebaseAnalytics = FirebaseAnalytics();
    _navigationObserver = FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
    _facebookAppEvents = FacebookAppEvents();

    _facebookAppEvents.setAdvertiserTracking(enabled: true);

    final adjustConfig = AdjustConfig(
      ADJUST_TOKEN,
      FlavorConfig.isProd() && kReleaseMode ? AdjustEnvironment.production : AdjustEnvironment.sandbox,
    );
    Adjust.start(adjustConfig);

    _amplitudeAnalytics = Amplitude.getInstance();
    _amplitudeAnalytics.init(Platform.isIOS ? '6b62524d7c41f73e1b4b036e3dc04512' : '3d8d345d36fdded65de1d50ffbdbde56');
    _amplitudeAnalytics.trackingSessionEvents(true);
  }

  void logEvent({Event event, Map<String, dynamic> parameters}) {
    _firebaseAnalytics.logEvent(name: event.toString(), parameters: parameters);
    _amplitudeAnalytics.logEvent(event.toString(), eventProperties: parameters);
    _facebookAppEvents.logEvent(name: event.toString(), parameters: parameters);

    final adjustEvent = AdjustEvent(event.adjustToken);
    adjustEvent.addCallbackParameter('parameters', '${jsonEncode(parameters)}');
    Adjust.trackEvent(adjustEvent);

    print("AnalyticService. logEvent: $event, parameters:${jsonEncode(parameters)}");
  }

  void logSubscriptionEvent({Event event, String sku}) {
    if (event == Event.TRIAL_STARTED_ANDROID) {
      AdjustPlayStoreSubscription subscription = new AdjustPlayStoreSubscription(null, null, sku, null, null, null);
      subscription.setPurchaseTime(today());
      Adjust.trackPlayStoreSubscription(subscription);
    } else if (event == Event.TRIAL_STARTED_IOS) {
      AdjustAppStoreSubscription subscription = new AdjustAppStoreSubscription(null, null, sku, null);
      subscription.setTransactionDate(today());
      subscription.setSalesRegion(DateTime.now().timeZoneName);

      Adjust.trackAppStoreSubscription(subscription);
    }
  }

  Future<String> getAdjustId() async {
    int tryCount = 1;
    int delayMillis = 200;
    String id;

    Future<String> tryGetId(int requestDelay) async {
      return await Future.delayed(Duration(milliseconds: requestDelay), () async {
        return Adjust.getAdid();
      });
    }

    while ((id == null || id.isEmpty) && tryCount < 3) {

      id = await tryGetId(delayMillis * tryCount++);
      print("INV: $id");
    }

    return id;
  }

  Future<String> getFBAnonymousId() async {
    int tryCount = 1;
    int delayMillis = 200;
    String id;

    Future<String> tryGetId(int requestDelay) async {
      return await Future.delayed(Duration(milliseconds: requestDelay), () async {
        return _facebookAppEvents.getAnonymousId();
      });
    }

    while ((id == null || id.isEmpty) && tryCount < 3) {

      id = await tryGetId(delayMillis * tryCount++);
      print("INV: $id");
    }

    return id;
  }

  FirebaseAnalyticsObserver getNavigationObserver() => _navigationObserver;
}
