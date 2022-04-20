import 'package:totalfit/model/workout_preview_list_items.dart';
import 'package:totalfit/ui/utils/utils.dart';

class ShareResultsState {
  final List<dynamic> listItems;
  final ExerciseCategoryItem wodItem;
  final int workoutDuration;
  final String wodType;
  final String workoutName;
  final int totalExercises;
  final int wodResult;
  final int roundCount;
  final String errorMessage;

  ShareResultsState({
    this.listItems,
    this.wodItem,
    this.workoutDuration,
    this.wodType,
    this.workoutName,
    this.totalExercises,
    this.wodResult,
    this.roundCount,
    this.errorMessage,
  });

  ShareResultsState copyWith({
    List<dynamic> listItems,
    ExerciseCategoryItem wodItem,
    int workoutDuration,
    String wodType,
    String workoutName,
    int totalExercises,
    int wodResult,
    int roundCount,
    String errorMessage,
  }) {
    return ShareResultsState(
        listItems: listItems ?? this.listItems,
        wodItem: wodItem ?? this.wodItem,
        workoutDuration: workoutDuration ?? this.workoutDuration,
        wodType: wodType ?? this.wodType,
        workoutName: workoutName ?? this.workoutName,
        totalExercises: totalExercises ?? this.totalExercises,
        wodResult: wodResult ?? this.wodResult,
        roundCount: roundCount ?? this.roundCount,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShareResultsState &&
          runtimeType == other.runtimeType &&
          errorMessage == other.errorMessage &&
          deepEquals(listItems, other.listItems);

  @override
  int get hashCode => errorMessage.hashCode ^ deepHash(listItems);
}
