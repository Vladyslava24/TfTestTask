import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class WorkoutOnBoardingState extends Equatable {

  final int activeIndex;

  const WorkoutOnBoardingState({
    required this.activeIndex
  });

  factory WorkoutOnBoardingState.initial() =>
    const WorkoutOnBoardingState(activeIndex: 0);

  WorkoutOnBoardingState copyWith({
    int? activeIndex
  }) {
    return WorkoutOnBoardingState(
      activeIndex: activeIndex ?? this.activeIndex
    );
  }

  @override
  List<Object?> get props => [activeIndex];
}