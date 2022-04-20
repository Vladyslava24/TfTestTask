
import 'package:flutter/foundation.dart';

class DeepLinkType {
  static const RESET_PASSWORD = DeepLinkType._(type: "PASSWORD_RESET");

  final String type;

  const DeepLinkType._({@required this.type});

  static List<DeepLinkType> _swap = [RESET_PASSWORD];

  static DeepLinkType byType(String type) {
    return _swap.firstWhere((element) => element.type == type);
  }

  static DeepLinkType fromMap(String type) {
    return byType(type);
  }
}