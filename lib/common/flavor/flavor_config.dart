import 'package:flutter/foundation.dart';

import 'flavor.dart';

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig _instance;

  factory FlavorConfig({@required Flavor flavor, @required String name, @required FlavorValues values}) =>
      _instance = FlavorConfig._(flavor, name, values);

  FlavorConfig._(this.flavor, this.name, this.values);

  static FlavorConfig get instance => _instance;

  static String envName() => _instance.name;

  static bool isProd() => _instance.flavor == Flavor.PROD;

  static bool isDev() => _instance.flavor == Flavor.DEV;
}

class FlavorValues {
  final String apiUrl;

  const FlavorValues({@required this.apiUrl});
}
