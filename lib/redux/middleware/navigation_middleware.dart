import 'package:core/core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/reset_password_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/selectors/progress_selectors.dart';
import 'package:totalfit/storage/string_storage.dart';
import 'package:totalfit/ui/route/app_route.dart';
import 'package:totalfit/redux/actions/profile_share_workout_results_actions.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:totalfit/redux/actions/actions.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/ui/widgets/keys.dart';
import 'package:workout_ui/workout_ui.dart';
import 'package:workout_use_case/use_case.dart';

import '../states/app_state.dart';

List<Middleware<AppState>> navigationMiddleware(
  WorkoutListUseCase workoutListUseCase, StringStorage stringStorage, TFLogger logger, ) {
  final loginNavigationMiddleware = _navigateToLoginAction(logger);
  final mainScreenNavigationMiddleware = _navigateToMainScreenAction(logger);
  final navigateOnDropWorkoutState = _navigateOnDropWorkoutState(logger);
  final signUpNavigationMiddleware = _navigateToSignUpAction(logger);
  final navigateToEntryScreenAction = _navigateToEntryScreenAction(logger);
  final resetPasswordUpNavigationMiddleware =
      _navigateToResetPasswordAction(logger);
  final navigateBackToSplashScreenAction =
      _navigateBackToSplashScreenAction(logger);
  final navigateToSortedWorkoutsPage = _navigateToSortedWorkoutsPage(logger);
  final navigateToFilterWorkoutsPage = _navigateToFilterWorkoutsPage(logger);

  final navigateToTutorialScreenAction =
      _navigateToTutorialScreenAction(logger);

  final navigateToWorkoutSelectionAction =
      _navigateToWorkoutSelectionAction(logger);

  final navigateToProgressAction = _navigateToProgressAction(logger);
  final navigateToSingleButtonPageAction =
      _navigateToSingleButtonPageAction(logger);
  final navigateToHabitPageAction = _onNavigateToHabitPageAction(logger);
  final navigateToBreathingPageAction = _navigateToBreathingPageAction(logger);
  final onCompleteReadStoryAction = _onCompleteReadStoryAction(logger);

  final navigateToSortedExercisesPageAction =
      _navigateToSortedExercisesPageAction(logger);
  final navigateToSortedExercisesPageOnSeeAllPressedAction =
      _navigateToSortedExercisesPageOnSeeAllPressedAction(logger);
  final navigateToExerciseVideoPage = _navigateToExerciseVideoPage(logger);
  final navigateToEditProfile = _navigateToEditProfile(logger);
  final navigateToSettings = _navigateToSettings(logger);
  final navigateToStorageSetting = _navigateToStorageSetting(logger);
  final navigateToNotificationsSettingsAction =
      _navigateToNotificationsSettingsAction(logger);
  final navigateOnShowSelectedWorkoutPageAction =
      _navigateOnShowSelectedWorkoutPageAction(workoutListUseCase, logger);
  final showMainScreenAction = _showMainScreenAction(logger);
  final onNavigateToProgramEditPageAction =
      _onNavigateToProgramResetPageAction(logger);
  final navigateToStoryPageAction = _navigateToStoryPageAction(logger);
  final navigateToWisdomPageAction = _navigateToWisdomPageAction(logger);
  final navigateToExploreWorkoutsListScreenAction =
      _navigateToExploreWorkoutsListScreenAction(logger);
  final navigateToOnboardingScreenAction =
      _navigateToOnboardingScreenAction(logger);

  return [
    TypedMiddleware<AppState, NavigateToEditProgramPageAction>(
        onNavigateToProgramEditPageAction),
    TypedMiddleware<AppState, NavigateToLoginAction>(loginNavigationMiddleware),
    TypedMiddleware<AppState, NavigateToMainScreenAction>(
        mainScreenNavigationMiddleware),
    TypedMiddleware<AppState, ShowMainScreenAction>(showMainScreenAction),
    TypedMiddleware<AppState, NavigateToSignUpAction>(
        signUpNavigationMiddleware),
    TypedMiddleware<AppState, NavigateToEntryScreenAction>(
        navigateToEntryScreenAction),
    TypedMiddleware<AppState, NavigateToStoryPageAction>(
        navigateToStoryPageAction),
    TypedMiddleware<AppState, NavigateToWisdomPageAction>(
        navigateToWisdomPageAction),
    TypedMiddleware<AppState, NavigateToBreathingPageAction>(
        navigateToBreathingPageAction),
    TypedMiddleware<AppState, NavigateToResetPasswordAction>(
        resetPasswordUpNavigationMiddleware),
    TypedMiddleware<AppState, NavigateToStorageSetting>(
        navigateToStorageSetting),
    TypedMiddleware<AppState, NavigateBackToSplashScreenAction>(
        navigateBackToSplashScreenAction),
    TypedMiddleware<AppState, OnNewPasswordSuccessAction>(
        loginNavigationMiddleware),
    TypedMiddleware<AppState, NavigateToWorkoutPreviewPageAction>(
        navigateOnShowSelectedWorkoutPageAction),
    TypedMiddleware<AppState, ShowSortedWorkoutsAction>(
        navigateToSortedWorkoutsPage),
    TypedMiddleware<AppState, QuitWorkoutAction>(navigateOnDropWorkoutState),
    TypedMiddleware<AppState, OnShowTutorialAction>(
        navigateToTutorialScreenAction),
    TypedMiddleware<AppState, NavigateToWorkoutSelectionAction>(
        navigateToWorkoutSelectionAction),
    TypedMiddleware<AppState, NavigateToProgressAction>(
        navigateToProgressAction),
    TypedMiddleware<AppState, NavigateToSingleButtonPageAction>(
        navigateToSingleButtonPageAction),
    TypedMiddleware<AppState, NavigateToHabitPageAction>(
        navigateToHabitPageAction),
    TypedMiddleware<AppState, OnCompleteReadStoryAction>(
        onCompleteReadStoryAction),
    TypedMiddleware<AppState, NavigateToSortedExercisesPageAction>(
        navigateToSortedExercisesPageAction),
    TypedMiddleware<AppState,
            NavigateToSortedExercisesPageOnSeeAllPressedAction>(
        navigateToSortedExercisesPageOnSeeAllPressedAction),
    TypedMiddleware<AppState, NavigateToExerciseVideoPage>(
        navigateToExerciseVideoPage),
    TypedMiddleware<AppState, NavigateToProfileEdit>(navigateToEditProfile),
    TypedMiddleware<AppState, NavigateToSettings>(navigateToSettings),
    TypedMiddleware<AppState, NavigateToWorkoutSummaryPageWithBundleAction>(
        _navigateToProfileWorkoutSummaryPageAction(logger)),
    TypedMiddleware<AppState, NavigateToWorkoutFlowScreenWithBundleAction>(
        _navigateToProfileWorkoutFlowScreenAction(logger)),
    TypedMiddleware<AppState, NavigateToProfileShareScreenAction>(
        _navigateToProfileShareScreenAction(logger)),
    TypedMiddleware<AppState, NavigateToChooseProgramNumberOfWeeksPageAction>(
        _navigateToChooseProgramNumberOfWeeksPageAction(logger)),
    TypedMiddleware<AppState, NavigateToChooseProgramLevelPageAction>(
        _navigateToChooseProgramLevelPageAction(logger)),
    TypedMiddleware<AppState, NavigateToChooseDaysOfTheWeekPageAction>(
        _navigateToChooseDaysOfTheWeekPageAction(logger)),
    TypedMiddleware<AppState, NavigateToProgramSetupSummaryPageAction>(
        _navigateToProgramSetupSummaryPageAction(logger)),
    TypedMiddleware<AppState, NavigateOnActiveProgramAction>(
        _navigateOnActiveProgram(logger)),
    TypedMiddleware<AppState, NavigateToFullSchedulePageAction>(
        _navigateToFullSchedulePageAction(logger)),
    TypedMiddleware<AppState, PopScreenAction>(_popAction(logger)),
    TypedMiddleware<AppState, OnProgramUpdatedAction>(
        _onProgramUpdatedAction(logger)),
    TypedMiddleware<AppState, ShowProgramDescriptionPageAction>(
        _showProgramDescriptionPage(logger)),
    TypedMiddleware<AppState, NavigateToProgramSummaryAction>(
        _showProgramSummaryPage(logger)),
    TypedMiddleware<AppState, NavigateToProgramShareResultPage>(
        _navigateToProgramShareResultPage(logger)),
    TypedMiddleware<AppState, OnProgramFinishedAction>(_popToMainPage(logger)),
    TypedMiddleware<AppState, ShowFilterWorkoutsAction>(
        navigateToFilterWorkoutsPage),
    TypedMiddleware<AppState, NavigateToExploreWorkoutsListAction>(
        navigateToExploreWorkoutsListScreenAction),
    TypedMiddleware<AppState, NavigateToNotificationsSettingsAction>(
        navigateToNotificationsSettingsAction),
    TypedMiddleware<AppState, NavigateToOnboardingScreenAction>(
        navigateToOnboardingScreenAction),
  ];
}

Middleware<AppState> _popToMainPage(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.popUntil(ModalRoute.withName(AppRoute.MAIN));
    next(action);
  };
}

Middleware<AppState> _navigateToExploreWorkoutsListScreenAction(
    TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    final navAction = action as NavigateToExploreWorkoutsListAction;
    Keys.navigatorKey.currentState.pushNamed(
        AppRoute.EXPLORE_WORKOUTS_LIST_SCREEN,
        arguments: {'title': navAction.title, 'workouts': navAction.workouts});
  };
}

Middleware<AppState> _navigateToNotificationsSettingsAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.NOTIFICATIONS_SETTINGS_SCREEN);
  };
}

Middleware<AppState> _navigateToProgramShareResultPage(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    final navAction = action as NavigateToProgramShareResultPage;
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.PROGRAM_SHARE, arguments: navAction.response);
  };
}

Middleware<AppState> _showProgramSummaryPage(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    final navAction = action as NavigateToProgramSummaryAction;
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.PROGRAM_SUMMARY, arguments: navAction.response);
  };
}

Middleware<AppState> _navigateToStoryPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    final navAction = action as NavigateToStoryPageAction;
    next(action);
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.STORY_PAGE, arguments: navAction.progressPageIndex);
  };
}

Middleware<AppState> _navigateToBreathingPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as NavigateToBreathingPageAction;
    Keys.navigatorKey.currentState.pushNamed(AppRoute.BREATHING_PAGE,
        arguments: {
          'progressPageIndex': navAction.progressPageIndex,
          'video': navAction.video
        });
  };
}

Middleware<AppState> _navigateToWisdomPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as NavigateToWisdomPageAction;
    Keys.navigatorKey.currentState.pushNamed(AppRoute.WISDOM_PAGE,
        arguments: navAction.progressPageIndex);
  };
}

Middleware<AppState> _popAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pop();
  };
}

Middleware<AppState> _navigateToLoginAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamed(AppRoute.LOGIN);
  };
}

Middleware<AppState> _onNavigateToProgramResetPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamed(AppRoute.PROGRAM_RESET);
  };
}

Middleware<AppState> _navigateToSortedExercisesPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    final navAction = action as NavigateToSortedExercisesPageAction;
    Keys.navigatorKey.currentState.pushNamed(AppRoute.SORTED_EXERCISES_PAGE,
        arguments: navAction.exerciseCategory.tag);
  };
}

Middleware<AppState> _navigateToSortedExercisesPageOnSeeAllPressedAction(
    TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    final navAction =
        action as NavigateToSortedExercisesPageOnSeeAllPressedAction;
    logger.logInfo('navAction');
    logger.logInfo(navAction.exerciseCategory.tag);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.SORTED_EXERCISES_PAGE,
        arguments: navAction.exerciseCategory.tag);
  };
}

Middleware<AppState> _navigateToEditProfile(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamed(AppRoute.PROFILE_EDIT_SCREEN);
  };
}

Middleware<AppState> _navigateToStorageSetting(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamed(AppRoute.STORAGE_SETTINGS_SCREEN);
  };
}

Middleware<AppState> _navigateToSettings(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamed(AppRoute.PROFILE_SETTINGS_SCREEN);
  };
}

Middleware<AppState> _navigateToMainScreenAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(
        AppRoute.MAIN, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _navigateToOnboardingScreenAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(
        AppRoute.ONBOARDING_SCREEN, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _showMainScreenAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(
        AppRoute.MAIN, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _navigateOnDropWorkoutState(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.popUntil(ModalRoute.withName(AppRoute.MAIN));
  };
}

Middleware<AppState> _navigateToSignUpAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(
        AppRoute.SIGN_UP, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _navigateToEntryScreenAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(
        AppRoute.ENTRY, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _navigateToResetPasswordAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());

    final navAction = action as NavigateToResetPasswordAction;

    if (navAction.deepLink == null) {
      Keys.navigatorKey.currentState.pushNamed(AppRoute.RESET_PASSWORD);
    } else {
      Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(
          AppRoute.RESET_PASSWORD, (Route<dynamic> route) => false,
          arguments: navAction.deepLink);
    }
  };
}

Middleware<AppState> _navigateBackToSplashScreenAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(
        AppRoute.SPLASH_COMPLETED, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _navigateToExerciseVideoPage(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as NavigateToExerciseVideoPage;
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.VIDEO_EXERCISE, arguments: navAction.exercise);
  };
}

Middleware<AppState> _navigateToSingleButtonPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.SINGLE_BUTTON_PAGE);
  };
}

Middleware<AppState> _navigateOnShowSelectedWorkoutPageAction( WorkoutListUseCase workoutListUseCase, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo(action.toString());

    final navAction = action as NavigateToWorkoutPreviewPageAction;
    final workout = navAction.workout;

    WorkoutProgressDto progress = selectProgress(store, workout);

    var newWorkout = store.state.mainPageState.newWorkouts
        .singleWhereOrNull((element) => element.theme == workout.theme);

    if (newWorkout == null) {
      /// get workout by id for program cases
      newWorkout = await workoutListUseCase.getWorkoutById(workout.id);
    }

    final userWeight = int.tryParse(store.state.loginState.user.weight ?? '0');
    final progressWorkoutId = progress?.workout != null &&
      progress.workout?.id != null ? progress.workout.id : '0';

    Keys.navigatorKey.currentState.pushNamed(
      WorkoutRoute.workoutPreview,
      arguments: [
        newWorkout,
        progressWorkoutId,
        store.state.isPremiumUser(),
        userWeight
      ]
    );

    next(action);
  };
}

Middleware<AppState> _navigateToSortedWorkoutsPage(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.SORTED_WORKOUTS_PAGE);
  };
}

Middleware<AppState> _navigateToFilterWorkoutsPage(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as ShowFilterWorkoutsAction;
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.FILTER_WORKOUTS_PAGE, arguments: navAction.bloc);
  };
}

Middleware<AppState> _navigateToTutorialScreenAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.TUTORIAL_PAGE);
  };
}

Middleware<AppState> _navigateToWorkoutSelectionAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.WORKOUT_SELECTION_PAGE);
  };
}

Middleware<AppState> _navigateToProgressAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    //Todo update hexagon
    //next(UpdateHexagonAction(store.state.mainPageState.progressPageIndex));
    Future.delayed(Duration(milliseconds: 55), () {
      Keys.navigatorKey.currentState
          .popUntil(ModalRoute.withName(AppRoute.MAIN));
    });
    next(action);
  };
}


Middleware<AppState> _onCompleteReadStoryAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as OnCompleteReadStoryAction;
    Keys.navigatorKey.currentState.pushNamed(AppRoute.STATEMENT_PAGE,
        arguments: navAction.progressPageIndex);
  };
}

Middleware<AppState> _onNavigateToHabitPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as NavigateToHabitPageAction;
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.HABIT_PAGE, arguments: navAction.progressPageIndex);
  };
}

Middleware<AppState> _navigateToProfileWorkoutSummaryPageAction(
    TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo("_navigateToWorkoutSummaryPageAction $action");
    next(action);
    final navAction = action as NavigateToWorkoutSummaryPageWithBundleAction;
    Keys.navigatorKey.currentState.pushNamed(
        AppRoute.PROFILE_WORKOUT_SUMMARY_PAGE,
        arguments: navAction.bundle);
  };
}

Middleware<AppState> _navigateToProfileWorkoutFlowScreenAction(
    TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo("_navigateToWorkoutFlowScreenAction $action");
    next(action);
    final navAction = action as NavigateToWorkoutFlowScreenWithBundleAction;
    Keys.navigatorKey.currentState.pushNamed(
        AppRoute.PROFILE_WORKOUT_FLOW_SCREEN_PAGE,
        arguments: navAction.bundle);
  };
}

Middleware<AppState> _navigateToProfileShareScreenAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as NavigateToProfileShareScreenAction;
    Keys.navigatorKey.currentState.pushNamed(
        AppRoute.PROFILE_SHARE_RESULTS_PAGE,
        arguments: navAction.bundle);
  };
}

Middleware<AppState> _navigateToChooseProgramNumberOfWeeksPageAction(
    TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.PROGRAM_CHOOSE_NUMBER_OF_WEEKS);
  };
}

Middleware<AppState> _navigateToChooseProgramLevelPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.PROGRAM_CHOOSE_LEVEL);
  };
}

Middleware<AppState> _navigateToChooseDaysOfTheWeekPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.PROGRAM_CHOOSE_DAYS_OF_WEEK);
  };
}

Middleware<AppState> _navigateToProgramSetupSummaryPageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    final navAction = action as NavigateToProgramSetupSummaryPageAction;
    final args = [];
    args.add(navAction.mode);
    args.add(navAction.level);
    args.add(navAction.numberOfWeeks);
    args.add(navAction.startDate);
    args.add(navAction.targetId);
    args.add(navAction.selectedDays);
    Keys.navigatorKey.currentState
        .pushNamed(AppRoute.PROGRAM_SETUP_SUMMARY, arguments: args);
  };
}

Middleware<AppState> _navigateOnActiveProgram(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.popUntil(ModalRoute.withName(AppRoute.MAIN));
  };
}

Middleware<AppState> _navigateToFullSchedulePageAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.PROGRAM_FULL_SCHEDULE);
  };
}

Middleware<AppState> _showProgramDescriptionPage(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Keys.navigatorKey.currentState.pushNamed(AppRoute.PROGRAM_DESCRIPTION);
  };
}

Middleware<AppState> _onProgramUpdatedAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    next(action);
    Future.delayed(Duration(milliseconds: 25), () {
      Keys.navigatorKey.currentState
          .popUntil(ModalRoute.withName(AppRoute.MAIN));
    });
  };
}
