class BreathingPageState {
  static const BreathingPageState INITIAL = BreathingPageState._("INITIAL", null);
  static const BreathingPageState LOADING = BreathingPageState._("LOADING", null);
  static const BreathingPageState COMPLETED = BreathingPageState._("COMPLETED", null);

  final String _name;
  final String _error;

  factory BreathingPageState.error(String error) {
    return BreathingPageState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const BreathingPageState._(this._name, this._error);

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is BreathingPageState &&
      runtimeType == other.runtimeType &&
      _name == other._name &&
      _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;
}
