part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class ValidateEmail extends SignInEvent {
  @override
  List<Object> get props => [];
}

class ValidatePassword extends SignInEvent {
  @override
  List<Object> get props => [];
}

class ChangeEmail extends SignInEvent {
  final String value;
  const ChangeEmail(this.value);
  @override
  List<Object> get props => [value];
}

class ChangePassword extends SignInEvent {
  final String value;
  const ChangePassword(this.value);
  @override
  List<Object> get props => [value];
}

class ChangeObscureText extends SignInEvent {
  final bool value;
  const ChangeObscureText(this.value);
  @override
  List<Object> get props => [value];
}

class SubmitForm extends SignInEvent {
  final String email;
  final String password;
  const SubmitForm({
    @required this.email,
    @required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class SignInWithSocial extends SignInEvent {
  final LoginType type;
  const SignInWithSocial({
    @required this.type
  });
  @override
  List<Object> get props => [type];
}