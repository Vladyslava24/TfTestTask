class WorkoutPhase {
  static const IDLE = WorkoutPhase._("IDLE");
  static const WARMUP = WorkoutPhase._("WARMUP");
  static const SKILL = WorkoutPhase._("SKILL");
  static const WOD = WorkoutPhase._("WOD");
  static const COOLDOWN = WorkoutPhase._("COOLDOWN");
  static const FINISHED = WorkoutPhase._("FINISHED");
  static const NOT_STARTED = WorkoutPhase._("NOT_STARTED");
  static const WP_PART = WorkoutPhase._("WP_PART");
  static const WP_FULL = WorkoutPhase._("WP_FULL");

  static final _swap = [ NOT_STARTED, WARMUP, SKILL, WOD, COOLDOWN, FINISHED, WP_PART, WP_FULL ];

  static WorkoutPhase fromString(String stage) {
    return _swap.firstWhere((e) => e._stage == stage, orElse: () => null);
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
