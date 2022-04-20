class HealthyHabitDto {
  String name;

  HealthyHabitDto.fromMap(jsonMap) : name = jsonMap["name"];
}
