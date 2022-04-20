import 'package:flutter/material.dart';

@immutable
class SettingsScreenState {
  final String videoCacheSize;

  SettingsScreenState({@required this.videoCacheSize});

  factory SettingsScreenState.initial() {
    return SettingsScreenState(videoCacheSize: "");
  }

  SettingsScreenState copyWith({String videoCacheSize}) {
    return SettingsScreenState(videoCacheSize: videoCacheSize);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsScreenState &&
          runtimeType == other.runtimeType &&
          videoCacheSize == other.videoCacheSize;

  @override
  int get hashCode => videoCacheSize.hashCode;
}
