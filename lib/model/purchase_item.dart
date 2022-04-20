import 'package:flutter/cupertino.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:core/generated/l10n.dart';

class PurchaseItem {
  final String identifier;
  final String title;
  final String description;
  final PurchaseItemType itemType;
  final double price;
  final String priceString;
  final String currencyCode;
  final List<Discount> discounts;

  PurchaseItem({
    this.identifier,
    this.title,
    this.description,
    this.itemType,
    this.price,
    this.priceString,
    this.currencyCode,
    this.discounts
  });

  double weekPrice() {
    int weeks;
    switch (itemType) {
      case PurchaseItemType.annual:
        weeks = 48;
        break;
      case PurchaseItemType.sixMonth:
        weeks = 24;
        break;

      case PurchaseItemType.threeMonth:
        weeks = 12;
        break;

      case PurchaseItemType.twoMonth:
        weeks = 8;
        break;

      case PurchaseItemType.monthly:
        weeks = 4;
        break;

      case PurchaseItemType.weekly:
        weeks = 1;
        break;
      default:
        weeks = -1;
    }

    return price / weeks;
  }

  factory PurchaseItem.fromPackage(Package package) {
    return PurchaseItem(
      identifier: package.product.identifier,
      title: package.product.title,
      description: package.product.description,
      itemType: from(package.packageType),
      price: package.product.price,
      priceString: package.product.priceString,
      currencyCode: package.product.currencyCode
    );
  }
}

enum PurchaseItemType {
  unknown,
  custom,
  lifetime,
  weekly,
  monthly,
  twoMonth,
  threeMonth,
  sixMonth,
  annual,
}

PurchaseItemType from(PackageType packageType) {
  switch (packageType) {
    case PackageType.unknown:
      return PurchaseItemType.unknown;
    case PackageType.custom:
      return PurchaseItemType.custom;
    case PackageType.lifetime:
      return PurchaseItemType.lifetime;
    case PackageType.annual:
      return PurchaseItemType.annual;
    case PackageType.sixMonth:
      return PurchaseItemType.sixMonth;
    case PackageType.threeMonth:
      return PurchaseItemType.threeMonth;
    case PackageType.twoMonth:
      return PurchaseItemType.twoMonth;
    case PackageType.monthly:
      return PurchaseItemType.monthly;
    case PackageType.weekly:
      return PurchaseItemType.weekly;
    default:
      return PurchaseItemType.unknown;
  }
}

extension StringExtention on PurchaseItemType {
  String stringValue(BuildContext context) {
    switch (this) {
      case PurchaseItemType.unknown:
        return S.of(context).paywall_purchase_item_unknown;
      case PurchaseItemType.custom:
        return S.of(context).paywall_purchase_item_custom;
      case PurchaseItemType.lifetime:
        return S.of(context).paywall_purchase_item_lifetime;
      case PurchaseItemType.annual:
        return S.of(context).paywall_purchase_item_annual;
      case PurchaseItemType.sixMonth:
        return S.of(context).paywall_purchase_item_6_month;
      case PurchaseItemType.threeMonth:
        return S.of(context).paywall_purchase_item_3_month;
      case PurchaseItemType.twoMonth:
        return S.of(context).paywall_purchase_item_2_month;
      case PurchaseItemType.monthly:
        return S.of(context).paywall_purchase_item_monthly;
      case PurchaseItemType.weekly:
        return S.of(context).paywall_purchase_item_weekly;
      default:
        return S.of(context).paywall_purchase_item_unknown;
    }
  }
}
