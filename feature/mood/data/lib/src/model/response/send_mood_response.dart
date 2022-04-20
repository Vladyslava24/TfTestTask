import 'package:json_annotation/json_annotation.dart';

part 'send_mood_response.g.dart';

@JsonSerializable(createToJson: false)
class SendMoodResponse {
  final String feelingName;
  final String emoji;
  final String time;

  const SendMoodResponse({
    required this.feelingName,
    required this.emoji,
    required this.time
  });

  factory SendMoodResponse.fromJson(Map<String, dynamic> json) =>
    _$SendMoodResponseFromJson(json);
}