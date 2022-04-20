import 'package:json_annotation/json_annotation.dart';

part 'send_mood_request.g.dart';

@JsonSerializable(createFactory: false)
class SendMoodRequest {

  final String feelingsGroupId;
  final String feelingId;
  final List<String> moodReasonsIds;
  final String date;
  final String time;

  const SendMoodRequest({
    required this.feelingsGroupId,
    required this.feelingId,
    required this.moodReasonsIds,
    required this.date,
    required this.time
  });

  Map<String, dynamic> toJson() => _$SendMoodRequestToJson(this);
}