// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_stage_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutStageDto _$WorkoutStageDtoFromJson(Map<String, dynamic> json) =>
    WorkoutStageDto(
      stageName: json['stageName'] as String,
      stageType: json['stageType'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      stageOption:
          StageOptionDto.fromJson(json['stageOption'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkoutStageDtoToJson(WorkoutStageDto instance) =>
    <String, dynamic>{
      'stageName': instance.stageName,
      'stageType': instance.stageType,
      'exercises': instance.exercises,
      'stageOption': instance.stageOption,
    };
