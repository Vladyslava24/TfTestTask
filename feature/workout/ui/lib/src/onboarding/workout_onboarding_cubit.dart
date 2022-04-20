import 'package:core/core.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_ui/src/navigation/workout_route.dart';
import 'package:workout_ui/src/onboarding/workout_onboarding_state.dart';
import 'package:workout_use_case/use_case.dart';

class WorkoutOnBoardingCubit extends BaseCubit<WorkoutOnBoardingState> {
  WorkoutOnBoardingUseCase workoutOnBoardingUseCase;
  WorkoutLocalizations localization;
  AppNavigator navigator;

  WorkoutOnBoardingCubit(
      {required this.workoutOnBoardingUseCase,
      required this.localization,
      required this.navigator})
      : super(WorkoutOnBoardingState.initial());

  void onActiveIndexChanged(int value) {
    emit(state.copyWith(activeIndex: value));
  }

  void startWorkout(
      WorkoutModel workout, String workoutId, int? userWeight) async {
    await workoutOnBoardingUseCase.setOnBoardingStatus(true);

    navigator.pushNamedAndRemoveUntil(
        WorkoutRoute.exerciseFlow, WorkoutRoute.workoutPreview,
        arguments: [workout, workoutId, userWeight]);
  }
}
