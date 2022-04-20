class PasswordRecoveryRequest {
  final String token;
  final String password;
  final String confirmPassword;

  PasswordRecoveryRequest({this.token, this.password, this.confirmPassword});

  Map<String, dynamic> toMap() => {
    "token": token,
    "password": password,
    "confirmPassword": confirmPassword,
  };
}
