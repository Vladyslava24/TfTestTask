
import 'package:core/core.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';

class SignInWithSocialResponse {
  final String firstName;
  final String lastName;
  final String email;
  final Location location;
  final String photo;
  final String birthday;
  final String registerDate;
  final String status;
  final String token;
  final String verifyEmailSent;
  final String gender;
  final List<String> roles;
  final String height;
  final String weight;
  final bool wasOnboarded;

  SignInWithSocialResponse({
    this.firstName,
    this.lastName,
    this.email,
    this.location,
    this.photo,
    this.birthday,
    this.registerDate,
    this.status,
    this.token,
    this.verifyEmailSent,
    this.roles,
    this.gender,
    this.height,
    this.weight,
    this.wasOnboarded,
  });

  SignInWithSocialResponse.fromMap(jsonMap)
      : firstName = jsonMap["firstName"],
        lastName = jsonMap["lastName"],
        email = jsonMap["email"],
        location = jsonMap["location"] == null ? null : Location.fromJson(jsonMap["location"]),
        photo = jsonMap["photo"],
        birthday = jsonMap["birthday"],
        registerDate = jsonMap["registerDate"],
        status = jsonMap["status"],
        token = jsonMap["token"],
        verifyEmailSent = jsonMap["verifyEmailSent"],
        gender = jsonMap["gender"],
        weight = jsonMap["weight"],
        height = jsonMap["height"],
        wasOnboarded = jsonMap["wasOnboarded"] ?? false,
        roles = (jsonMap["roles"] as List).map((r) => r as String).toList();

  User toUser() {
    return User(
        gender: Gender.fromString(gender),
        country: location == null ? null : location.country,
        city: location == null ? null : location.city,
        firstName: firstName,
        lastName: lastName,
        email: email,
        photo: photo,
        birthday: birthday,
        registerDate: registerDate,
        status: Status.fromString(status),
        wasOnboarded: wasOnboarded,
        weight: weight,
        height: height,
        roles: roles);
  }
}
