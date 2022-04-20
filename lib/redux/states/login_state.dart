import 'package:core/core.dart';
import 'package:flutter/material.dart';

@immutable
class LoginState {
  final User user;

  LoginState({
    @required this.user,
  });

  factory LoginState.initial() {
    return LoginState(
      user: null,
    );
  }

  bool isLoggedIn() {
    return user != null;
  }

  LoginState copyWith({
    User user
  }) {
    return LoginState(
      user: user,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is LoginState &&
      runtimeType == other.runtimeType &&
      user == other.user;

  @override
  int get hashCode =>
    user.hashCode;
}
