import 'package:flutter/material.dart';

class DiscountInfoModel {
  final List paywallProducts;
  final String discountProduct;

  DiscountInfoModel({
    @required this.paywallProducts,
    @required this.discountProduct,
  });

  factory DiscountInfoModel.fromJson(Map<String, dynamic> json) {
    final paywallProducts = json['paywallProducts'] != null ?
      json['paywallProducts'].map((e) => e.toString()).toList() : [];
    final discountProduct = json['discountProduct'];
    return DiscountInfoModel(
      paywallProducts: paywallProducts,
      discountProduct: discountProduct,
    );
  }
}