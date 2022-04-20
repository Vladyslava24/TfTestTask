import 'package:core/core.dart';
import 'package:totalfit/model/link/app_links.dart';

class CompletedPasswordChanges {}

class ResetPasswordAction {
  final String email;

  ResetPasswordAction(this.email);
}

class OnResetPasswordExceptionAction {
  final ApiException error;

  OnResetPasswordExceptionAction(this.error);
}

class UpdateResetPasswordStateAction {
  final ResetPasswordLink deepLink;

  UpdateResetPasswordStateAction(this.deepLink);
}

class ClearResetPasswordExceptionAction {}

class ClearNewPasswordErrorAction {}

class ClearConfirmNewPasswordErrorAction {}

class ValidateEmailForResetPasswordAction {
  final String email;

  ValidateEmailForResetPasswordAction(this.email);
}

class ClearEmailForResetPasswordErrorAction {}

class OnResetPasswordRequestSuccessAction {}

class OnResetPasswordVerificationCodeSendSuccessAction {
  final String token;

  OnResetPasswordVerificationCodeSendSuccessAction(this.token);
}

class OnNewPasswordSuccessAction {}

class OnSuccessAction {}

class ChangeResetPasswordLoadingStateAction {
  final bool isLoading;

  ChangeResetPasswordLoadingStateAction(this.isLoading);
}

class ResetPasswordEmailErrorAction {
  final String message;

  ResetPasswordEmailErrorAction(this.message);
}

class ResetPasswordCodeErrorAction {
  final String message;

  ResetPasswordCodeErrorAction(this.message);
}

class NewPasswordErrorAction {
  final String message;

  NewPasswordErrorAction(this.message);
}

class ConfirmNewPasswordErrorAction {
  final String message;

  ConfirmNewPasswordErrorAction(this.message);
}

class ValidateNewPasswordAction {
  final String password;
  final String confirmPassword;
  final ResetPasswordLink deepLink;

  ValidateNewPasswordAction(this.password, this.confirmPassword, this.deepLink);
}

class SendNewPasswordAction {
  final String password;
  final ResetPasswordLink deepLink;

  SendNewPasswordAction(this.password, this.deepLink);
}
