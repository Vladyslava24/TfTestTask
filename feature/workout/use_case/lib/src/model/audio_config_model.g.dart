// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioConfigModel _$AudioConfigModelFromJson(Map<String, dynamic> json) =>
    AudioConfigModel(
      config: (json['config'] as List<dynamic>)
          .map((e) => WorkoutItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AudioConfigModelToJson(AudioConfigModel instance) =>
    <String, dynamic>{
      'config': instance.config,
    };
