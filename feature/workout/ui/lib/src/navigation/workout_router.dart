import 'package:flutter/material.dart';
import 'package:workout_ui/src/flow/workout_flow_screen.dart';
import 'package:workout_ui/src/model/tutorial_model.dart';
import 'package:workout_ui/src/onboarding/workout_onboarding_screen.dart';
import 'package:workout_ui/src/preview/workout_preview_screen.dart';
import 'package:workout_ui/src/tutorial/workout_tutorial_screen.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:workout_ui/src/navigation/workout_route.dart';

class WorkoutRouter {
  static Map<String, PageRoute Function(RouteSettings)> getRoutes() =>
      _routeMap;

  static final _routeMap = {
    WorkoutRoute.workoutPreview: (settings) {
      WorkoutModel workout = settings.arguments[0];
      String workoutId = settings.arguments[1].toString();
      bool isUserPremium = settings.arguments[2];
      int? userWeight = settings.arguments[3];
      return MaterialPageRoute(
          builder: (BuildContext c) => WorkoutPreviewScreenV2(
                workout: workout,
                workoutId: workoutId,
                isUserPremium: isUserPremium,
                userWeight: userWeight,
              ),
          settings: settings);
    },
    WorkoutRoute.exerciseFlow: (settings) {
      WorkoutModel workout = settings.arguments[0];
      String workoutId = settings.arguments[1];
      int? userWeight = settings.arguments[2];
      return MaterialPageRoute(
          builder: (BuildContext c) => WorkoutFlowScreen(
              workout: workout, workoutId: workoutId, userWeight: userWeight),
          settings: settings);
    },
    WorkoutRoute.exerciseTutorial: (settings) {
      TutorialModel tutorial = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              WorkoutTutorialScreen(tutorial: tutorial),
          settings: settings);
    },
    WorkoutRoute.workoutOnBoarding: (settings) {
      WorkoutModel workout = settings.arguments[0];
      String workoutId = settings.arguments[1];
      int? userWeight = settings.arguments[2];
      return MaterialPageRoute(
          builder: (BuildContext c) => WorkoutOnBoardingScreen(
              workout: workout, workoutId: workoutId, userWeight: userWeight),
          settings: settings);
    }
  };
}
