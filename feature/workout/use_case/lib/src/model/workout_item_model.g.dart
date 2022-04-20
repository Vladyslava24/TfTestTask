// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutItemModel _$WorkoutItemModelFromJson(Map<String, dynamic> json) =>
    WorkoutItemModel(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as bool,
    );

Map<String, dynamic> _$WorkoutItemModelToJson(WorkoutItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'value': instance.value,
    };
