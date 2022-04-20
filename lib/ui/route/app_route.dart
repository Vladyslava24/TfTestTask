import 'package:totalfit/ui/screen/main/progress/discount/discount_page.dart';
import 'package:totalfit/ui/screen/paywall_screen.dart';
import 'package:workout_api/api.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:totalfit/domain/bloc/workouts_bloc/workout_bloc.dart';
import 'package:totalfit/ui/route/no_transition_route.dart';
import 'package:totalfit/ui/screen/auth/reset_password_screen.dart';
import 'package:totalfit/ui/screen/main/explore/explore_workouts_list_screen.dart';
import 'package:totalfit/ui/screen/main/new_feature/new_feature_screen.dart';
import 'package:totalfit/ui/screen/main/profile/settings/notifications_settings_screen.dart';
import 'package:totalfit/ui/screen/main/profile/settings/storage_settings_screen.dart';
import 'package:totalfit/ui/screen/main/progress/breathing/breathing_page.dart';
import 'package:totalfit/ui/screen/main/workout/main/inner_pages/filter_workouts_page.dart';
import 'package:totalfit/ui/screen/main/workout/main/inner_pages/sorted_workouts_page.dart';
import 'package:totalfit/ui/screen/onboarding/screen/onboarding/onboarding_screen.dart';
import 'package:totalfit/ui/screen/splash/splash_screen.dart';

import '../../data/dto/response/feed_program_list_item_response.dart';
import '../../model/profile_workout_summary_bundle.dart';
import '../screen/auth/entry_screen.dart';
import '../screen/auth/login_screen.dart';
import '../screen/auth/sign_up_screen.dart';
import '../screen/main/main_screen.dart';
import '../screen/main/profile/edit/profile_edit_screen.dart';
import '../screen/main/profile/settings/settings_screen.dart';
import '../screen/main/profile/summary/profile_workout_summary_page.dart';
import '../screen/main/programs/edit/program_edit_screen.dart';
import '../screen/main/programs/progress/full_schedule/program_full_schedule_page.dart';
import '../screen/main/programs/setup/choose_program_days_screen.dart';
import '../screen/main/programs/setup/choose_program_level_screen.dart';
import '../screen/main/programs/setup/choose_program_number_of_weeks_screen.dart';
import '../screen/main/programs/setup/program_description_screen.dart';
import '../screen/main/programs/setup/summary/program_setup_summary_screen.dart';
import '../screen/main/programs/share/program_share_result_screen.dart';
import '../screen/main/programs/summary/program_summary_screen.dart';
import '../screen/main/progress/habit/habit_page.dart';
import '../screen/main/progress/story/statement_page.dart';
import '../screen/main/progress/story/story_page.dart';
import '../screen/main/progress/wisdom/wisdom_page.dart';
import '../screen/main/workout/main/inner_pages/single_exercise_page.dart';
import '../screen/main/workout/main/inner_pages/sorted_exercises_page.dart';
import '../screen/main/workout/selection/workout_selection_page.dart';
import '../screen/main/workout/tutorial/tutorial_screen.dart';

class AppRoute {
  static const LOGIN = "/to_login";
  static const MAIN = "/to_main";
  static const SIGN_UP = "/to_signup";
  static const ENTRY = "/to_entry";
  static const RESET_PASSWORD = "/to_reset_password";
  static const SPLASH_COMPLETED = "/to_splash_completed";
  static const SPLASH_INITIAL = "/to_splash_initial";
  static const VIDEO_EXERCISE = "/to_video_exercise";
  static const SORTED_WORKOUTS_PAGE = "/to_sorted_workouts_page";
  static const FILTER_WORKOUTS_PAGE = "/to_filter_workouts_page";
  static const SORTED_EXERCISES_PAGE = "/to_sorted_exercises_page";
  static const SHARE_RESULTS_PAGE = "/to_share_results_page";
  static const TUTORIAL_PAGE = "/to_tutorial_page";
  static const WORKOUT_SELECTION_PAGE = "/to_workout_list_page";
  static const SINGLE_BUTTON_PAGE = "/to_single_button_page";
  static const STATEMENT_PAGE = "/to_statement_page";
  static const HABIT_PAGE = "/to_habit_page";
  static const BREATHING_PAGE = "/to_breathing_page";
  static const PROFILE_EDIT_SCREEN = "/to_profile_edit_screen";
  static const PROFILE_SETTINGS_SCREEN = "/to_profile_settings_screen";
  static const STORAGE_SETTINGS_SCREEN = "/to_storage_setting_screen";
  static const PROFILE_WORKOUT_SUMMARY_PAGE =
      "/to_profile_workout_summary_page";
  static const PROFILE_WORKOUT_FLOW_SCREEN_PAGE =
      "/to_profile_workout_flow_screen_page";
  static const PROFILE_SHARE_RESULTS_PAGE = "/to_profile_share_results_page";
  static const PROGRAM_CHOOSE_NUMBER_OF_WEEKS =
      "/program_choose_number_of_weeks";
  static const PROGRAM_CHOOSE_LEVEL = "/program_choose_level";
  static const PROGRAM_CHOOSE_DAYS_OF_WEEK = "/program_choose_days_of_week";
  static const PROGRAM_SETUP_SUMMARY = "/program_setup_summary";
  static const PROGRAM_FULL_SCHEDULE = "/program_full_schedule";
  static const PROGRAM_RESET = "/program_reset";
  static const PROGRAM_DESCRIPTION = "/program_description";
  static const PROGRAM_SUMMARY = "/program_summary";
  static const PROGRAM_SHARE = "/program_share";
  static const STORY_PAGE = "/to_story_page";
  static const WISDOM_PAGE = "/to_wisdom_page";
  static const NOTIFICATIONS_SETTINGS_SCREEN =
      "/to_notifications_settings_screen";
  static const EXPLORE_WORKOUTS_LIST_SCREEN =
      "/to_explore_workouts_list_screen";
  static const NEW_FEATURE_SCREEN = "/to_new_feature_screen";
  static const ONBOARDING_SCREEN = "/to_onboarding_screen";
  static const DISCOUNT_SCREEN = "/to_discount_screen";
  static const PAYWALL_SCREEN_FROM_PREVIEW =
      WorkoutRoute.paywallFromWorkoutPreview;

  static final routeMap = {
    PAYWALL_SCREEN_FROM_PREVIEW: (settings) => MaterialPageRoute(
        builder: (BuildContext c) => PaywallScreen(isRoute: true),
        fullscreenDialog: true,
        settings: settings),
    LOGIN: (settings) => MaterialPageRoute(
        builder: (BuildContext c) =>
            LoginScreen(launcher: LoginLauncher.SPLASH),
        settings: settings),
    MAIN: (settings) => NoTransitionRoute(
        builder: (BuildContext c) => MainScreen(), settings: settings),
    SIGN_UP: (settings) => MaterialPageRoute(
        builder: (BuildContext c) => SignUpScreen(), settings: settings),
    ENTRY: (settings) => MaterialPageRoute(
        builder: (BuildContext c) => EntryScreen(), settings: settings),
    NEW_FEATURE_SCREEN: (settings) => MaterialPageRoute(
        builder: (BuildContext c) => NewFeatureScreen(), settings: settings),
    PROGRAM_SUMMARY: (settings) {
      FinishProgramResponse response = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) => ProgramSummaryScreen(response),
          settings: settings);
    },
    STORY_PAGE: (settings) {
      int progressPageIndex = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              StoryPage(progressPageIndex: progressPageIndex),
          settings: settings);
    },
    WISDOM_PAGE: (settings) {
      int progressPageIndex = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              WisdomPage(progressPageIndex: progressPageIndex),
          settings: settings);
    },
    BREATHING_PAGE: (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      final int progressPageIndex = arguments['progressPageIndex'];
      final String video = arguments['video'];
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              BreathingPage(progressPageIndex: progressPageIndex, video: video),
          settings: settings);
    },
    PROGRAM_SHARE: (settings) {
      FinishProgramResponse response = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) => ProgramShareResultScreen(response),
          settings: settings);
    },
    EXPLORE_WORKOUTS_LIST_SCREEN: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => ExploreWorkoutsListScreen(),
          settings: settings);
    },
    STORAGE_SETTINGS_SCREEN: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => StorageSettingsScreen(),
          settings: settings);
    },
    NOTIFICATIONS_SETTINGS_SCREEN: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => NotificationsSettingsScreen(),
          settings: settings);
    },
    PROFILE_EDIT_SCREEN: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => ProfileEditScreen(), settings: settings);
    },
    PROFILE_SETTINGS_SCREEN: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => SettingsScreen(), settings: settings);
    },
    VIDEO_EXERCISE: (settings) {
      Exercise exercise = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) => SingleExercisePage(exercise: exercise),
          settings: settings);
    },
    RESET_PASSWORD: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              ResetPasswordScreen(deepLink: settings.arguments),
          settings: settings);
    },
    FILTER_WORKOUTS_PAGE: (settings) {
      WorkoutBloc bloc = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) => FilterWorkoutsPage(bloc),
          settings: settings);
    },
    SORTED_EXERCISES_PAGE: (settings) {
      String tag = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) => SortedExercisesPage(initialTag: tag),
          settings: settings);
    },
    SORTED_WORKOUTS_PAGE: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => SortedWorkoutsPage(),
          settings: settings);
    },
    SPLASH_COMPLETED: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              SplashScreen(launchMode: SplashLaunchMode.COMPLETED),
          settings: settings);
    },
    SPLASH_INITIAL: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              SplashScreen(launchMode: SplashLaunchMode.INITIAL),
          settings: settings);
    },
    TUTORIAL_PAGE: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => TutorialScreen(), settings: settings);
    },
    WORKOUT_SELECTION_PAGE: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => WorkoutSelectionPage(),
          settings: settings);
    },
    STATEMENT_PAGE: (settings) {
      int progressPageIndex = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              StatementPage(progressPageIndex: progressPageIndex),
          settings: settings);
    },
    HABIT_PAGE: (settings) {
      int progressPageIndex = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              HabitPage(progressPageIndex: progressPageIndex),
          settings: settings);
    },
    PROFILE_WORKOUT_FLOW_SCREEN_PAGE: (settings) {
      WorkoutSummaryPayload bundle = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) => WorkoutFlowScreen(
                workoutSummaryPayload: bundle,
                workout: bundle.workoutModel,
                workoutId: bundle.id,
              ),
          settings: settings);
    },
    PROFILE_WORKOUT_SUMMARY_PAGE: (settings) {
      WorkoutSummaryBundle bundle = settings.arguments;
      return MaterialPageRoute(
          builder: (BuildContext c) =>
              ProfileWorkoutSummaryPage(bundle: bundle),
          settings: settings);
    },
    ONBOARDING_SCREEN: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => OnboardingScreen(), settings: settings);
    },
    PROGRAM_CHOOSE_NUMBER_OF_WEEKS: (settings) {
      return CupertinoPageRoute(
          builder: (BuildContext c) => ChooseProgramNumberOfWeeksPage(),
          settings: settings);
    },
    PROGRAM_CHOOSE_LEVEL: (settings) {
      return CupertinoPageRoute(
          builder: (BuildContext c) => ChooseProgramLevelPage(),
          settings: settings);
    },
    PROGRAM_SETUP_SUMMARY: (settings) {
      final ProgramSummaryMode mode = (settings.arguments as List)[0];
      final LevelType level = (settings.arguments as List)[1];
      final int numberOfWeeks = (settings.arguments as List)[2];
      final String startDate = (settings.arguments as List)[3];
      final String targetId = (settings.arguments as List)[4];
      final List<int> selectedDays = (settings.arguments as List)[5];

      return CupertinoPageRoute(
          builder: (BuildContext c) => ProgramSetupSummaryScreen(mode,
              level: level,
              numberOfWeeks: numberOfWeeks,
              startDate: startDate,
              targetId: targetId,
              selectedDays: selectedDays),
          settings: settings);
    },
    PROGRAM_CHOOSE_DAYS_OF_WEEK: (settings) {
      return CupertinoPageRoute(
          builder: (BuildContext c) => ChooseProgramDaysPage(),
          settings: settings);
    },
    PROGRAM_FULL_SCHEDULE: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => ProgramFullSchedulePage(),
          settings: settings);
    },
    PROGRAM_RESET: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => EditProgramScreen(), settings: settings);
    },
    PROGRAM_DESCRIPTION: (settings) {
      return MaterialPageRoute(
          builder: (BuildContext c) => ProgramDescriptionPage(),
          settings: settings);
    },
    DISCOUNT_SCREEN: (settings) {
      final String type = settings.arguments as String;
      return MaterialPageRoute(
        builder: (BuildContext c) {
          switch(type) {
            case 'newYear':
              return DiscountPage.newYear();
            case 'easter':
              return DiscountPage.easter();
            case 'stPatrick':
              return DiscountPage.stPatrick();
            default:
              return DiscountPage.newYear();
          }
        },
        settings: settings
      );
    }
  };
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
