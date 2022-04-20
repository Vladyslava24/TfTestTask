import 'dart:async';
import 'package:core/core.dart';
import 'package:totalfit/analytics/analytic_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Purchase {
  static Completer<Purchase> _completer;
  static User _user;

  static _init(User user) async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("WlJootocHHqyGFejIybfgWAGuCYmYyCR", appUserId: user.email);
    AnalyticService.getInstance().getFBAnonymousId().then((fbAnonymousId) {
      Purchases.setFBAnonymousID(fbAnonymousId);
    });
    AnalyticService.getInstance().getAdjustId().then((adjustId) {
      Purchases.setAdjustID(adjustId);
    });
    await Purchases.collectDeviceIdentifiers();
  }

  static Future<Purchase> getInstance(User user) async {
    if (_user != user) {
      _completer = null;
      _user = user;
    }
    if (_completer == null) {
      _completer = Completer<Purchase>();
      try {
        await _init(user);
        _completer.complete(Purchase._());
      } on Exception catch (e) {
        print(e);
        _completer.completeError(e);
        _completer = null;
      }
    }
    return _completer.future;
  }

  Purchase._();

  Future<Offerings> getOfferings() {
    return Purchases.getOfferings();
  }

  Future<List<Product>> getProducts(List<String> productIdentifiers) {
    return Purchases.getProducts(productIdentifiers);
  }

  Future<PurchaserInfo> purchaseProduct(String productIdentifier) {
    return Purchases.purchaseProduct(productIdentifier);
  }

  void addPurchaserInfoUpdateListener(PurchaserInfoUpdateListener purchaserInfoUpdateListener) {
    Purchases.addPurchaserInfoUpdateListener(purchaserInfoUpdateListener);
  }

  void removePurchaserInfoUpdateListener(PurchaserInfoUpdateListener listenerToRemove) {
    Purchases.removePurchaserInfoUpdateListener(listenerToRemove);
  }
}
