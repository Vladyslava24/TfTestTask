import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class PushNotificationsState extends Equatable {
  final bool wod;
  final bool dailyReading;
  final bool updatesAndNews;
  final bool isLoading;
  final String errorMessage;

  PushNotificationsState({
    this.wod,
    this.dailyReading,
    this.updatesAndNews,
    this.isLoading,
    this.errorMessage
  });

  factory PushNotificationsState.initial() =>
    PushNotificationsState(
      wod: true,
      dailyReading: true,
      updatesAndNews: true,
      isLoading: false,
      errorMessage: ''
    );

  PushNotificationsState copyWith({
    bool wod,
    bool dailyReading,
    bool updatesAndNews,
    bool isLoading,
    String errorMessage
  }) {
    return PushNotificationsState(
      wod: wod ?? this.wod,
      dailyReading: dailyReading ?? this.dailyReading,
      updatesAndNews: updatesAndNews ?? this.updatesAndNews,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object> get props => [wod, dailyReading, updatesAndNews, isLoading,
    errorMessage];
}