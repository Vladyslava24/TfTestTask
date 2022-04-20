import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_state_dto.freezed.dart';

part 'mood_state_dto.g.dart';

@freezed
class MoodStateDto with _$MoodStateDto {
  factory MoodStateDto(int count, String moodMame, String image) =
      _MoodStateDto;

  factory MoodStateDto.fromJson(Map<String, dynamic> json) =>
      _$MoodStateDtoFromJson(json);
}
