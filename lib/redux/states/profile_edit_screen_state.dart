import 'package:flutter/material.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';

@immutable
class ProfileEditScreenState {
  final bool isLoading;
  final TfException error;

  ProfileEditScreenState({
    @required this.isLoading,
    @required this.error,
  });

  factory ProfileEditScreenState.initial() {
    return ProfileEditScreenState(
      isLoading: false,
      error: IdleException(),
    );
  }

  ProfileEditScreenState copyWith({bool isLoading, TfException error}) {
    return ProfileEditScreenState(
      isLoading: isLoading,
      error: error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileEditScreenState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          error == other.error;

  @override
  int get hashCode => isLoading.hashCode ^ error.hashCode;
}
