// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseDto _$ExerciseDtoFromJson(Map<String, dynamic> json) => ExerciseDto(
      type: json['type'] as String,
      video480: json['video480'] as String,
      video720: json['video720'] as String,
      video1080: json['video1080'] as String,
      tag: json['tag'] as String,
      metrics: json['metrics'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      image: json['previewImage'] as String,
      videoVertical: json['videoVertical'] as String,
    );

Map<String, dynamic> _$ExerciseDtoToJson(ExerciseDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'image': instance.image,
      'quantity': instance.quantity,
      'video480': instance.video480,
      'video720': instance.video720,
      'video1080': instance.video1080,
      'videoVertical': instance.videoVertical,
      'tag': instance.tag,
      'metrics': instance.metrics,
    };
