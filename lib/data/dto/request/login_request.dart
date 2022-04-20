import 'package:totalfit/model/log_in_type.dart';

class LogInRequest implements LoginType {
  String email;
  String password;

  LogInRequest({this.email, this.password});

  Map<String, dynamic> toMap() => {
    "email": email,
    "password": password,
  };
}
