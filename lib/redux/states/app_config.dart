import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:totalfit/ui/utils/utils.dart';

@immutable
class AppConfig {
  final List<NewFeature> newFeatures;
  final List<String> premiumWhiteList;

  AppConfig._({@required this.newFeatures, @required this.premiumWhiteList});

  static AppConfig init(String configString) {
    final List<NewFeature> newFeatures = [];
    final List<String> premiumWhiteList = [];
    try {
      if (configString != null) {
        final _config = json.decode(configString) as Map<String, dynamic>;

        if (_config != null) {
          if (_config['new_feature'] != null) {
            newFeatures.addAll((_config['new_feature'] as List).map((e) => NewFeature.fromMap(e)).toList());
          }
          if (_config['premium_white_list'] != null) {
            premiumWhiteList.addAll((_config['premium_white_list'] as List).map((e) => (e as String).toLowerCase()));
          }
        }
      }
    } catch (e) {
      print('$e');
    }

    return AppConfig._(newFeatures: newFeatures, premiumWhiteList: premiumWhiteList);
  }

  @override
  int get hashCode => deepHash(newFeatures) ^ deepHash(premiumWhiteList);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfig &&
          runtimeType == other.runtimeType &&
          deepEquals(newFeatures, other.newFeatures) &&
          deepEquals(premiumWhiteList, other.premiumWhiteList);
}

@immutable
class NewFeature {
  final String image;
  final String title;
  final String description;

  NewFeature({
    @required this.image,
    @required this.title,
    @required this.description,
  });

  NewFeature.fromMap(jsonMap)
      : image = jsonMap['image'],
        title = jsonMap['title'],
        description = jsonMap['description'];

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ description.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewFeature &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          title == other.title &&
          description == other.description;
}
