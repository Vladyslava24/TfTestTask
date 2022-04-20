import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:totalfit/ui/utils/utils.dart';

@immutable
class AuthState {
  final User user;
  final String country;
  final String countryError;
  final List<String> countryList;
  final List<String> filteredCountryList;
  final String fetchCountiesError;
  final bool isCountryListLoading;

  AuthState({
    @required this.user,
    @required this.country,
    @required this.countryError,
    @required this.countryList,
    @required this.filteredCountryList,
    @required this.fetchCountiesError,
    @required this.isCountryListLoading,
  });

  factory AuthState.initial() {
    return AuthState(
      user: null,
      country: null,
      countryError: '',
      countryList: [],
      filteredCountryList: [],
      fetchCountiesError: '',
      isCountryListLoading: false,
    );
  }

  AuthState copyWith({
    User user,
    String country,
    String countryError,
    List<String> countryList,
    List<String> filteredCountryList,
    String fetchCountiesError,
    bool isCountryListLoading
  }) {
    return AuthState(
      user: user,
      country: country ?? this.country,
      countryError: countryError ?? this.countryError,
      countryList: countryList ?? this.countryList,
      filteredCountryList: filteredCountryList ?? this.filteredCountryList,
      fetchCountiesError: fetchCountiesError ?? this.fetchCountiesError,
      isCountryListLoading: isCountryListLoading ?? this.isCountryListLoading,
    );
  }

  bool isLoggedIn() {
    return user != null;
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is AuthState &&
      runtimeType == other.runtimeType &&
      user == other.user &&
      country == other.country &&
      countryError == other.countryError &&
      deepEquals(countryList, other.countryList) &&
      deepEquals(filteredCountryList, other.filteredCountryList) &&
      fetchCountiesError == other.fetchCountiesError &&
      isCountryListLoading == other.isCountryListLoading;

  @override
  int get hashCode =>
    country.hashCode ^
    countryError.hashCode ^
    deepHash(countryList) ^
    deepHash(filteredCountryList) ^
    fetchCountiesError.hashCode ^
    isCountryListLoading.hashCode ^
    user.hashCode;
}
