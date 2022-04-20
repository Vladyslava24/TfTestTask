part of 'sign_up_bloc.dart';

@immutable
class SignUpLocalState extends Equatable {
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final bool obscureText;
  final bool privacyAccepted;
  final bool emailNotificationAllowed;
  final bool showTooltip;
  final FormStatus formStatus;
  final SignUpType signUpType;
  final User user;
  final Exception error;

  const SignUpLocalState._(
      {this.email,
      this.emailError,
      this.password,
      this.passwordError,
      this.obscureText,
      this.privacyAccepted,
      this.emailNotificationAllowed,
      this.showTooltip,
      this.formStatus,
      this.signUpType,
      this.user,
      this.error});

  SignUpLocalState copyWith(
      {String email,
      String emailError,
      String password,
      String passwordError,
      bool obscureText,
      bool privacyAccepted,
      bool emailNotificationAllowed,
      bool showTooltip,
      FormStatus formStatus,
      SignUpType signUpType,
      User user,
      Exception error}) {
    return SignUpLocalState._(
        email: email ?? this.email,
        emailError: emailError ?? this.emailError,
        password: password ?? this.password,
        passwordError: passwordError ?? this.passwordError,
        obscureText: obscureText ?? this.obscureText,
        privacyAccepted: privacyAccepted ?? this.privacyAccepted,
        emailNotificationAllowed: emailNotificationAllowed ?? this.emailNotificationAllowed,
        showTooltip: showTooltip ?? this.showTooltip,
        formStatus: formStatus ?? this.formStatus,
        signUpType: signUpType ?? this.signUpType,
        user: user ?? this.user,
        error: error ?? this.error);
  }

  factory SignUpLocalState.initial() => SignUpLocalState._(
      email: '',
      emailError: '',
      password: '',
      passwordError: '',
      obscureText: true,
      privacyAccepted: false,
      emailNotificationAllowed: false,
      showTooltip: false,
      formStatus: FormStatus.pure,
      signUpType: null,
      user: null,
      error: null);

  @override
  List<Object> get props => [
        email,
        emailError,
        password,
        passwordError,
        obscureText,
        privacyAccepted,
        emailNotificationAllowed,
        showTooltip,
        formStatus,
        signUpType,
        user,
        error
      ];
}
