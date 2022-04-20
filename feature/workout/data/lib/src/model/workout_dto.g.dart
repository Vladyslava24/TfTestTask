// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutDto _$WorkoutDtoFromJson(Map<String, dynamic> json) => WorkoutDto(
      id: json['id'] as String,
      theme: json['theme'] as String,
      image: json['image'] as String,
      difficultyLevel: json['difficultyLevel'] as String,
      estimatedTime: json['estimatedTime'] as int,
      plan: json['plan'] as String,
      badge: json['badge'] as String,
      priorityStage: json['priorityStage'] as String,
      equipment:
          (json['equipment'] as List<dynamic>).map((e) => e as String).toList(),
      stages: (json['stages'] as List<dynamic>)
          .map((e) => WorkoutStageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutDtoToJson(WorkoutDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'theme': instance.theme,
      'image': instance.image,
      'difficultyLevel': instance.difficultyLevel,
      'estimatedTime': instance.estimatedTime,
      'plan': instance.plan,
      'badge': instance.badge,
      'priorityStage': instance.priorityStage,
      'equipment': instance.equipment,
      'stages': instance.stages,
    };
