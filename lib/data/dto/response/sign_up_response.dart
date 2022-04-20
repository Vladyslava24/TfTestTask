

import 'package:core/core.dart';

class SignUpResponse {
  final String email;
  final String gender;
  final String photo;
  final String birthday;
  final String registerDate;
  final String status;
  final String token;
  final String verifyEmailSent;
  final List<String> roles;
  final bool wasOnboarded;

  SignUpResponse({
    this.email,
    this.gender,
    this.photo,
    this.birthday,
    this.registerDate,
    this.status,
    this.token,
    this.verifyEmailSent,
    this.wasOnboarded,
    this.roles,
  });

  SignUpResponse.fromMap(jsonMap)
      : email = jsonMap["email"],
        gender = jsonMap["gender"],
        photo = jsonMap["photo"],
        birthday = jsonMap["birthday"],
        registerDate = jsonMap["registerDate"],
        status = jsonMap["status"],
        token = jsonMap["token"],
        verifyEmailSent = jsonMap["verifyEmailSent"],
        wasOnboarded = jsonMap["wasOnboarded"] ?? false,
        roles = (jsonMap["roles"] as List).map((r) => r as String).toList();

  User toUser() {
    return User(
        email: email,
        gender: Gender.fromString(gender),
        photo: photo,
        birthday: birthday,
        registerDate: registerDate,
        status: Status.fromString(status),
        wasOnboarded: wasOnboarded,
        roles: roles);
  }
}
