import 'package:flutter/cupertino.dart';

class GrantModel {
  final GrantType type;
  final String key;
  bool value;
  final String title;

  GrantModel({
    @required this.type,
    @required this.key,
    @required this.value,
    @required this.title
  });
}

enum GrantType { all, wod, dailyReading, updatesAndNews }