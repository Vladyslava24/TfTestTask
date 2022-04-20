import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/workout_preview_list_items.dart';
import 'package:totalfit/redux/middleware/profile_share_workout_results_middleware.dart';
import 'package:totalfit/ui/utils/utils.dart';

import '../../ui/widgets/grid_items.dart';

class ProfileShareWorkoutResultsScreenState {
  final List<dynamic> listItems;
  final ExerciseCategoryItem wodItem;
  final int workoutDuration;
  final String wodType;
  final String workoutName;
  final int totalExercises;
  final int wodResult;
  final int roundCount;
  final TfException error;
  final int workoutId;
  final bool isBuildingState;
  final ImageItem selectedImageItem;

  ProfileShareWorkoutResultsScreenState({
    this.listItems,
    this.wodItem,
    this.workoutDuration,
    this.wodType,
    this.workoutName,
    this.totalExercises,
    this.wodResult,
    this.roundCount,
    this.error,
    this.workoutId,
    this.isBuildingState,
    this.selectedImageItem,
  });

  factory ProfileShareWorkoutResultsScreenState.initial() {
    return ProfileShareWorkoutResultsScreenState(
      listItems: [],
      wodItem: null,
      workoutDuration: 0,
      wodType: "",
      workoutName: "",
      totalExercises: 0,
      wodResult: 0,
      roundCount: 0,
      workoutId: 0,
      error: IdleException(),
      isBuildingState: true,
      selectedImageItem: ImageItem(url: DEFAULT_SHARE_IMAGE),
    );
  }

  ProfileShareWorkoutResultsScreenState copyWith({
    List<dynamic> listItems,
    ExerciseCategoryItem wodItem,
    int workoutDuration,
    String wodType,
    String workoutName,
    int totalExercises,
    int wodResult,
    int roundCount,
    TfException error,
    int workoutId,
    bool isBuildingState,
    ImageItem selectedImageItem,
  }) {
    return ProfileShareWorkoutResultsScreenState(
      listItems: listItems ?? this.listItems,
      wodItem: wodItem ?? this.wodItem,
      workoutDuration: workoutDuration ?? this.workoutDuration,
      wodType: wodType ?? this.wodType,
      workoutName: workoutName ?? this.workoutName,
      totalExercises: totalExercises ?? this.totalExercises,
      wodResult: wodResult ?? this.wodResult,
      roundCount: roundCount ?? this.roundCount,
      workoutId: workoutId ?? this.workoutId,
      error: error ?? this.error,
      isBuildingState: isBuildingState ?? this.isBuildingState,
      selectedImageItem: selectedImageItem ?? this.selectedImageItem,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileShareWorkoutResultsScreenState &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          workoutId == other.workoutId &&
          isBuildingState == other.isBuildingState &&
          selectedImageItem == other.selectedImageItem &&
          deepEquals(listItems, other.listItems);

  @override
  int get hashCode =>
      error.hashCode ^ deepHash(listItems) ^ workoutId.hashCode ^ selectedImageItem.hashCode ^ isBuildingState.hashCode;
}
