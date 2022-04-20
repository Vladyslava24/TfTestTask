import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseState {
  final PurchaserInfo purchaserInfo;

  PurchaseState({@required this.purchaserInfo});

  factory PurchaseState.initial() {
    return PurchaseState(purchaserInfo: null);
  }

  PurchaseState copyWith({PurchaserInfo purchaserInfo}) {
    return PurchaseState(purchaserInfo: purchaserInfo ?? this.purchaserInfo);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseState && runtimeType == other.runtimeType && purchaserInfo == other.purchaserInfo;

  @override
  int get hashCode => purchaserInfo.hashCode;
}
