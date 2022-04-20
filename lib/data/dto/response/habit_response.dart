import '../habit_dto.dart';

class HabitListResponse {
  int pagesCount;
  String totalElements;
  List<Habit> habitList;

  HabitListResponse.fromMap(jsonMap)
      : pagesCount = jsonMap["pagesCount"],
        totalElements = jsonMap["totalElements"],
        habitList = (jsonMap["objects"] as List).map((e) => Habit.fromMap(e)).toList();
}
