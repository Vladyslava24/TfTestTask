part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class ValidateEmail extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class ValidatePassword extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class ChangePrivacyChecked extends SignUpEvent {
  final bool value;

  const ChangePrivacyChecked(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeEmailNotificationAllowance extends SignUpEvent {
  final bool value;

  const ChangeEmailNotificationAllowance(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeShowTooltip extends SignUpEvent {
  final bool value;

  const ChangeShowTooltip(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeEmail extends SignUpEvent {
  final String value;

  const ChangeEmail(this.value);

  @override
  List<Object> get props => [value];
}

class ChangePassword extends SignUpEvent {
  final String value;

  const ChangePassword(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeObscureText extends SignUpEvent {
  final bool value;

  const ChangeObscureText(this.value);

  @override
  List<Object> get props => [value];
}

class SubmitForm extends SignUpEvent {
  final String email;
  final String password;
  final bool privacyAccepted;

  const SubmitForm({@required this.email, @required this.password, @required this.privacyAccepted});

  @override
  List<Object> get props => [email, password, privacyAccepted];
}

class SignUpWithSocial extends SignUpEvent {
  final SignUpType type;
  final bool privacyAccepted;

  const SignUpWithSocial({@required this.type, @required this.privacyAccepted});

  @override
  List<Object> get props => [type, privacyAccepted];
}
