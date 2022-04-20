class HabitPageState {
  static const HabitPageState INITIAL = HabitPageState._("INITIAL", null);
  static const HabitPageState LOADING = HabitPageState._("LOADING", null);
  static const HabitPageState COMPLETED = HabitPageState._("COMPLETED", null);

  final String _name;
  final String _error;

  factory HabitPageState.error(String error) {
    return HabitPageState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const HabitPageState._(this._name, this._error);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitPageState && runtimeType == other.runtimeType && _name == other._name && _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;

  @override
  String toString() => _name;
}
