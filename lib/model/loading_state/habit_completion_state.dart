class HabitCompletionState {
  static const HabitCompletionState IDLE = HabitCompletionState._("IDLE", null);
  static const HabitCompletionState UPDATING = HabitCompletionState._("UPDATING", null);

  final String _name;
  final String _error;

  factory HabitCompletionState.error(String error) {
    return HabitCompletionState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const HabitCompletionState._(this._name, this._error);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitCompletionState &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;

  @override
  String toString() => _name;
}
