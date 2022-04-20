class WorkoutPhase {
  static const IDLE = WorkoutPhase._("IDLE");
  static const WARMUP = WorkoutPhase._("WARMUP");
  static const SKILL = WorkoutPhase._("SKILL");
  static const WOD = WorkoutPhase._("WOD");
  static const COOLDOWN = WorkoutPhase._("COOLDOWN");
  static const FINISHED = WorkoutPhase._("FINISHED");

  static final _swap = [IDLE, WARMUP, SKILL, WOD, COOLDOWN, FINISHED];

  static WorkoutPhase fromString(String stage) {
    return _swap.firstWhere((e) => e._stage == stage, orElse: () => IDLE);
  }

  bool operator >(WorkoutPhase other) {
    return _swap.indexOf(this) > _swap.indexOf(other);
  }

  bool operator >=(WorkoutPhase other) {
    return _swap.indexOf(this) >= _swap.indexOf(other);
  }

  bool operator <(WorkoutPhase other) {
    return _swap.indexOf(this) < _swap.indexOf(other);
  }

  bool operator <=(WorkoutPhase other) {
    return _swap.indexOf(this) <= _swap.indexOf(other);
  }

  final String _stage;

  const WorkoutPhase._(this._stage);

  @override
  String toString() => _stage;
}
