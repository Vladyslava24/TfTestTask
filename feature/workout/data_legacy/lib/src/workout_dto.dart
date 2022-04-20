import 'dart:convert';

import 'package:workout_data/data.dart';
import 'package:workout_data_legacy/src/workout_response.dart';
import 'package:workout_use_case/use_case.dart';

class WorkoutDto {
  int id;
  String theme;
  String image;
  String difficultyLevel;
  int estimatedTime;
  String? plan;
  String? priorityStage;
  List<WorkoutStageDto>? stages;
  List<String>? equipment;

  static const String table_name = 'workout';
  static const String field_id = 'id';
  static const String field_json_content = 'json_content';

  factory WorkoutDto.fromWorkoutV2(WorkoutModel workout) {
    return WorkoutDto(
        id: int.parse(workout.id),
        theme: workout.theme,
        image: workout.image,
        difficultyLevel: workout.difficultyLevel,
        estimatedTime: workout.estimatedTime,
        plan: workout.plan,
        equipment: workout.equipment);
  }

  String get getWorkoutTime => '$estimatedTime min';

  //to parse data fetch from db
  WorkoutDto.fromMap(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] is String ? int.parse(jsonMap['id']) : jsonMap['id'],
        theme = jsonMap['theme'],
        image = jsonMap['image'],
        difficultyLevel = jsonMap['difficultyLevel'],
        estimatedTime = jsonMap['estimatedTime'],
        plan = jsonMap['plan'],
        priorityStage = jsonMap["priorityStage"] ?? "IDLE",
        stages = jsonMap["stages"] != null
            ? List<WorkoutStageDto>.from(
                jsonMap["stages"].map((x) => WorkoutStageDto.fromJson(x)))
            : [],
        equipment = jsonMap['equipment'] != null
            ? jsonMap['equipment']
                .map<String>((e) => e as String)
                .where((String e) => !_equalsIgnoreCase(e, "no equipment"))
                .toList()
            : ["no equipment"];

  static bool _equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'theme': theme,
        'image': image,
        'difficultyLevel': difficultyLevel,
        'estimatedTime': estimatedTime,
        'plan': plan,
        'equipment': json.encode(equipment),
      };

  int get hashCode => id.hashCode ^ theme.hashCode ^ image.hashCode;

  bool isPremium() => plan == 'PREMIUM';

  @override
  bool operator ==(other) {
    if (other is! WorkoutDto) {
      return false;
    }
    final WorkoutDto otherWorkout = other;
    return id == otherWorkout.id &&
        theme == otherWorkout.theme &&
        image == otherWorkout.image;
  }

  //default
  WorkoutDto({
    required this.id,
    required this.theme,
    required this.image,
    required this.difficultyLevel,
    required this.estimatedTime,
    this.plan,
    this.equipment,
    this.stages,
    this.priorityStage,
  });

  factory WorkoutDto.forCarcass() {
    return WorkoutDto(
      estimatedTime: -1,
      image: '',
      difficultyLevel: '',
      id: -1,
      theme: '',
    );
  }

  WorkoutDto copyWith({
    int? id,
    String? theme,
    String? image,
    String? wodType,
    String? difficultyLevel,
    int? estimatedTime,
    String? plan,
    List<String>? equipment,
  }) {
    return WorkoutDto(
      id: id ?? this.id,
      theme: theme ?? this.theme,
      image: image ?? this.image,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      plan: plan ?? this.plan,
      equipment: equipment ?? this.equipment,
    );
  }

  static fromJson(WorkoutResponse responseData) {
    return responseData;
  }
}
