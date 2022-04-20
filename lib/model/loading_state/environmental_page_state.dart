class EnvironmentalPageState {
  static const EnvironmentalPageState IDLE = EnvironmentalPageState._("IDLE", null);
  static const EnvironmentalPageState UPDATING = EnvironmentalPageState._("UPDATING", null);

  final String _name;
  final String _error;

  factory EnvironmentalPageState.error(String error) {
    return EnvironmentalPageState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const EnvironmentalPageState._(this._name, this._error);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentalPageState && runtimeType == other.runtimeType && _name == other._name && _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;
}
