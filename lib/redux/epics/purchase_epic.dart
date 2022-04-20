import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/exception/purchase_exception.dart';
import 'package:totalfit/model/discount_info_model.dart';
import 'package:totalfit/purchase/purchase.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/purchase_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/purchase_item.dart';

const String fieldDiscount = 'discounts';

Epic<AppState> purchaseEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<SetUserAction>()
        .where((action) => action.getUser() != null)
        .switchMap((action) =>
            Stream.fromFuture(Purchase.getInstance(action.getUser()).then((b) => Purchases.getPurchaserInfo())))
        .switchMap((info) => _purchaseInfoStream(info));
  };
}

Epic<AppState> offeringsEpic(ABTestService abTestService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<SetUserAction>().where((action) => action.getUser() != null).switchMap(
        (action) => Stream.fromFuture(Purchase.getInstance(action.getUser())).switchMap((action) => _getOfferings(abTestService)));
  };
}

_getOfferings(ABTestService abTestService) async* {
  try {
    final offerings = await Purchases.getOfferings();

    final discountsJson = abTestService.remoteConfig.getString(fieldDiscount);

    final discounts = DiscountInfoModel.fromJson(jsonDecode(discountsJson));

    final rawItems = offerings.current.availablePackages.map((package) {
      return PurchaseItem.fromPackage(package);
    }).toList();

    final items = rawItems.where((rawItem) =>
      discounts.paywallProducts.isNotEmpty &&
      discounts.paywallProducts.contains(rawItem.identifier)
    ).toList();

    final discountProductItem = rawItems.singleWhere((rawItem) =>
      rawItem.identifier == discounts.discountProduct, orElse: () => null);

    yield UpdatePurchaseItemListAction(items);
    yield SetDiscountProduct(discountProductItem);
  } catch (e) {
    print('_getOfferings: $e');
    yield ErrorReportAction(where: '_getOfferings', errorMessage: e.toString());
  }
}

Stream<dynamic> _purchaseInfoStream(PurchaserInfo initialPurchaserInfo) {
  StreamSubscription<dynamic> subscription;
  StreamController<dynamic> forwardController;
  StreamController<dynamic> innerController;

  final purchaserInfoUpdateListener = (purchaserInfo) {
    print(' purchaseInfo: $purchaserInfo');
    forwardController.add(UpdatePurchaserInfoAction(purchaserInfo));
  };

  final onError = (e) {
    forwardController.add(ErrorReportAction(where: '_purchaseInfoStream', errorMessage: e.toString()));
    if (e is PlatformException) {
      forwardController.add(OnPurchaseErrorAction(PurchaseException(e.message)));
    }
  };

  final onListen = () {
    try {
      Purchases.addPurchaserInfoUpdateListener(purchaserInfoUpdateListener);
      purchaserInfoUpdateListener(initialPurchaserInfo);
    } catch (e, s) {
      forwardController.addError(e, s);
    }

    subscription = innerController.stream.listen(null, onError: onError, onDone: () {
      innerController.close();
      forwardController.close();
    });
  };

  final onCancel = () {
    try {
      Purchases.removePurchaserInfoUpdateListener(purchaserInfoUpdateListener);
    } catch (e, s) {
      innerController.addError(e, s);
    }
    forwardController.close();
    return subscription.cancel();
  };

  innerController = StreamController<dynamic>();
  forwardController = StreamController<dynamic>(onListen: onListen, onCancel: onCancel);

  return forwardController.stream;
}

Future restoreTransactions() => Purchases.restoreTransactions();

Future purchaseProduct(String productIdentifier) async {
  final result = await Purchases.purchaseProduct(productIdentifier);
  return result;
}
