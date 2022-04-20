class ProgressState {
  final String _state;

  const ProgressState._(this._state);

  static const ProgressState IDLE = ProgressState._("Idle");
  static const ProgressState COMPLETED = ProgressState._("Completed");

  @override
  String toString() {
    return _state;
  }

  static ProgressState fromString(String state) {
    if (state == null) {
      return IDLE;
    }
    if (state == IDLE._state) {
      return IDLE;
    }
    if (state == COMPLETED._state) {
      return COMPLETED;
    }
    throw "IllegalArgumentException $state";
  }

  bool operator ==(Object other) =>
    identical(this, other) || other is ProgressState &&
    runtimeType == other.runtimeType && _state == other._state;

  @override
  int get hashCode => _state.hashCode;
}
