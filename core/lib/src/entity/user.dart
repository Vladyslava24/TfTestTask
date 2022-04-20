import 'dart:convert';

import 'package:core/core.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String? photo;
  final String birthday;
  final String registerDate;
  final Status status;
  final List<String> roles;

  final String height;
  final String weight;
  final String country;
  final String city;
  final Gender? gender;
  final bool wasOnboarded;

  User(
      {
      //empty by default DB SCHEME requires NOT NULL, and the name is set after an account is created
      this.firstName = '',
      required this.lastName,
      required this.email,
      this.photo,
      required this.birthday,
      required this.registerDate,
      required this.status,
      required this.roles,
      required this.height,
      required this.weight,
      required this.country,
      required this.city,
      this.wasOnboarded = false,
      this.gender});

  static const String table_name = "user";

  static const String field_first_name = "firstName";
  static const String field_last_name = "lastName";
  static const String field_email = "email";
  static const String field_photo = "photo";
  static const String field_birthday = "birthday";
  static const String field_register_date = "registerDate";
  static const String field_status = "status";
  static const String field_token = "token";
  static const String field_verify_email_sent = "verifyEmailSent";
  static const String field_roles = "roles";

  static const String field_height = "height";
  static const String field_weight = "weight";
  static const String field_country = "country";
  static const String field_city = "city";
  static const String field_gender = "gender";

  User.fromJson(json)
      : firstName = json[field_first_name],
        lastName = json[field_last_name],
        email = json[field_email],
        photo = json[field_photo],
        birthday = json[field_birthday],
        registerDate = json[field_register_date],
        status = Status.fromString(json[field_status]),
        roles = [],
        height = json[field_height],
        weight = json[field_weight],
        country = json[field_country],
        wasOnboarded = json["wasOnboarded"],
        city = json[field_city],
        gender = (json[field_gender] == null || json[field_gender] == "")
            ? null
            : Gender.fromString(json[field_gender]);

  User.mock()
      : firstName = "mock",
        lastName = "mock",
        email = "mock",
        photo = null,
        birthday = "mock",
        registerDate = "mock",
        status = Status.ACTIVE,
        height = "mock",
        city = "mock",
        weight = "mock",
        country = "mock",
        gender = null,
        wasOnboarded = false,
        roles = ["ATHLETE"];

  Map<String, dynamic> toJson() => {
        field_first_name: firstName,
        field_last_name: lastName,
        field_email: email,
        field_photo: photo,
        field_birthday: birthday,
        field_register_date: registerDate,
        field_status: status.toString(),
        field_roles: jsonEncode(roles),
        field_height: height,
        field_weight: weight,
        field_country: country,
        field_city: city,
        field_gender: gender == null ? null : gender.toString(),
      };

  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      photo.hashCode ^
      status.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      country.hashCode ^
      city.hashCode ^
      gender.hashCode;

  @override
  bool operator ==(other) {
    return other is User &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        photo == other.photo &&
        status == other.status &&
        height == other.height &&
        weight == other.weight &&
        country == other.country &&
        city == other.city &&
        gender == other.gender;
  }

  User copyWith(
      {String? firstName,
      String? lastName,
      String? email,
      String? photo,
      String? birthday,
      String? registerDate,
      Status? status,
      String? height,
      String? weight,
      String? country,
      String? city,
      bool? wasOnboarded,
      Gender? gender,
      List<String>? roles}) {
    return User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        photo: photo ?? this.photo,
        birthday: birthday ?? this.birthday,
        registerDate: registerDate ?? this.registerDate,
        status: status ?? this.status,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        country: country ?? this.country,
        city: city ?? this.city,
        gender: gender ?? this.gender,
        wasOnboarded: wasOnboarded ?? this.wasOnboarded,
        roles: roles ?? this.roles);
  }
}

class Status {
  static const INACTIVE = Status("INACTIVE");
  static const ACTIVE = Status("ACTIVE");
  static const BLOCKED = Status("BLOCKED");

  final String _name;

  const Status(this._name);

  @override
  String toString() {
    return _name;
  }

  static List<Status> _swatch = <Status>[INACTIVE, ACTIVE, BLOCKED];

  static Status fromString(String requestedStatus) {
    for (final status in _swatch) {
      if (status._name == requestedStatus) {
        return status;
      }
    }
    throw Exception("No Status for $requestedStatus");
  }

  int get hashCode => _name.hashCode;

  @override
  bool operator ==(other) {
    if (other is! User) {
      return false;
    }
    final Status otherStatus = other.status;
    return _name == otherStatus._name;
  }
}

class Gender {
  static const MALE = Gender("MALE");
  static const FEMALE = Gender("FEMALE");

  final String name;

  const Gender(this.name);

  @override
  String toString() {
    return name;
  }

  static List<Gender> swatch = <Gender>[MALE, FEMALE];

  static Gender? fromString(String name) {
    for (final gender in swatch) {
      if (equalsIgnoreCase(gender.name, name)) {
        return gender;
      }
    }
    return null;
  }

  int get hashCode => name.hashCode;

  @override
  bool operator ==(other) {
    if (other is! Gender) {
      return false;
    }
    final Gender otherGender = other;
    return name == otherGender.name;
  }
}
