import 'package:totalfit/ui/utils/utils.dart';

class WorkoutSummaryState {
  final List<dynamic> listItems;
  bool isWorkoutCompleted = false;
  final String errorMessage;

  WorkoutSummaryState({this.listItems, this.isWorkoutCompleted, this.errorMessage});

  WorkoutSummaryState copyWith({List<dynamic> listItems, bool isWorkoutCompleted, String errorMessage}) {
    return WorkoutSummaryState(
        listItems: listItems ?? this.listItems,
        errorMessage: errorMessage ?? this.errorMessage,
        isWorkoutCompleted: isWorkoutCompleted ?? this.isWorkoutCompleted);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSummaryState &&
          runtimeType == other.runtimeType &&
          isWorkoutCompleted == other.isWorkoutCompleted &&
          errorMessage == other.errorMessage &&
          deepEquals(listItems, other.listItems);

  @override
  int get hashCode => isWorkoutCompleted.hashCode ^ errorMessage.hashCode ^ deepHash(listItems);
}
