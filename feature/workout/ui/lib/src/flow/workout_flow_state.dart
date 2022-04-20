import 'package:workout_use_case/use_case.dart';

import 'flow_item.dart';

class WorkoutFlowState {
  String workoutId;
  bool isPaused;
  bool showPauseScreen;
  FlowItem? currentItem;
  WorkoutModel? workout;
  String error;
  bool delayDone;
  bool isLoading;
  bool isMoveForward;
  bool isPlayVoiceStartSound;
  bool isTutorialActivated;

  WorkoutFlowState({
    required this.workoutId,
    required this.isPaused,
    required this.showPauseScreen,
    required this.currentItem,
    required this.workout,
    required this.error,
    required this.delayDone,
    required this.isLoading,
    required this.isMoveForward,
    required this.isPlayVoiceStartSound,
    required this.isTutorialActivated
  });

  factory WorkoutFlowState.initial() {
    return WorkoutFlowState(
      workoutId: '',
      isPaused: false,
      showPauseScreen: false,
      currentItem: null,
      workout: null,
      error: '',
      delayDone: false,
      isLoading: false,
      isMoveForward: true,
      isPlayVoiceStartSound: false,
      isTutorialActivated: false
    );
  }

  WorkoutFlowState copyWith({
    bool? isPaused,
    bool? showPauseScreen,
    FlowItem? currentItem,
    WorkoutModel? workout,
    String? error,
    String? workoutId,
    bool? delayDone,
    bool? isLoading,
    bool? isMoveForward,
    bool? isPlayVoiceStartSound,
    bool? isTutorialActivated
  }) {
    return WorkoutFlowState(
      workoutId: workoutId ?? this.workoutId,
      isPaused: isPaused ?? this.isPaused,
      showPauseScreen: showPauseScreen ?? this.showPauseScreen,
      currentItem: currentItem ?? this.currentItem,
      workout: workout ?? this.workout,
      error: error ?? this.error,
      delayDone: delayDone ?? this.delayDone,
      isLoading: isLoading ?? this.isLoading,
      isMoveForward: isMoveForward ?? this.isMoveForward,
      isPlayVoiceStartSound: isPlayVoiceStartSound ?? this.isPlayVoiceStartSound,
      isTutorialActivated: isTutorialActivated ?? this.isTutorialActivated
    );
  }
}
