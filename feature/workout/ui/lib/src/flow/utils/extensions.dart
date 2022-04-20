import 'package:workout_ui/src/flow/widget/indicator/flow_indicator.dart';
import 'package:workout_ui/src/flow/flow_item.dart';
import 'package:workout_ui/src/flow/utils/workout_model_selector.dart';
import 'package:workout_ui/src/flow/widget/indicator/exercise_progress_indicator.dart';
import 'package:workout_ui/src/flow/workout_flow_cubit.dart';
import 'package:workout_ui/src/model/exercise_data.dart';
import 'package:workout_ui/src/model/rest_data.dart';
import 'package:workout_use_case/use_case.dart';

extension WorkoutFlowCubitX on WorkoutFlowCubit {
  bool isAmrapRoundCompleted() {
    return (head is ExerciseItem &&
            (head as ExerciseItem).data.stageType == WorkoutStageType.AMRAP) &&
        head!.next is! ExerciseItem;
  }

  bool isAmrapStageCompleted() {
    int currentAmrapDuration = 0;
    FlowItem? curr = head;
    while (curr is ExerciseItem) {
      currentAmrapDuration += (curr).totalDuration;
      curr = curr.prev;
    }

    int maxAmrapDurationInMillis = (getMaxAmrapDurationInMinutes(
                workoutModel, (head as StageAwareItem).getStageName()) ??
            0) *
        60 *
        1000;
    return currentAmrapDuration >= maxAmrapDurationInMillis;
  }

  void restartAmrapRound() {
    while(head is! StageRoundCountEditItem){
      head = head?.next;
    }
    head!.data.roundCount = head!.data.roundCount + 1;
    while (head?.prev is ExerciseItem) {
      head = head?.prev;
    }
  }

  void setNextItem(FlowItem item) {
    head?.next = item;
    head?.next?.prev = head;
    head = head?.next;
  }

  /// We can to get kind of indicators on Exercise Flow Screen.
  IndicatorType? getExerciseFlowIndicatorType() {
    if (head is ExerciseItem &&
        (head?.data as ExerciseData).stageType == WorkoutStageType.FOR_TIME ||
    (head is RestItem && (head?.data as RestData).restType == RestType.inner)) {
      return IndicatorType.linear;
    } else if (head is ExerciseItem &&
        (head?.data as ExerciseData).stageType == WorkoutStageType.AMRAP) {
      return IndicatorType.circular;
    }
    return null;
  }

  /// Should return true or false about current Page in Stage.
  bool isExerciseOrRestInStage() =>
    head is StageAwareItem &&
      !isWorkoutStageIdle((head as StageAwareItem).getStageName());

  /// Should return true or false about current Page on Exercise Flow Screen.
  bool isExerciseOrRest() => head is StageAwareItem;

  /// Return count of exercises in current stage
  int getCurrentStageLength() {
    if (head != null && head is StageAwareItem) {
      int firstIndex = getPrevStageIndex(head!);
      int lastIndex = getNextStageIndex(head!);
      return (lastIndex - firstIndex) + 1;
    }
    return 0;
  }

  /// Find last index of current stage
  int getNextStageIndex(FlowItem item) {
    return item.next != null &&
            (item is StageAwareItem && item.next is StageAwareItem) &&
            (item as StageAwareItem).getStageName() ==
                (item.next as StageAwareItem).getStageName()
        ? getNextStageIndex(item.next!)
        : item.index;
  }

  /// Find first index of current stage
  int getPrevStageIndex(FlowItem item) {
    return item.prev != null &&
            (item is StageAwareItem && item.prev is StageAwareItem) &&
            (item as StageAwareItem).getStageName() ==
                (item.prev as StageAwareItem).getStageName()
        ? getPrevStageIndex(item.prev!)
        : item.index;
  }

  /// Find exercises from first done exercise to current
  int getCurrentStageIndex() =>
      head != null ? head!.index - getPrevStageIndex(head!) : 0;

  /// Get all rest indexes related current stage
  List<int> getStageRest() {
    Set<int> result = {};
    FlowItem? item = head;
    if (item != null) {
      int firstIndex = getPrevStageIndex(item);
      int lastIndex = getNextStageIndex(item);
      for (var i = item.index; i < lastIndex; i++) {
        if (item is RestItem && item.data.restType == RestType.inner) {
          result.add(item.index);
        }
        item = item!.next;
      }
      for (var i = item!.index; i > firstIndex; i--) {
        if (item is RestItem && item.data.restType == RestType.inner) {
          result.add(item.index);
        }
        item = item!.prev;
      }

      result = Set.of(result.map((e) => e - firstIndex));
    }
    return List<int>.of(result);
  }

  /// Return true or false value checking type of exercise AMRAP in stage
  bool isCurrentStageAMRAP() =>
      head != null &&
      (head is ExerciseItem &&
          head!.data is ExerciseData &&
          (head!.data as ExerciseData).stageType == WorkoutStageType.AMRAP);

  /// Return time of AMRAP WOD in milliseconds
  int? getWorkoutStageDuration() {
    return head != null &&
      head!.next is ExerciseItem &&
      (head is ExerciseItem && head!.data is ExerciseData) ?
      (head!.data as ExerciseData).workoutStageDuration * 60 * 1000 : null;
  }

  /// Return right action when type exercise is AMRAP
  bool isNextButtonActionAMRAP() =>
      head is ExerciseItem && (head!.data as ExerciseData).stageType == WorkoutStageType.AMRAP;

  /// Check is current Rest
  bool isNextRest() => head != null && head!.next is RestItem;

  /// Check is next StageTimeEditItem
  bool isNextStageTimeEditItem() =>
      head != null && head!.next is StageTimeEditItem;

  /// Check is next StageRoundCountEditItem
  bool isNextStageRoundCountEditItem() =>
      head != null &&
        (head!.next is StageRoundCountEditItem);

  /// Check is next CongratulationItem
  bool isNextCongratulationItem() =>
      head != null &&
        (head!.next is CongratulationItem);

  /// Check is current StageRoundCountEditItem
  bool isNextExercise() =>
      head != null && head!.next?.data != null && head!.next is ExerciseItem;

  /// Return next button type
  ButtonType getNextButtonType() => head != null && head is ExerciseItem
      ? ButtonType.exercise
      : head != null && head is RestItem
          ? ButtonType.rest
          : ButtonType.none;

  /// Get current exercise ID
  int getCurrentExerciseId() =>
      head != null && head?.index != null ? head!.index : 0;

  /// Get current exercise Name
  String getCurrentExerciseName() => head != null && head is ExerciseItem
      ? (head!.data as ExerciseData).exercise.name
      : '';

  /// Get current exercise Video
  String getCurrentExerciseVideo() => head != null && head is ExerciseItem
      ? (head!.data as ExerciseData).exercise.video480
      : '';

  /// Get current exercise Quantity
  int getCurrentExerciseQuantity() =>
      head != null && head is ExerciseItem && head?.data != null
          ? (head!.data as ExerciseData).exercise.quantity!
          : 0;

  /// Get current exercise Metrics
  String getCurrentExerciseMetrics() =>
      head != null && head is ExerciseItem && head?.data != null
          ? (head!.data as ExerciseData).exercise.metrics
          : '';
}
