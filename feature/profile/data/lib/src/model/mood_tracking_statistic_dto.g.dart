// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_tracking_statistic_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoodItemDto _$$_MoodItemDtoFromJson(Map<String, dynamic> json) =>
    _$_MoodItemDto(
      json['date'] as String,
      $enumDecode(_$StatisticMeasureEnumMap, json['measureType']),
      (json['moodStates'] as List<dynamic>)
          .map((e) => MoodStateDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MoodItemDtoToJson(_$_MoodItemDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'measureType': _$StatisticMeasureEnumMap[instance.measureType],
      'moodStates': instance.moodStates,
    };

const _$StatisticMeasureEnumMap = {
  StatisticMeasure.DAY: 'DAY',
  StatisticMeasure.WEEK: 'WEEK',
  StatisticMeasure.MONTH: 'MONTH',
};
