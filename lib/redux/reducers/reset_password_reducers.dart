import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/redux/actions/reset_password_actions.dart';
import 'package:totalfit/redux/states/reset_password_state.dart';
import 'package:totalfit/model/reset_stage.dart';

final resetPasswordReducer = combineReducers<ResetPasswordState>([
  TypedReducer<ResetPasswordState, UpdateResetPasswordStateAction>(_onUpdateResetPasswordStateAction),
  TypedReducer<ResetPasswordState, OnResetPasswordExceptionAction>(_onResetPasswordErrorAction),
  TypedReducer<ResetPasswordState, ClearResetPasswordExceptionAction>(_clearResetPasswordExceptionAction),
  TypedReducer<ResetPasswordState, ValidateEmailForResetPasswordAction>(_validateEmail),
  TypedReducer<ResetPasswordState, ChangeResetPasswordLoadingStateAction>(_changeLoadingStateAction),
  TypedReducer<ResetPasswordState, ResetPasswordEmailErrorAction>(_emailErrorAction),
  TypedReducer<ResetPasswordState, ClearEmailForResetPasswordErrorAction>(_clearEmailErrorAction),
  TypedReducer<ResetPasswordState, OnResetPasswordRequestSuccessAction>(_onResetPasswordRequestSuccessAction),
  TypedReducer<ResetPasswordState, OnResetPasswordVerificationCodeSendSuccessAction>(
      _onResetPasswordVerificationCodeSendSuccessAction),
  TypedReducer<ResetPasswordState, ResetPasswordCodeErrorAction>(_verificationCodeErrorAction),
  TypedReducer<ResetPasswordState, NewPasswordErrorAction>(_newPasswordErrorAction),
  TypedReducer<ResetPasswordState, ConfirmNewPasswordErrorAction>(_confirmNewPasswordErrorAction),
  TypedReducer<ResetPasswordState, ClearNewPasswordErrorAction>(_clearClearNewPasswordErrorAction),
  TypedReducer<ResetPasswordState, ClearConfirmNewPasswordErrorAction>(_clearClearConfirmNewPasswordErrorAction),
  TypedReducer<ResetPasswordState, OnNewPasswordSuccessAction>(_onNewPasswordSuccessAction),
]);

ResetPasswordState _onUpdateResetPasswordStateAction(ResetPasswordState state, UpdateResetPasswordStateAction action) =>
    state.copyWith(stage: action.deepLink != null ? ResetStage.Update : ResetStage.Request);

ResetPasswordState _onResetPasswordErrorAction(ResetPasswordState state, OnResetPasswordExceptionAction action) =>
    state.copyWith(isLoading: false, error: action.error);

ResetPasswordState _clearResetPasswordExceptionAction(
        ResetPasswordState state, ClearResetPasswordExceptionAction action) =>
    state.copyWith(isLoading: false, error: IdleException());

ResetPasswordState _validateEmail(ResetPasswordState state, ValidateEmailForResetPasswordAction action) {
  return state.copyWith(email: action.email);
}

ResetPasswordState _changeLoadingStateAction(ResetPasswordState state, ChangeResetPasswordLoadingStateAction action) =>
    state.copyWith(isLoading: action.isLoading);

ResetPasswordState _emailErrorAction(ResetPasswordState state, ResetPasswordEmailErrorAction action) {
  return state.copyWith(emailError: action.message);
}

ResetPasswordState _verificationCodeErrorAction(ResetPasswordState state, ResetPasswordCodeErrorAction action) {
  return state.copyWith(codeError: action.message);
}

ResetPasswordState _newPasswordErrorAction(ResetPasswordState state, NewPasswordErrorAction action) {
  return state.copyWith(newPasswordError: action.message);
}

ResetPasswordState _confirmNewPasswordErrorAction(ResetPasswordState state, ConfirmNewPasswordErrorAction action) {
  return state.copyWith(confirmNewPasswordError: action.message);
}

ResetPasswordState _clearEmailErrorAction(ResetPasswordState state, ClearEmailForResetPasswordErrorAction action) =>
    state.copyWith(emailError: "");

ResetPasswordState _clearClearNewPasswordErrorAction(ResetPasswordState state, ClearNewPasswordErrorAction action) =>
    state.copyWith(newPasswordError: "");

ResetPasswordState _clearClearConfirmNewPasswordErrorAction(
        ResetPasswordState state, ClearConfirmNewPasswordErrorAction action) =>
    state.copyWith(confirmNewPasswordError: "");

ResetPasswordState _onResetPasswordRequestSuccessAction(
        ResetPasswordState state, OnResetPasswordRequestSuccessAction action) =>
    state.copyWith(stage: ResetStage.BackToLogin, isLoading: false);

ResetPasswordState _onResetPasswordVerificationCodeSendSuccessAction(
        ResetPasswordState state, OnResetPasswordVerificationCodeSendSuccessAction action) =>
    state.copyWith(stage: ResetStage.Update, token: action.token, isLoading: false);

ResetPasswordState _onNewPasswordSuccessAction(ResetPasswordState state, OnNewPasswordSuccessAction action) =>
    state.copyWith(
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
      error: IdleException()
    );
