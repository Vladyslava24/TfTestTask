import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:totalfit/analytics/analytic_service.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/purchaser_info_ext.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import '../../model/purchase_item.dart';

class UpdatePurchaserInfoAction {
  PurchaserInfo purchaserInfo;

  UpdatePurchaserInfoAction(this.purchaserInfo);
}

class UpdatePurchaseItemListAction {
  List<PurchaseItem> items;

  UpdatePurchaseItemListAction(this.items);
}

class SetDiscountProduct {
  PurchaseItem item;

  SetDiscountProduct(this.item);
}

class OnPurchaseErrorAction {
  TfException exception;

  OnPurchaseErrorAction(this.exception);
}

class ClearPurchaseErrorAction {}

class MockChangePremiumStatusAction {
  PurchaserInfo purchaserInfo = PurchaserInfoExt();
}

class TrialStartedEventAction extends TrackableAction {
  final String sku;

  TrialStartedEventAction({this.sku});

  @override
  void logEvent(AnalyticService service) {
    service.logSubscriptionEvent(event: event(), sku: sku);
  }

  @override
  Event event() => Platform.isIOS ? Event.TRIAL_STARTED_IOS : Event.TRIAL_STARTED_ANDROID;
}

class CloseTrialEventAction extends TrackableAction {
  @override
  Event event() => Event.TRIAL_CLOSED;
}
