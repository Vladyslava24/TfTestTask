import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_state.freezed.dart';

@freezed
class MoodState with _$MoodState {
  factory MoodState(int count, String moodMame, String image) = _MoodState;
}
