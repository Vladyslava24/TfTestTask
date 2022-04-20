import 'package:flutter/material.dart';

class EnvironmentResult {
  final String date;
  final bool isComplete;

  EnvironmentResult({@required this.date, @required this.isComplete});

  static const String table_name = "environmental";

  static const String field_date = "date";
  static const String field_isComplete = "isComplete";

  EnvironmentResult.fromJson(json)
      : date = json[field_date],
        isComplete = json[field_isComplete] == null ? false : (json[field_isComplete] as int) == 1;

  Map<String, dynamic> toJson() => {
        field_date: date,
        field_isComplete: isComplete ? 1 : 0,
      };

  int get hashCode => date.hashCode ^ isComplete.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentResult &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          isComplete == other.isComplete;
}
