import 'package:purchases_flutter/models/transaction.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaserInfoExt implements PurchaserInfo {
  PurchaserInfoExt();

  @override
  List<String> get activeSubscriptions => ["1"];

  @override
  Map<String, String> get allExpirationDates => throw UnimplementedError();

  @override
  Map<String, String> get allPurchaseDates => throw UnimplementedError();

  @override
  List<String> get allPurchasedProductIdentifiers => throw UnimplementedError();

  @override
  EntitlementInfos get entitlements => throw UnimplementedError();

  @override
  String get firstSeen => throw UnimplementedError();

  @override
  String get latestExpirationDate => throw UnimplementedError();

  @override
  String get managementURL => throw UnimplementedError();

  @override
  List<Transaction> get nonSubscriptionTransactions => throw UnimplementedError();

  @override
  String get originalAppUserId => throw UnimplementedError();

  @override
  String get originalApplicationVersion => throw UnimplementedError();

  @override
  String get originalPurchaseDate => throw UnimplementedError();

  @override
  String get requestDate => throw UnimplementedError();

  @override
  // TODO: implement copyWith
  $PurchaserInfoCopyWith<PurchaserInfo> get copyWith => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
