class HabitCompletionToggleResponse {
  String id;
  String date;
  bool done;

  HabitCompletionToggleResponse.fromMap(jsonMap)
      : id = jsonMap["id"],
        date = jsonMap["date"],
        done = jsonMap["done"];
}
