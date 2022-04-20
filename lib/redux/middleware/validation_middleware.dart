import 'package:redux/redux.dart';
import 'package:totalfit/common/strings.dart';
import 'package:totalfit/redux/actions/reset_password_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';

class ValidationMiddleware extends MiddlewareClass<AppState> {
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is ValidateEmailForResetPasswordAction) {
      validateEmailForResetPasswordAction(action.email, next);
      if (store.state.resetPasswordState.emailError.isEmpty) {
        next(ResetPasswordAction(action.email));
      }
    }

    if (action is ValidateNewPasswordAction) {
      validateNewPassword(action.password, next);
      validateConfirmNewPassword(action.password, action.confirmPassword, next);
      if (store.state.resetPasswordState.newPasswordError.isEmpty &&
          store.state.resetPasswordState.confirmNewPasswordError.isEmpty) {
        next(SendNewPasswordAction(action.password, action.deepLink));
        next(CompletedPasswordChanges());
      }
    }

    next(action);
  }

  void validateEmailForResetPasswordAction(String email, NextDispatcher next) {
    RegExp exp = new RegExp(emailPattern);
    List<String> parts = email.split("@");

    if (email.isEmpty) {
      next(new ResetPasswordEmailErrorAction(empty_email_error));
    } else if (!email.contains("@")) {
      next(new ResetPasswordEmailErrorAction(email_error_2));
    } else if (parts.length == 2 && parts.last.isEmpty) {
      next(new ResetPasswordEmailErrorAction(email_error_3));
    } else if (!exp.hasMatch(email)) {
      next(new ResetPasswordEmailErrorAction(email_error));
    } else {
      next(new ResetPasswordEmailErrorAction(""));
    }
  }

  void validateResetPasswordCode(String code, NextDispatcher next) {
    if (code.isEmpty) {
      next(new ResetPasswordCodeErrorAction(empty_field_error));
    } else {
      next(new ResetPasswordCodeErrorAction(""));
    }
  }

  void validateNewPassword(String password, NextDispatcher next) {
    if (password.isEmpty) {
      next(NewPasswordErrorAction(empty_field_error));
    } else {
      if (password.length < 6) {
        next(NewPasswordErrorAction(password_error));
      } else {
        next(NewPasswordErrorAction(""));
      }
    }
  }

  void validateConfirmNewPassword(
      String password, String confirmPassword, NextDispatcher next) {
    if (confirmPassword.isEmpty) {
      next(ConfirmNewPasswordErrorAction(empty_field_error));
    } else {
      if (password != confirmPassword) {
        next(ConfirmNewPasswordErrorAction(not_matching_passwords_error));
      } else {
        next(ConfirmNewPasswordErrorAction(""));
      }
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
