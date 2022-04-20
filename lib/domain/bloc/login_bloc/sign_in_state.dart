part of 'sign_in_bloc.dart';

@immutable
class SignInLocalState extends Equatable {
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final bool obscureText;
  final FormStatus formStatus;
  final LoginType signInSocialType;
  final User user;
  final TfException error;

  const SignInLocalState._({
    this.email,
    this.emailError,
    this.password,
    this.passwordError,
    this.obscureText,
    this.formStatus,
    this.signInSocialType,
    this.user,
    this.error
  });

  SignInLocalState copyWith({
    String email,
    String emailError,
    String password,
    String passwordError,
    bool obscureText,
    FormStatus formStatus,
    LoginType signInSocialType,
    User user,
    TfException error
  }) {
    return SignInLocalState._(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      obscureText: obscureText ?? this.obscureText,
      formStatus: formStatus ?? this.formStatus,
      signInSocialType: signInSocialType ?? this.signInSocialType,
      user: user ?? this.user,
      error: error ?? this.error
    );
  }

  factory SignInLocalState.initial() => SignInLocalState._(
    email: '',
    emailError: '',
    password: '',
    passwordError: '',
    obscureText: true,
    formStatus: FormStatus.pure,
    signInSocialType: null,
    user: null,
    error: null
  );

  @override
  List<Object> get props => [
    email,
    emailError,
    password,
    passwordError,
    obscureText,
    formStatus,
    signInSocialType,
    user,
    error
  ];
}
