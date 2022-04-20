import 'package:core/core.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/request/password_recovery_request.dart';
import 'package:totalfit/data/dto/request/unassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/model/exercise_category.dart';
import 'package:totalfit/model/workout_list_items.dart';
import 'package:totalfit/model/workout_preview_list_items.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/profile_actions.dart';
import 'package:totalfit/redux/actions/reset_password_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/selectors/progress_selectors.dart';

import '../states/app_state.dart';

List<Middleware<AppState>> storageMiddleware(UserRepository userRepository,
    PushNotificationsRepository pushNotificationsRepository, RemoteStorage remoteStorage, TFLogger logger) {
  final logoutMiddleware = _logoutMiddleware(userRepository, pushNotificationsRepository, logger);
  final updateProfileMiddleware = _updateProfileMiddleware(userRepository, logger);
  final resetPasswordMiddleware = _resetPasswordMiddleware(userRepository, logger);
  final sendNewPasswordActionMiddleware = _sendNewPasswordActionMiddleware(userRepository, logger);
  final buildSelectedWorkoutMiddleware = _buildSelectedWorkoutMiddleware(logger);
  final buildWorkoutItemListMiddleware = _buildWorkoutItemListMiddleware(logger);

  return [
    TypedMiddleware<AppState, LogoutAction>(logoutMiddleware),
    TypedMiddleware<AppState, ResetPasswordAction>(resetPasswordMiddleware),
    TypedMiddleware<AppState, SendNewPasswordAction>(sendNewPasswordActionMiddleware),
    TypedMiddleware<AppState, UpdateProfileAction>(updateProfileMiddleware),
    TypedMiddleware<AppState, NavigateToWorkoutPreviewPageAction>(buildSelectedWorkoutMiddleware),
    TypedMiddleware<AppState, OnBuildWorkoutItemListAction>(buildWorkoutItemListMiddleware),
    TypedMiddleware<AppState, UpdateProfileImageAction>(_updateProfileImageMiddleware(userRepository, logger)),
    TypedMiddleware<AppState, LoadExerciseListAction>(_loadExerciseListAction(remoteStorage, logger)),
  ];
}

Middleware<AppState> _updateProfileImageMiddleware(UserRepository userRepository, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      store.dispatch(ShowEditProfileLoadingAction(true));

      var user = store.state.loginState.user;
      final imagePath = (action as UpdateProfileImageAction).imagePath;
      String url = await userRepository.uploadProfileImage(imagePath);

      logger.logInfo("$action _updateProfileImageMiddleware $url");

      user = user.copyWith(photo: url);

      var body = UpdateProfileRequest(
        weight: int.tryParse(user.weight),
        height: int.tryParse(user.height),
        birthday: user.birthday,
        firstName: user.firstName,
        lastName: user.lastName,
        gender: user.gender == null ? null : user.gender.name.toUpperCase(),
        photo: url,
        location: Location(city: user.city, country: user.country),
      );

      await userRepository.updateProfile(body);
      await userRepository.insertUser(user);

      store.dispatch(UpdateUserStateAction(user));
      store.dispatch(UpdateUserPhoto(user.photo));
      store.dispatch(ShowEditProfileLoadingAction(false));
    } catch (e) {
      TfException error;
      if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_DB, e.toString());
      } else {
        error = e;
      }
      store.dispatch(OnEditProfileErrorAction(error));
      next(ErrorReportAction(where: "storage_middleware", errorMessage: e.toString(), trigger: action.runtimeType));
      logger.logError("$action _updateProfileMiddleware $e");
    }
  };
}

Middleware<AppState> _updateProfileMiddleware(UserRepository userRepository, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      store.dispatch(ShowEditProfileLoadingAction(true));

      final updatedUser = (action as UpdateProfileAction).user;

      await userRepository.insertUser(updatedUser);

      final body = UpdateProfileRequest(
        weight: int.tryParse(updatedUser.weight),
        height: int.tryParse(updatedUser.height),
        birthday: updatedUser.birthday,
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        gender: updatedUser.gender == null ? null : updatedUser.gender.name.toUpperCase(),
        photo: updatedUser.photo,
        location: Location(city: updatedUser.city, country: updatedUser.country),
      );

      await userRepository.updateProfile(body);

      logger.logInfo("$action _updateProfileMiddleware ${updatedUser.toString()}");
      store.dispatch(ShowEditProfileLoadingAction(false));
      store.dispatch(UpdateUserStateAction(updatedUser));
      store.dispatch(PopScreenAction());
    } catch (e) {
      TfException error;

      if (e is ApiException) {
        error = TfException(ErrorCode.ERROR_SAVE_PROFILE, e.serverErrorMessage);
      } else if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_DB, e.toString());
      } else {
        error = e;
      }
      store.dispatch(OnEditProfileErrorAction(error));
      next(ErrorReportAction(where: "storage_middleware", errorMessage: e.toString(), trigger: action.runtimeType));
      logger.logError("$action _updateProfileMiddleware $e");
    }
  };
}

Middleware<AppState> _logoutMiddleware(
    UserRepository userRepository, PushNotificationsRepository pushNotificationsRepository, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      await userRepository.deleteUser(store.state.loginState.user);
      final fcmToken = await pushNotificationsRepository.getFCMTokenFromStorage();
      await pushNotificationsRepository.unAssignFCMToken(UnAssignFCMTokenRequest(deviceToken: fcmToken));
      await pushNotificationsRepository.removeFCMTokenFromStorage();
      logger.logInfo("$action logoutMiddleware");
      next(action);
      store.dispatch(NavigateToSignUpAction());
    } catch (e) {
      logger.logError("$action loginMiddleware ${e.toString()}");
      next(ErrorReportAction(where: "storage_middleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _resetPasswordMiddleware(UserRepository userRepository, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action resetPasswordMiddleware");

    next(ChangeResetPasswordLoadingStateAction(true));

    final resetPasswordAction = action as ResetPasswordAction;

    try {
      await userRepository.resetPassword(resetPasswordAction.email);

      logger.logInfo("ResetPassword request success");
      next(OnResetPasswordRequestSuccessAction());
    } catch (e) {
      logger.logError("$action resetPasswordMiddleware ${e.toString()}");
      next(ErrorReportAction(where: "storage_middleware", errorMessage: e.toString(), trigger: action.runtimeType));
      next(OnResetPasswordExceptionAction(e));
    }
  };
}

Middleware<AppState> _sendNewPasswordActionMiddleware(UserRepository userRepository, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _sendNewPasswordActionMiddleware");

    next(ChangeResetPasswordLoadingStateAction(true));

    final sendNewPasswordAction = action as SendNewPasswordAction;

    try {
      final request = PasswordRecoveryRequest(
          token: sendNewPasswordAction.deepLink.userTokenUuid,
          password: sendNewPasswordAction.password,
          confirmPassword: sendNewPasswordAction.password);

      await userRepository.passwordRecovery(request);
      logger.logInfo("SendNewPassword request success");
      next(ChangeResetPasswordLoadingStateAction(false));
      next(OnNewPasswordSuccessAction());
    } catch (e) {
      logger.logError("$action _sendNewPasswordActionMiddleware ${e.toString()}");
      next(ErrorReportAction(where: "storage_middleware", errorMessage: e.toString(), trigger: action.runtimeType));
      next(OnResetPasswordExceptionAction(e));
    }
  };
}

Middleware<AppState> _buildWorkoutItemListMiddleware(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _buildWorkoutItemListAction");

    final buildAction = action as OnBuildWorkoutItemListAction;
    final workouts = buildAction.workouts;

    final firstWorkout = workouts.first;

    List itemList = [];

    itemList.add(PageHeaderItem(
        workout: firstWorkout,
        theme: firstWorkout.theme,
        equipment: firstWorkout.equipment,
        difficultyLevel: firstWorkout.difficultyLevel));

    itemList.add(SingleWorkoutListItem(workouts: workouts.where((element) => element.id != firstWorkout.id).toList()));

    final sortedExercises = WorkoutPageHelper.getSortedExercises(workouts);

    if (store.state.mainPageState.sortedWorkouts.isEmpty) {
      final sortedWorkouts = WorkoutPageHelper.getSortedWorkouts(workouts);
      next(OnWorkoutsSortedAction(sortedWorkouts));
    }

    final exerciseCategories = <ExerciseCategory>[];
    sortedExercises.entries.forEach((entry) {
      if (entry.key != 'EMPTY') {
        exerciseCategories.add(ExerciseCategory(tag: entry.key, image: _getImageByTag(entry.key)));
      }
    });

    final exerciseItem = ExercisesItem(exercises: exerciseCategories);

    itemList.add(exerciseItem);

    next(OnWorkoutItemListBuiltAction(itemList));
  };
}

Middleware<AppState> _buildSelectedWorkoutMiddleware(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _buildSelectedWorkoutMiddleware");
    try {
      final selectWorkoutAction = action as NavigateToWorkoutPreviewPageAction;
      final selectedWorkout = selectWorkoutAction.workout;
      final progress = selectProgress(store, selectedWorkout);
      WorkoutPhase currentStage;
      if (progress == null || progress.workoutPhase == null) {
        currentStage = WorkoutPhase.IDLE;
      } else {
        currentStage = progress.workoutPhase;
      }

      final header = PageHeaderBasicWorkoutListItem(
          title: selectedWorkout.theme,
          image: selectedWorkout.image,
          level: selectedWorkout.difficultyLevel,
          equipment: selectedWorkout.equipment,
          isLockedPremium: selectedWorkout.isPremium() && !store.state.isPremiumUser(),
          workoutPhase: progress == null ? null : progress.workoutPhase,
          duration: selectedWorkout.estimatedTime);
      ////////////////
      final exerciseCategory01 = ExerciseCategoryItem(
          dedicatedStage: WorkoutPhase.WARMUP,
          workout: selectedWorkout,
          exercises: null,//selectedWorkout.warmUp,
          isCompleted: currentStage >= WorkoutPhase.WARMUP);
      //////////////////
      final exerciseCategory02 = ExerciseCategoryItem(
          dedicatedStage: WorkoutPhase.SKILL,
          workout: selectedWorkout,
          exercises: [],//List.filled(1, selectedWorkout.skill),
          isCompleted: currentStage >= WorkoutPhase.SKILL);
      /////////////////
      final exerciseCategory03 = ExerciseCategoryItem(
          dedicatedStage: WorkoutPhase.WOD,
          workout: selectedWorkout,
          isCompleted: currentStage >= WorkoutPhase.WOD,
          exercises: []);//selectedWorkout.wod);
      //////////////////
      final exerciseCategory04 = ExerciseCategoryItem(
          dedicatedStage: WorkoutPhase.COOLDOWN,
          workout: selectedWorkout,
          isCompleted: currentStage >= WorkoutPhase.COOLDOWN,
          exercises: []);//selectedWorkout.cooldown);

      final categories = <BasicWorkoutListItem>[];
      categories.add(header);
      categories.add(exerciseCategory01);
      categories.add(exerciseCategory02);
      categories.add(exerciseCategory03);
      categories.add(exerciseCategory04);

      categories.add(SpaceWorkoutListItem());

      next(OnBasicWorkoutLoadedAction(categories));
      next(action);
    } catch (e) {
      next(ErrorReportAction(
          where: "_onShowSelectedWorkoutPageAction", trigger: action.runtimeType, errorMessage: e.toString()));
    }
  };
}

class WorkoutPageHelper {
  static void addToWorkouts(Map<String, List<WorkoutDto>> exercises, WorkoutDto workout, String key) {
    var tmp = exercises[key];
    if (tmp == null) {
      tmp = [];
    }
    tmp.add(workout);
    exercises.putIfAbsent(key, () => tmp);
  }

  static void removeEmptyTabs(Map<String, List<WorkoutDto>> workouts, String key) {
    if (workouts[key].isEmpty) {
      workouts.remove(key);
    }
  }

  String bodyWeight = "BODYWEIGHT";

  static List<WorkoutDto> getSortedWorkouts(List<WorkoutDto> workouts) {
    List<WorkoutDto> sortedWorkouts = workouts;
    //TODO: добавить ответ с бэка по фильтру
    /*String bodyWeight = "BODYWEIGHT";
    String equipment = "EQUIPMENT";
    String time20_25min = "20-25 MIN";
    String time25_40min = "25-40 MIN";
    String time40_50min = "40-50 MIN";

    sortedWorkouts.putIfAbsent(time20_25min, () => []);
    sortedWorkouts.putIfAbsent(time25_40min, () => []);
    sortedWorkouts.putIfAbsent(time40_50min, () => []);
    sortedWorkouts.putIfAbsent(bodyWeight, () => []);
    sortedWorkouts.putIfAbsent(equipment, () => []);

    workouts.forEach((workout) {
      if (workout.estimatedTime >= 20 && workout.estimatedTime <= 25) {
        addToWorkouts(sortedWorkouts, workout, time20_25min);
      }
      if (workout.estimatedTime > 25 && workout.estimatedTime <= 40) {
        addToWorkouts(sortedWorkouts, workout, time25_40min);
      }
      if (workout.estimatedTime > 40 && workout.estimatedTime <= 50) {
        addToWorkouts(sortedWorkouts, workout, time40_50min);
      }
      if (workout.equipment.isEmpty) {
        addToWorkouts(sortedWorkouts, workout, bodyWeight);
      }
      if (workout.equipment.isNotEmpty) {
        addToWorkouts(sortedWorkouts, workout, equipment);
      }
    });

    removeEmptyTabs(sortedWorkouts, time20_25min);
    removeEmptyTabs(sortedWorkouts, time25_40min);
    removeEmptyTabs(sortedWorkouts, time40_50min);
    removeEmptyTabs(sortedWorkouts, bodyWeight);
    removeEmptyTabs(sortedWorkouts, equipment);*/

    return sortedWorkouts;
  }

  static void addToExercises(Map<String, Set<Exercise>> map, List<Exercise> exercises) {
    exercises.forEach((exercise) {
      var tmp = map[exercise.tag];
      if (tmp == null) {
        tmp = Set();
      }
      if (tmp.where((e) => e.name == exercise.name).isEmpty) {
        tmp.add(exercise);
        map.putIfAbsent(exercise.tag, () => tmp);
      }
    });
  }

  static Map<String, Set<Exercise>> getSortedExercises(List<WorkoutDto> workouts) {
    Map<String, Set<Exercise>> exercises = {};
    workouts.forEach((workout) {
      addToExercises(exercises, []);//workout.warmUp);
      addToExercises(exercises, []);//workout.wod);
      addToExercises(exercises, []);//workout.cooldown);
    });

    return exercises;
  }

  static Map<String, Set<Exercise>> buildSortedExerciseList(List<Exercise> exerciseList) {
    Map<String, Set<Exercise>> sortedExercises = {};
    addToExercises(sortedExercises, exerciseList);
    return sortedExercises;
  }

  static List getCarcassItems() {
    List items = []..add(PageHeaderItem(workout: null, theme: null, equipment: null, difficultyLevel: null));

    final workout00 = WorkoutDto.forCarcass();
    final workout01 = WorkoutDto.forCarcass();
    final workout02 = WorkoutDto.forCarcass();
    final workout03 = WorkoutDto.forCarcass();
    final singleWorkoutList = <WorkoutDto>[]
      ..add(workout00)
      ..add(workout01)
      ..add(workout02)
      ..add(workout03);

    final programItem = SingleWorkoutListItem(workouts: singleWorkoutList);
    items.add(programItem);

    final exercise00 = ExerciseCategory(tag: "", image: null);
    final exercise01 = ExerciseCategory(tag: "", image: null);
    final exercise02 = ExerciseCategory(tag: "", image: null);

    final exerciseCategories = <ExerciseCategory>[]
      ..add(exercise00)
      ..add(exercise01)
      ..add(exercise02);

    final exerciseItem = ExercisesItem(exercises: exerciseCategories);

    items.add(exerciseItem);

    return items;
  }
}

Middleware<AppState> _loadExerciseListAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    logger.logInfo("$action _loadExerciseListAction");

    try {
      final response = await remoteStorage.getExerciseList();
      final sortedExercises = WorkoutPageHelper.buildSortedExerciseList(
          response.exerciseList.where((e) => e.tag.toUpperCase() != 'EMPTY').toList());
      next(OnExercisesSortedAction(sortedExercises));
    } catch (e) {
      logger.logError("$action loginMiddleware ${e.toString()}");
      store.dispatch(OnLoadSortedExercisesErrorAction('Failed to load Sorted Exercises'));
      next(
          ErrorReportAction(where: "_loadExerciseListAction", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

String _getImageByTag(String tag) {
  switch (tag) {
    case 'MONOSTRUCTURAL':
      return imMonoStructural;
    case 'GYMNASTIC':
      return imGymnastic;
    case 'STRETCHING':
      return imStretching;
    case 'STATIC_STRETCHING':
      return imStretching;
    case 'WEIGHTLIFTING':
      return imWeightLifting;
    default:
      throw 'unexpected tag: $tag';
  }
}
