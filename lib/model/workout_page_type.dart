class WorkoutPageType {
  static const WARMUP = WorkoutPageType._("WARMUP");
  static const SKILL = WorkoutPageType._("SKILL");
  static const WOD = WorkoutPageType._("WOD");
  static const COOLDOWN = WorkoutPageType._("COOLDOWN");
  static const FINISHED = WorkoutPageType._("FINISHED");

  final String name;

  const WorkoutPageType._(this.name);

  @override
  String toString() {
    return name;
  }

  static WorkoutPageType fromString(String type) {
    if (type == WARMUP.name) {
      return WARMUP;
    }
    if (type == SKILL.name) {
      return SKILL;
    }
    if (type == WOD.name) {
      return WOD;
    }
    if (type == COOLDOWN.name) {
      return COOLDOWN;
    }
    if (type == FINISHED.name) {
      return FINISHED;
    }
    throw "IllegalArgumentException $type";
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutPageType &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
