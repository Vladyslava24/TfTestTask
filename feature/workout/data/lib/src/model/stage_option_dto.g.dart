// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_option_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageOptionDto _$StageOptionDtoFromJson(Map<String, dynamic> json) =>
    StageOptionDto(
      metricType: json['metricType'] as String,
      metricQuantity: json['metricQuantity'] as int,
      rests: (json['rests'] as List<dynamic>)
          .map((e) => RestDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StageOptionDtoToJson(StageOptionDto instance) =>
    <String, dynamic>{
      'metricType': instance.metricType,
      'metricQuantity': instance.metricQuantity,
      'rests': instance.rests,
    };
