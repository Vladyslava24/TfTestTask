import 'package:flutter/foundation.dart';

class SessionState {
  final int startTime;

  SessionState({@required this.startTime});

  factory SessionState.initial() {
    return SessionState(startTime: DateTime.now().millisecondsSinceEpoch);
  }

  SessionState copyWith({
    int startTime,
  }) {
    return SessionState(startTime: startTime);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionState && runtimeType == other.runtimeType && startTime == other.startTime;

  @override
  int get hashCode => startTime.hashCode;
}
