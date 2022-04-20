

import 'package:core/core.dart';

class LogInResponse {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String photo;
  final String birthday;
  final String registerDate;
  final String status;
  final String token;
  final String verifyEmailSent;
  final List<String> roles;
  final String country;
  final String city;
  final String height;
  final String weight;
  final bool wasOnboarded;

  LogInResponse(
      {this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.photo,
      this.birthday,
      this.registerDate,
      this.status,
      this.token,
      this.verifyEmailSent,
      this.roles,
      this.country,
      this.height,
      this.weight,
      this.wasOnboarded,
      this.city});

  LogInResponse.fromMap(jsonMap)
      : firstName = jsonMap["firstName"] ?? '',
        lastName = jsonMap["lastName"],
        email = jsonMap["email"],
        gender = jsonMap["gender"],
        photo = jsonMap["photo"],
        birthday = jsonMap["birthday"],
        registerDate = jsonMap["registerDate"],
        status = jsonMap["status"],
        token = jsonMap["token"],
        wasOnboarded = jsonMap["wasOnboarded"] ?? false,
        height = jsonMap["height"],
        weight = jsonMap["weight"],
        verifyEmailSent = jsonMap["verifyEmailSent"],
        country = jsonMap['location'] != null ? jsonMap['location']['country'] : null,
        city = jsonMap['location'] != null ? jsonMap['location']['city'] : null,
        roles = (jsonMap["roles"] as List).map((r) => r as String).toList();

  User toUser() {
    return User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: Gender.fromString(gender),
        photo: photo,
        birthday: birthday,
        registerDate: registerDate,
        status: Status.fromString(status),
        height: height,
        weight: weight,
        country: country,
        wasOnboarded: wasOnboarded,
        city: city,
        roles: roles);
  }
}
