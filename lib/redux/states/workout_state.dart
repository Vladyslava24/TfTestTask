import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/model/tutorial_page.dart';
import 'package:totalfit/model/workout_page_type.dart';
import 'package:totalfit/redux/states/share_results_state.dart';
import 'package:totalfit/redux/states/workout_summary_state.dart';

class WorkoutState {
  WorkoutDto workout;
  WorkoutSummaryState workoutSummaryState;
  ShareResultsState shareResultsState;
  WorkoutPageType currentPageType;
  Exercise pausedExercise;
  TutorialPage tutorialPage;
  int downloadedExercisePercent;
  String workoutProgressId;

  WorkoutState({
    this.workout,
    this.currentPageType,
    this.workoutSummaryState,
    this.shareResultsState,
    this.pausedExercise,
    this.tutorialPage,
    this.downloadedExercisePercent,
    this.workoutProgressId,
  });

  WorkoutState copyWith({
    WorkoutDto workout,
    String wodType,
    Exercise skill,
    WorkoutSummaryState workoutSummaryState,
    WorkoutPageType currentPageType,
    ShareResultsState shareResultsState,
    int durationFromServer,
    Exercise pausedExercise,
    TutorialPage tutorialPage,
    int warmUpRounds,
    int downloadedExercisePercent,
    String workoutProgressId,
  }) {
    return WorkoutState(
      workout: workout ?? this.workout,
      currentPageType: currentPageType ?? this.currentPageType,
      workoutSummaryState: workoutSummaryState ?? this.workoutSummaryState,
      shareResultsState: shareResultsState ?? this.shareResultsState,
      pausedExercise: pausedExercise ?? this.pausedExercise,
      tutorialPage: tutorialPage ?? this.tutorialPage,
      downloadedExercisePercent: downloadedExercisePercent ?? this.downloadedExercisePercent,
      workoutProgressId: workoutProgressId ?? this.workoutProgressId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutState &&
          runtimeType == other.runtimeType &&
          currentPageType == other.currentPageType &&
          pausedExercise == other.pausedExercise &&
          workoutSummaryState == other.workoutSummaryState &&
          shareResultsState == other.shareResultsState &&
          downloadedExercisePercent == other.downloadedExercisePercent &&
          workoutProgressId == other.workoutProgressId &&
          tutorialPage == other.tutorialPage;

  @override
  int get hashCode =>
      currentPageType.hashCode ^
      pausedExercise.hashCode ^
      workoutSummaryState.hashCode ^
      shareResultsState.hashCode ^
      downloadedExercisePercent.hashCode ^
      workoutProgressId.hashCode ^
      tutorialPage.hashCode;
}
