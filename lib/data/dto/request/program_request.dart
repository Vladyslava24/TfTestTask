import 'package:flutter/foundation.dart';
import 'package:totalfit/model/active_program.dart';

class ProgramRequest {
  final String level;
  final int numberOfWeeks;
  final String startDate;
  final String targetId;
  final List<String> daysOfWeek;
  final ActiveProgram program;

  ProgramRequest({
    @required this.targetId,
    this.level,
    this.numberOfWeeks,
    this.startDate,
    this.daysOfWeek,
    this.program,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (level != null) {
      map.putIfAbsent("level", () => level);
    }
    if (targetId != null) {
      map.putIfAbsent("targetId", () => targetId);
    }
    if (numberOfWeeks != null) {
      map.putIfAbsent("numberOfWeeks", () => numberOfWeeks);
    }
    if (startDate != null) {
      map.putIfAbsent("startDate", () => startDate);
    }
    if (daysOfWeek != null) {
      map.putIfAbsent("daysOfWeek", () => daysOfWeek);
    }
    return map;
  }
}
