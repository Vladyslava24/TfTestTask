import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:profile_data/src/model/statistic_measure.dart';

import 'mood_state_dto.dart';

part 'mood_tracking_statistic_dto.freezed.dart';

part 'mood_tracking_statistic_dto.g.dart';

@freezed
class MoodTrackingStatisticDto with _$MoodTrackingStatisticDto {
  factory MoodTrackingStatisticDto(List<MoodItemDto> items) =
      _MoodTrackingStatisticDto;
}

@freezed
class MoodItemDto with _$MoodItemDto {
  factory MoodItemDto(String date, StatisticMeasure measureType,
      List<MoodStateDto> moodStates) = _MoodItemDto;

  factory MoodItemDto.fromJson(Map<String, dynamic> json) =>
      _$MoodItemDtoFromJson(json);
}
