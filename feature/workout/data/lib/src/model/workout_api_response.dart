import 'package:json_annotation/json_annotation.dart';
import 'package:workout_data/data.dart';

part 'workout_api_response.g.dart';

@JsonSerializable(createToJson: false)
class WorkoutApiResponse {
  int pagesCount;
  String totalElements;
  @JsonKey(name: 'objects')
  List<WorkoutDto> workouts;

  WorkoutApiResponse({
    required this.pagesCount,
    required this.totalElements,
    required this.workouts,
  });

  factory WorkoutApiResponse.fromJson(Map<String, dynamic> json) =>
    _$WorkoutApiResponseFromJson(json);
}
