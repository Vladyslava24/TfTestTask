import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:workout_ui/src/onboarding/widget/onboarding_step_one_widget.dart';
import 'package:workout_ui/src/onboarding/widget/onboarding_step_three_widget.dart';
import 'package:workout_ui/src/onboarding/widget/onboarding_step_two_widget.dart';
import 'package:workout_ui/src/onboarding/widget/workout_onboarding_widget.dart';
import 'package:workout_ui/src/onboarding/workout_onboarding_cubit.dart';
import 'package:workout_ui/src/onboarding/workout_onboarding_state.dart';
import 'package:workout_use_case/use_case.dart';

const String _time = '25:04';

class WorkoutOnBoardingScreen
    extends BasePage<WorkoutOnBoardingState, WorkoutOnBoardingCubit> {
  final WorkoutModel workout;
  final String workoutId;
  final int? userWeight;

  const WorkoutOnBoardingScreen(
      {required this.workout,
      required this.workoutId,
      required this.userWeight,
      Key? key})
      : super(key: key);

  @override
  createBloc() => DependencyProvider.get<WorkoutOnBoardingCubit>();

  @override
  Widget buildPage(BuildContext context, bloc, state) {
    return WorkoutOnBoardingWidget(
      activeIndex: bloc.state.activeIndex,
      skipButtonText: bloc.localization.onboarding_skip,
      onActiveIndexChanged: (value) => bloc.onActiveIndexChanged(value),
      startWorkout: () => bloc.startWorkout(workout, workoutId, userWeight),
      onBoardingItems: [
        OnBoardingStepOneWidget(
          advice: bloc.localization.onboarding_step_one_advice,
          time: _time,
          textButton: bloc.localization.onboarding_button_text,
        ),
        OnBoardingStepTwoWidget(
          advice: bloc.localization.onboarding_step_two_advice,
          time: _time,
          textButton: bloc.localization.onboarding_button_text,
        ),
        OnBoardingStepThreeWidget(
          advice1: bloc.localization.onboarding_step_three_advice1,
          advice2: bloc.localization.onboarding_step_three_advice2,
          time: _time,
          textButton: bloc.localization.onboarding_button_text,
        ),
      ],
    );
  }
}
