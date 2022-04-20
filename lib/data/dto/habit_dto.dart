
class HabitDto {
  String id;
  bool chosen;
  bool recommended;
  bool completed;
  Habit habit;

  HabitDto({this.id, this.chosen, this.habit, this.recommended, this.completed});

  // in ProgressResponse always comes as 'recommended'
  HabitDto.fromMap(jsonMap)
      : id = jsonMap["id"],
        chosen = jsonMap["chosen"],
        recommended = jsonMap["recommended"],
        completed = jsonMap["completed"],
        habit = Habit.fromMap(jsonMap["healthyLifestyleHabit"]);

  int get hashCode => id.hashCode ^ chosen.hashCode ^ recommended.hashCode ^ habit.hashCode;

  @override
  bool operator ==(Object other) =>
      other is HabitDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          chosen == other.chosen &&
          recommended == other.recommended &&
          habit == other.habit;
}

class Habit {
  String id;
  String name;
  String tag;

  Habit({
    this.id,
    this.name,
    this.tag,
  });

  Habit.fromMap(jsonMap)
      : id = jsonMap["id"],
        name = jsonMap["name"],
        tag = jsonMap["tag"];

  int get hashCode => id.hashCode ^ name.hashCode ^ tag.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Habit && runtimeType == other.runtimeType && id == other.id && name == other.name && tag == other.tag;
}