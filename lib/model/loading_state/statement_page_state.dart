class StatementPageState {
  static const StatementPageState INITIAL = StatementPageState._("INITIAL", null);
  static const StatementPageState LOADING = StatementPageState._("LOADING", null);
  static const StatementPageState COMPLETED = StatementPageState._("COMPLETED", null);

  final String _name;
  final String _error;

  factory StatementPageState.error(String error) {
    return StatementPageState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const StatementPageState._(this._name, this._error);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatementPageState && runtimeType == other.runtimeType && _name == other._name && _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;
}
