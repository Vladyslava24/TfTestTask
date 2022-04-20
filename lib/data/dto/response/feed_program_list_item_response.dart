import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../workout_entry_dto.dart';

class FeedProgramItemResponse {
  final List<String> equipment;
  final String goal;
  final String id;
  final String name;
  final String session;
  final String image;
  final int maxWeekNumber;
  final List<LevelType> levels;
  final List<WorkoutEntryDto> workouts;

  FeedProgramItemResponse({
    this.equipment,
    this.goal,
    this.id,
    this.session,
    this.levels,
    this.name,
    this.image,
    this.maxWeekNumber,
    this.workouts,
  });

  FeedProgramItemResponse.fromJson(json)
      : equipment = (json["equipment"] as List).map((e) => e.toString()).toList(),
        workouts = (json["workouts"] as List).map((e) => WorkoutEntryDto.fromMap(e)).toList(),
        goal = json["goal"],
        name = json["name"],
        image = json["image"],
        maxWeekNumber = json["maxWeekNumber"],
        id = json["id"],
        levels = (json["levels"] as List).map((e) => LevelType.fromJson(e)).toList(),
        session = json["session"];
}

class LevelType {
  static const BEGINNER = LevelType._(key: "BEGINNER", uiName: 'BEGINNER');
  static const INTERMEDIATE = LevelType._(key: "INTERMEDIATE", uiName: 'INTERMEDIATE');
  static const ADVANCED = LevelType._(key: "ADVANCED", uiName: 'ADVANCED');

  final String key;
  final String uiName;

  const LevelType._({@required this.key, @required this.uiName});

  static const List<LevelType> LIST = const [BEGINNER, INTERMEDIATE, ADVANCED];

  static LevelType fromJson(String name) {
    if (name == null) {
      return null;
    }
    return LIST.firstWhere((element) => element.key == name.toUpperCase());
  }
}

extension StringDescription on LevelType {
  String getDescription(BuildContext context) {
    switch (this) {
      case LevelType.BEGINNER:
        return S.of(context).choose_program_level__beginner_description;
      case LevelType.INTERMEDIATE:
        return S.of(context).choose_program_level__intermediate_description;
      case LevelType.ADVANCED:
        return S.of(context).choose_program_level__advanced_description;
      default:
        return "";
    }
  }
}
