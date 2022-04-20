class WisdomPageState {
  static const WisdomPageState INITIAL = WisdomPageState._("INITIAL", null);
  static const WisdomPageState LOADING = WisdomPageState._("LOADING", null);
  static const WisdomPageState COMPLETED = WisdomPageState._("COMPLETED", null);

  final String _name;
  final String _error;

  factory WisdomPageState.error(String error) {
    return WisdomPageState._("ERROR", error);
  }

  bool isError() => _name == "ERROR";

  String getErrorMessage() => _error;

  const WisdomPageState._(this._name, this._error);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WisdomPageState && runtimeType == other.runtimeType && _name == other._name && _error == other._error;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode;
}
