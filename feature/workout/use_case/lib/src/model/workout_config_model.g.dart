// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutConfigModel _$WorkoutConfigModelFromJson(Map<String, dynamic> json) =>
    WorkoutConfigModel(
      uid: json['uid'] as String,
      config: (json['config'] as List<dynamic>)
          .map((e) => WorkoutItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutConfigModelToJson(WorkoutConfigModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'config': instance.config,
    };
