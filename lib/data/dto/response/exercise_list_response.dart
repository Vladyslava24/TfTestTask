import 'package:workout_data_legacy/data.dart';

class ExerciseListResponse {
  int pagesCount;
  String totalElements;
  List<Exercise> exerciseList;

  ExerciseListResponse.fromMap(jsonMap)
      : pagesCount = jsonMap["pagesCount"],
        totalElements = jsonMap["totalElements"],
        exerciseList = (jsonMap["objects"] as List).map((e) => Exercise.fromJson(e)).toList();
}
