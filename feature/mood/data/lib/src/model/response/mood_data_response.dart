import 'package:json_annotation/json_annotation.dart';

import 'package:mood_data/src/model/response/feeling_group_response.dart';
import 'package:mood_data/src/model/response/feeling_item_response.dart';

part 'mood_data_response.g.dart';

@JsonSerializable(createToJson: false)
class MoodDataResponse {
  final List<FeelingGroupResponse> feelingsGroups;
  final List<FeelingItemResponse> reasons;

  const MoodDataResponse({
    required this.feelingsGroups,
    required this.reasons
  });

  factory MoodDataResponse.fromJson(Map<String, dynamic> json) =>
    _$MoodDataResponseFromJson(json);
}