import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/ui/utils/utils.dart';

class ProfileWorkoutSummaryState {
  final List<dynamic> listItems;
  final bool isWorkoutCompleted;
  final TfException error;
  final WorkoutDto workout;
  final WorkoutProgressDto progress;

  ProfileWorkoutSummaryState({
    this.listItems,
    this.isWorkoutCompleted,
    this.error,
    this.workout,
    this.progress,
  });

  factory ProfileWorkoutSummaryState.initial() {
    return ProfileWorkoutSummaryState(
      workout: null,
      progress: null,
      listItems: [],
      isWorkoutCompleted: false,
      error: IdleException(),
    );
  }

  ProfileWorkoutSummaryState copyWith({
    WorkoutDto workout,
    WorkoutProgressDto progress,
    List<dynamic> listItems,
    bool isWorkoutCompleted,
    TfException error,
  }) {
    return ProfileWorkoutSummaryState(
        workout: workout ?? this.workout,
        progress: progress ?? this.progress,
        listItems: listItems ?? this.listItems,
        error: error ?? this.error,
        isWorkoutCompleted: isWorkoutCompleted ?? this.isWorkoutCompleted);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileWorkoutSummaryState &&
          runtimeType == other.runtimeType &&
          isWorkoutCompleted == other.isWorkoutCompleted &&
          error == other.error &&
          workout == other.workout &&
          progress == other.progress &&
          deepEquals(listItems, other.listItems);

  @override
  int get hashCode => isWorkoutCompleted.hashCode ^ error.hashCode ^ deepHash(listItems);
}
