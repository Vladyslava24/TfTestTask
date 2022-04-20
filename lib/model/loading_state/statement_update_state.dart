class StatementUpdateState {
  static const StatementUpdateState IDLE = StatementUpdateState._("IDLE", null);
  static const StatementUpdateState UPDATING = StatementUpdateState._("UPDATING", null);

  final String _name;
  final String _error;

  factory StatementUpdateState.error(String error) {
    return StatementUpdateState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const StatementUpdateState._(this._name, this._error);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatementUpdateState &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;

  @override
  String toString() => _name;
}
