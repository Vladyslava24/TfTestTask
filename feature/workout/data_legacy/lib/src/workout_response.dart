import 'package:workout_data_legacy/src/workout_dto.dart';

class WorkoutResponse {
  int pagesCount;
  String totalElements;
  List<WorkoutDto> workouts;

  WorkoutResponse.fromMap(jsonMap)
      : pagesCount = jsonMap["pagesCount"],
        totalElements = jsonMap["totalElements"],
        workouts = (jsonMap["objects"] as List).map((e) => WorkoutDto.fromMap(e)).toList();
}
