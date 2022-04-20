import 'package:flutter/foundation.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/reset_stage.dart';

class ResetPasswordState {
  final bool isLoading;
  final ResetStage stage;
  final String email;
  final String emailError;
  final String code;
  final String codeError;
  final String newPassword;
  final String newPasswordError;
  final String confirmNewPassword;
  final String confirmNewPasswordError;
  final String token;
  final Exception error;

  ResetPasswordState(
      {@required this.isLoading,
      @required this.stage,
      @required this.email,
      @required this.emailError,
      @required this.code,
      @required this.codeError,
      @required this.newPassword,
      @required this.newPasswordError,
      @required this.confirmNewPassword,
      @required this.confirmNewPasswordError,
      @required this.token,
      @required this.error});

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
        isLoading: false,
        stage: ResetStage.Request,
        email: null,
        emailError: "",
        code: null,
        codeError: "",
        newPassword: null,
        newPasswordError: "",
        confirmNewPassword: null,
        confirmNewPasswordError: "",
        token: null,
        error: IdleException());
  }

  ResetPasswordState copyWith({
    ResetStage stage,
    bool isLoading,
    String email,
    String emailError,
    String code,
    String codeError,
    String newPassword,
    String newPasswordError,
    String confirmNewPassword,
    String confirmNewPasswordError,
    String token,
    Exception error,
  }) {
    return ResetPasswordState(
        isLoading: isLoading ?? this.isLoading,
        stage: stage ?? this.stage,
        email: email ?? this.email,
        emailError: emailError ?? this.emailError,
        code: code ?? this.code,
        codeError: codeError ?? this.codeError,
        newPassword: newPassword ?? this.newPassword,
        newPasswordError: newPasswordError ?? this.newPasswordError,
        confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
        confirmNewPasswordError: confirmNewPasswordError ?? this.confirmNewPasswordError,
        token: token ?? this.token,
        error: error ?? this.error);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResetPasswordState &&
          isLoading == other.isLoading &&
          stage == other.stage &&
          email == other.email &&
          emailError == other.emailError &&
          code == other.code &&
          codeError == other.codeError &&
          newPassword == other.newPassword &&
          newPasswordError == other.newPasswordError &&
          confirmNewPassword == other.confirmNewPassword &&
          confirmNewPasswordError == other.confirmNewPasswordError &&
          token == other.token &&
          error == other.error;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      stage.hashCode ^
      email.hashCode ^
      emailError.hashCode ^
      code.hashCode ^
      codeError.hashCode ^
      newPassword.hashCode ^
      newPasswordError.hashCode ^
      confirmNewPassword.hashCode ^
      confirmNewPasswordError.hashCode ^
      token.hashCode ^
      error.hashCode;
}
