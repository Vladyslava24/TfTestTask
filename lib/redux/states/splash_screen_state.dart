import 'package:flutter/material.dart';

@immutable
class SplashScreenState {
  final bool showWelcomeOnboarding;
  final bool isLoading;

  SplashScreenState({
    @required this.showWelcomeOnboarding,
    @required this.isLoading,
  });

  factory SplashScreenState.initial() {
    return SplashScreenState(
      showWelcomeOnboarding: false,
      isLoading: false,
    );
  }

  SplashScreenState copyWith({
    bool showWelcomeOnboarding,
    bool isLoading,
  }) {
    return SplashScreenState(
      showWelcomeOnboarding: showWelcomeOnboarding,
      isLoading: isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashScreenState &&
          runtimeType == other.runtimeType &&
          showWelcomeOnboarding == other.showWelcomeOnboarding &&
          isLoading == other.isLoading;

  @override
  int get hashCode => showWelcomeOnboarding.hashCode ^ isLoading.hashCode;
}
