import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:workout_data/src/model/workout_stage_dto.dart';

part 'workout_dto.g.dart';

@JsonSerializable(createToJson: true)
class WorkoutDto {
  String id;
  String theme;
  String image;
  String difficultyLevel;
  int estimatedTime;
  String plan;
  String badge;
  String priorityStage;
  List<String> equipment;
  List<WorkoutStageDto> stages;

  WorkoutDto({
    required this.id,
    required this.theme,
    required this.image,
    required this.difficultyLevel,
    required this.estimatedTime,
    required this.plan,
    required this.badge,
    required this.priorityStage,
    required this.equipment,
    required this.stages,
  });

  factory WorkoutDto.fromJson(Map<String, dynamic> json) => _$WorkoutDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutDtoToJson(this);
}
