class WorkoutStatus {
  static const idle = WorkoutStatus._("IDLE");
  static const warmup = WorkoutStatus._("WARMUP");
  static const skill = WorkoutStatus._("SKILL");
  static const wod = WorkoutStatus._("WOD");
  static const cooldown = WorkoutStatus._("COOLDOWN");
  static const finished = WorkoutStatus._("FINISHED");

  static final _swap = [idle, warmup, skill, wod, cooldown, finished];

  static WorkoutStatus  fromString(String stage) {
    return _swap.firstWhere((e) => e._name.toUpperCase() == stage, orElse: () => WorkoutStatus.idle);
  }

  bool operator >(WorkoutStatus other) {
    return _swap.indexOf(this) > _swap.indexOf(other);
  }

  bool operator >=(WorkoutStatus other) {
    return _swap.indexOf(this) >= _swap.indexOf(other);
  }

  bool operator <(WorkoutStatus other) {
    return _swap.indexOf(this) < _swap.indexOf(other);
  }

  bool operator <=(WorkoutStatus other) {
    return _swap.indexOf(this) <= _swap.indexOf(other);
  }

  final String _name;

  const WorkoutStatus._(this._name);

  @override
  String toString() => _name;
}