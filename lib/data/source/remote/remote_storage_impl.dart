import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:core/core.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:core/core.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/data/dto/onboarding_info_dto.dart';
import 'package:totalfit/data/dto/request/login_request.dart';
import 'package:totalfit/data/dto/request/password_recovery_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_config_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_settings_request.dart';
import 'package:totalfit/data/dto/request/reassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/sign_in_with_social_request.dart';
import 'package:totalfit/data/dto/request/sign_up_request.dart';
import 'package:totalfit/data/dto/request/unassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/update_breath_practice_request.dart';
import 'package:totalfit/data/dto/request/assign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/update_progress_request.dart';
import 'package:totalfit/data/dto/response/breah_practice_response.dart';
import 'package:totalfit/data/dto/response/exercise_list_response.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/data/dto/response/habbit_completion_toggle_response.dart';
import 'package:totalfit/data/dto/response/habit_response.dart';
import 'package:totalfit/data/dto/response/load_country_list_response.dart';
import 'package:totalfit/data/dto/response/login_response.dart';
import 'package:totalfit/data/dto/response/mood_tracking_progress_response.dart';
import 'package:totalfit/data/dto/response/parse_url_response.dart';
import 'package:totalfit/data/dto/response/progress_response.dart';
import 'package:totalfit/data/dto/response/push_notifications_settings_response.dart';
import 'package:totalfit/data/dto/response/sign_up_response.dart';
import 'package:totalfit/data/dto/response/statement_response.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';
import 'package:totalfit/data/dto/response/profile_completed_workouts_response.dart';
import 'package:totalfit/data/dto/response/profile_statistics_response.dart';
import 'package:totalfit/data/dto/response/current_program_limited_response.dart';
import 'package:totalfit/data/dto/response/feed_programs_response.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:totalfit/data/dto/response/active_program_response.dart';
import 'package:totalfit/data/dto/request/program_request.dart';

class RemoteStorageImpl implements RemoteStorage {
  static const SCHEME = 'https://';
  static const PATH_SIGN_IN_WITH_SOCIAL = "/api/v1/oauth2";
  static const PATH_SIGN_UP = "/api/v1/users";
  static const PATH_LOG_IN = "/api/v1/login";
  static const PATH_COUNTRIES = "/api/v1/places/countries";
  static const PATH_FORGOT_PASSWORD = "/api/v1/users/forgot-password";
  static const PATH_PASSWORD_RECOVERY = "/api/v1/users/recovery";
  static const PATH_STORIES = "/api/v1/offline-workouts/stories";
  static const PATH_HABITS = "/api/v1/offline-workouts/habits";
  static const PATH_WISDOM = "/api/v1/offline-workouts/wisdom";
  static const PATH_REMOTE_STORAGE_STATE = "/api/v1/progress/summary";
  static const PATH_GET_PROGRESS = "/api/v1/progress";
  static const PATH_UPDATE_PROGRESS = "/api/v1/progress";
  static const PATH_UPDATE_STATEMENT = "/api/v1/progress/will-statement";
  static const PATH_UPDATE_PROFILE = "/api/v1/users/profile";
  static const PATH_PROFILE_STATISTICS = "/api/v1/progress/workout-progress/summary";
  static const PATH_DELETE_WORKOUT_PROGRESS = "/api/v1/progress/workout-progress";
  static const PATH_COMPLETED_WORKOUTS_PROGRESS = "/api/v1/progress/workout-progress";
  static const PATH_SELECT_HABIT = "/api/v1/progress/habit";
  static const PATH_UN_SELECT_HABIT = "/api/v1/progress/habit";
  static const PATH_COMPLETE_HABIT = "/api/v1/progress/habit";
  static const PATH_TOGGLE_HABIT_COMPLETION = "/api/v1/progress/habit/activity";
  static const PATH_RECOMMENDED_HABIT = "/api/v1/progress/recommended-habit";
  static const PATH_UPLOAD_PROFILE_IMAGE = "/api/v1/files/upload";
  static const PATH_PARSE_URL_STATEMENT = "/api/v1/parser";
  static const PATH_GET_EXERCISES = "/api/v1/online-workouts/exercises";
  static const PATH_FEED_PROGRAMS = "/api/v1/online-program";
  static const PATH_FINISH_PROGRAM = "/api/v1/online-program/finish";
  static const PATH_INTERRUPT_PROGRAM = "/api/v1/online-program/interrupt";
  static const PATH_START_PROGRAM = "/api/v1/online-program/start";
  static const PATH_UPDATE_PROGRAM = "/api/v1/online-program";
  static const PATH_GET_CURRENT_PROGRAM = "/api/v1/online-program/progress";
  static const PATH_UPDATE_BREATH_PRACTICE = "/api/v1/progress/breath-practice";
  static const PATH_ASSIGN_FCM_TOKEN = "/api/v1/notifications/assign-token";
  static const PATH_REASSIGN_FCM_TOKEN = "/api/v1/notifications/reassign-token";
  static const PATH_UNASSIGN_FCM_TOKEN = "/api/v1/notifications/unassign-token";
  static const PATH_PUSH_NOTIFICATIONS_CONFIG = '/api/v1/notifications/push-notification-config';
  static const PATH_SETUP_NOTIFICATIONS_CONFIG = '/api/v1/notifications/setup-push-notifications';
  static const PATH_BEST_MATCH_PROGRAM = '/api/v1/online-program/best-match';
  static const PATH_ADD_ONBOARDING_INFO = '/api/v1/onboarding';
  static const PATH_GET_MOOD_TRACKING_PROGRESS = '/api/v1/progress/mood-tracking/state';

  static const KEY_JWT = "KEY_JWT";
  static String baseUrl;

  FlutterSecureStorage _secureStorage;

  static RemoteStorageImpl sInstance;
  final NetworkClient networkClient;

  RemoteStorageImpl(this._secureStorage, this.networkClient, FlavorConfig flavorConfig) {
    baseUrl = flavorConfig.values.apiUrl;
    sInstance = this;
  }

  @override
  Future<User> logIn(LogInRequest request) async {
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_LOG_IN',
      body: request.toMap(),
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient.executeRequest(networkRequest).then((response) {
      String jwt = response.headers["authorization"];
      _secureStorage.write(key: KEY_JWT, value: jwt);
      final logInResponse = LogInResponse.fromMap(response.body);
      User user = logInResponse.toUser();
      return user;
    });
  }

  @override
  Future<User> signInWithSocial(SignInWithSocialRequest request) async {
    final appLocale = AppLocale.get();
    final zoneId = await FlutterNativeTimezone.getLocalTimezone();

    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_SIGN_IN_WITH_SOCIAL',
      body: request.toMap(),
    );

    networkRequest.body.putIfAbsent('locale', () => appLocale.locale);
    networkRequest.body.putIfAbsent('zoneId', () => zoneId);

    return networkClient.executeRequest(networkRequest).then((response) {
      String jwt = response.headers["authorization"];
      _secureStorage.write(key: KEY_JWT, value: jwt);
      SignUpResponse signUpResponse = SignUpResponse.fromMap(response.body);
      User user = signUpResponse.toUser();
      if (user.wasOnboarded) {
        LogInResponse loginResponse = LogInResponse.fromMap(response.body);
        user = loginResponse.toUser();
      }
      return user;
    });
  }

  @override
  Future<User> signUp(SignUpRequest request) async {
    final appLocale = AppLocale.get();
    final zoneId = await FlutterNativeTimezone.getLocalTimezone();

    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_SIGN_UP',
      body: request.toMap(),
    );

    networkRequest.body.putIfAbsent('locale', () => appLocale.locale);
    networkRequest.body.putIfAbsent('zoneId', () => zoneId);

    return networkClient.executeRequest(networkRequest).then((response) {
      String jwt = response.headers["authorization"];
      _secureStorage.write(key: KEY_JWT, value: jwt);
      SignUpResponse signUpResponse = SignUpResponse.fromMap(response.body);
      User user = signUpResponse.toUser();
      return user;
    });
  }

  Future<List<Country>> fetchCountryList(String prefix, String locale) async {
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_COUNTRIES',
      queryParameters: {
        "prefix": prefix,
        "languageCode": locale,
        "locale": AppLocale.get().locale,
      },
    );
    return networkClient.executeRequest(networkRequest).then((response) {
      final l = (response.body as List).map((json) => Country.fromJson(json)).toList();
      return l;
    });
  }

  @override
  Future<void> resetPassword(String email) async {
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_FORGOT_PASSWORD',
      queryParameters: {
        "email": email,
        "device": "MOBILE",
        "locale": AppLocale.get().locale,
      },
    );
    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<void> passwordRecovery(PasswordRecoveryRequest request) async {
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_PASSWORD_RECOVERY',
      body: request.toMap(),
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<HabitListResponse> getHabitList() async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_HABITS',
      jwt: jwt,
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient.executeRequest(networkRequest).then((response) => HabitListResponse.fromMap(response.body));
  }

  @override
  Future<Habit> getRecommendedHabit(String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_RECOMMENDED_HABIT',
      queryParameters: {
        "date": date,
        "locale": AppLocale.get().locale
      },
      jwt: jwt,
    );
    return networkClient.executeRequest(networkRequest).then((response) => Habit.fromMap(response.body));
  }

  @override
  Future<ProgressResponse> getProgress(String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_GET_PROGRESS',
      queryParameters: {
        "date": date,
        "locale": AppLocale.get().locale
      },
      jwt: jwt,
    );
    return networkClient.executeRequest(networkRequest).then((response) => ProgressResponse.fromMap(response.body));
  }

  @override
  Future<ProgressResponse> updateProgress(UpdateProgressRequest request) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_UPDATE_PROGRESS',
      queryParameters: {
        "date": today(),
        "locale": AppLocale.get().locale
      },
      jwt: jwt,
      body: request.toJson(),
    );
    return networkClient.executeRequest(networkRequest).then((response) => ProgressResponse.fromMap(response.body));
  }

  @override
  Future<StatementResponse> updateStatement(String id, String date, bool isDone) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.put(
      endpoint: '$PATH_UPDATE_STATEMENT/$id',
      queryParameters: {
        "date": date,
        "resolution": isDone.toString(),
        "locale": AppLocale.get().locale
      },
      jwt: jwt,
    );
    return networkClient.executeRequest(networkRequest).then((response) => StatementResponse.fromMap(response.body));
  }

  @override
  Future<String> updateProfile(UpdateProfileRequest request) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.put(
      endpoint: '$PATH_UPDATE_PROFILE',
      jwt: jwt,
      body: request.toMap(),
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient.executeRequest(networkRequest).then((response) => response.toString());
  }

  @override
  Future<ProfileStatisticsResponse> getProfileStatistics() async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_PROFILE_STATISTICS',
      jwt: jwt,
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => ProfileStatisticsResponse.fromJson(response.body))
        .onError((error, stackTrace) {
          throw Exception(error);
    });
  }

  @override
  Future<ProfileCompletedWorkoutsResponse> getProfileCompletedWorkouts(int offset, int pageSize) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_COMPLETED_WORKOUTS_PROGRESS',
      jwt: jwt,
      queryParameters: {
        "stage": "FINISHED",
        "offset": offset.toString(),
        "pageSize": pageSize.toString(),
        "locale": AppLocale.get().locale
      },
    );
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => ProfileCompletedWorkoutsResponse.fromJson(response.body));
  }

  @override
  Future deleteWorkoutProgress(String id) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.delete(
      endpoint: '$PATH_DELETE_WORKOUT_PROGRESS/$id',
      jwt: jwt,
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<HabitDto> selectHabit(String id, String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_SELECT_HABIT/$id',
      queryParameters: {
        "date": date,
        "locale": AppLocale.get().locale
      },
      jwt: jwt,
    );
    return networkClient.executeRequest(networkRequest).then((response) => HabitDto.fromMap(response.body));
  }

  @override
  Future<HabitCompletionToggleResponse> toggleHabitCompletion(String id, bool completed, String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
        endpoint: '$PATH_TOGGLE_HABIT_COMPLETION/$id',
        queryParameters: {
          "date": date,
          "resolution": completed.toString(),
          "locale": AppLocale.get().locale
        },
        jwt: jwt);
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => HabitCompletionToggleResponse.fromMap(response.body));
  }

  @override
  Future<void> unSelectHabit(String id, String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.delete(
        endpoint: '$PATH_UN_SELECT_HABIT/$id',
        queryParameters: {
          "date": date,
          "locale": AppLocale.get().locale
        },
        jwt: jwt);
    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<Habit> completeHabit(String id, bool selected) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.put(
        endpoint: '$PATH_COMPLETE_HABIT/$id',
        queryParameters: {
          "resolution": selected.toString(),
          "locale": AppLocale.get().locale
        },
        jwt: jwt);
    return networkClient.executeRequest(networkRequest).then((response) => Habit.fromMap(response.body));
  }

  @override
  Future<String> uploadProfileImage(String imagePath) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    Uint8List intList = await File(imagePath).readAsBytes();

    final networkRequest = NetworkRequest.postMultipart(
        endpoint: '$PATH_UPLOAD_PROFILE_IMAGE',
        files: [FileFormData(bytes: intList, name: Uri.parse(imagePath).pathSegments.last)],
        jwt: jwt,
        queryParameters: {
          'uploadType': 'PROFILE_IMAGE',
          'locale': AppLocale.get().locale
        }
    );

    return networkClient.executeRequest(networkRequest).then((response) => response.body["name"]);
  }

  @override
  Future<ParseUrlResponse> parseUrl(String url) async {
    final networkRequest =
        NetworkRequest.post(
          endpoint: '$PATH_PARSE_URL_STATEMENT',
          queryParameters: {
            "link": url,
            "locale": AppLocale.get().locale
          });
    return networkClient.executeRequest(networkRequest).then((response) => ParseUrlResponse.fromMap(response.body));
  }

  @override
  Future<ExerciseListResponse> getExerciseList() async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest =
      NetworkRequest.get(
        endpoint: '$PATH_GET_EXERCISES',
        jwt: jwt,
        queryParameters: {
      "size": 1000.toString(),
      "locale": AppLocale.get().locale
    });
    return networkClient.executeRequest(networkRequest).then((response) => ExerciseListResponse.fromMap(response.body));
  }

  @override
  Future<FeedProgramsResponse> getFeedPrograms(int offset, int pageSize) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest =
      NetworkRequest.get(
        endpoint: '$PATH_FEED_PROGRAMS',
        jwt: jwt,
        queryParameters: {
          "offset": offset.toString(),
          "pageSize": pageSize.toString(),
          "locale": AppLocale.get().locale
        }
      );
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => FeedProgramsResponse.fromJson(response.body));
  }

  @override
  Future<CurrentProgramLimitedResponse> getCurrentLimitedProgram(String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
        endpoint: '$PATH_GET_CURRENT_PROGRAM',
        jwt: jwt,
        queryParameters: {
          "date": date,
          "response": "LIMITED",
          "locale": AppLocale.get().locale
        });
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => CurrentProgramLimitedResponse.fromJson(response.body));
  }

  @override
  Future<ActiveProgramResponse> getCurrentFullProgram(String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
        endpoint: '$PATH_GET_CURRENT_PROGRAM',
        jwt: jwt,
        queryParameters: {
          "date": date,
          "response": "FULL",
          "locale": AppLocale.get().locale
        });
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => ActiveProgramResponse.fromJson(response.body));
  }

  @override
  Future<FinishProgramResponse> finishProgram(int id) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
        endpoint: '$PATH_FINISH_PROGRAM/$id',
        jwt: jwt,
        queryParameters: {
          "date": today(),
          "locale": AppLocale.get().locale
        });
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => FinishProgramResponse.fromJson(response.body));
  }

  @override
  Future<ActiveProgramResponse> startProgram(ProgramRequest request) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
        endpoint: '$PATH_START_PROGRAM',
        jwt: jwt,
        body: request.toJson(),
        queryParameters: {
          "date": today(),
          "locale": AppLocale.get().locale
        });

    return networkClient
        .executeRequest(networkRequest)
        .then((response) => ActiveProgramResponse.fromJson(response.body));
  }

  @override
  Future<int> interruptProgram() async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_INTERRUPT_PROGRAM',
      jwt: jwt,
      queryParameters: AppLocale.get().toMap()
    );
    final response = await networkClient.executeRequest(networkRequest);
    return response?.statusCode ?? 404;
  }

  @override
  Future<ActiveProgramResponse> updateProgram(ProgramRequest request) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.put(
      endpoint: '$PATH_UPDATE_PROGRAM',
      body: request.toJson(),
      queryParameters: AppLocale.get().toMap(),
      jwt: jwt,
    );
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => ActiveProgramResponse.fromJson(response.body));
  }

  @override
  Future<BreathPracticeResponse> updateBreathPractice(UpdateBreathPracticeRequest request) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
        endpoint: '$PATH_UPDATE_BREATH_PRACTICE/${request.breathPracticeId}',
        jwt: jwt,
        queryParameters: {
          "date": '${request.date}',
          "createdAt": '${request.createdAt}',
          "locale": AppLocale.get().locale
        });
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => BreathPracticeResponse.fromJson(response.body));
  }

  @override
  FutureOr<void> assignFCMToken(AssignFCMTokenRequest assignFCMTokenRequest) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_ASSIGN_FCM_TOKEN',
      body: assignFCMTokenRequest.toMap(),
      jwt: jwt,
      queryParameters: AppLocale.get().toMap()
    );

    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<void> reassignFCMToken(ReAssignFCMTokenRequest reassignFCMTokenRequest) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_REASSIGN_FCM_TOKEN',
      body: reassignFCMTokenRequest.toMap(),
      jwt: jwt,
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<void> unAssignFCMToken(UnAssignFCMTokenRequest unAssignFCMTokenRequest) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_UNASSIGN_FCM_TOKEN',
      body: unAssignFCMTokenRequest.toMap(),
      jwt: jwt,
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<PushNotificationsSettingsResponse> getPushNotificationsConfig(
      PushNotificationsConfigRequest pushNotificationsConfigRequest) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
        endpoint: '$PATH_PUSH_NOTIFICATIONS_CONFIG',
        jwt: jwt,
        headers: {
          "device-token": pushNotificationsConfigRequest.getToken(),
          "locale": AppLocale.get().locale
        });
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => PushNotificationsSettingsResponse.fromJson(response.body));
  }

  @override
  Future<PushNotificationsSettingsResponse> setupPushNotificationsConfig(
      PushNotificationsSettingsRequest pushNotificationsSettingsRequest) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_SETUP_NOTIFICATIONS_CONFIG',
      jwt: jwt,
      body: pushNotificationsSettingsRequest.toMap(),
      queryParameters: AppLocale.get().toMap()
    );
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => PushNotificationsSettingsResponse.fromJson(response.body));
  }

  @override
  Future<FeedProgramItemResponse> getBestMatchProgram(int weeksCount, String level, List<String> equipment) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
        endpoint: '$PATH_BEST_MATCH_PROGRAM',
        jwt: jwt,
        queryParameters: {
          "weeksCount": weeksCount.toString(),
          "level": level,
          "equipment": equipment.join(","),
          "locale": AppLocale.get().locale
        });
    return networkClient
        .executeRequest(networkRequest)
        .then((response) => FeedProgramItemResponse.fromJson(response.body));
  }

  @override
  Future<void> addOnboardingInformation(OnboardingInfoDto payload) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.post(
        endpoint: '$PATH_ADD_ONBOARDING_INFO',
        jwt: jwt,
        body: payload.toJson(),
        queryParameters: {
          "date": today(),
          "locale": AppLocale.get().locale
        });
    return networkClient.executeRequest(networkRequest);
  }

  @override
  Future<MoodTrackingProgressResponse> getMoodTrackingProgress(String date) async {
    final jwt = await _secureStorage.read(key: KEY_JWT);
    final networkRequest = NetworkRequest.get(
      endpoint: '$PATH_GET_MOOD_TRACKING_PROGRESS',
      queryParameters: {"date": date},
      jwt: jwt
    );
    return networkClient.executeRequest(networkRequest)
      .then((response) => MoodTrackingProgressResponse.fromJson(response.body));
  }
}

const REQUEST_TIMEOUT_SEC = 10;
