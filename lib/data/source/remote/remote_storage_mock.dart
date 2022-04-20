import 'dart:async';

import 'package:core/core.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/data/dto/onboarding_info_dto.dart';
import 'package:totalfit/data/dto/request/login_request.dart';
import 'package:totalfit/data/dto/request/password_recovery_request.dart';
import 'package:totalfit/data/dto/request/program_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_config_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_settings_request.dart';
import 'package:totalfit/data/dto/request/reassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/sign_in_with_social_request.dart';
import 'package:totalfit/data/dto/request/sign_up_request.dart';
import 'package:totalfit/data/dto/request/unassign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/update_breath_practice_request.dart';
import 'package:totalfit/data/dto/request/assign_fcm_token_request.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';
import 'package:totalfit/data/dto/request/update_progress_request.dart';
import 'package:totalfit/data/dto/response/active_program_response.dart';
import 'package:totalfit/data/dto/response/breah_practice_response.dart';
import 'package:totalfit/data/dto/response/current_program_limited_response.dart';
import 'package:totalfit/data/dto/response/exercise_list_response.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/data/dto/response/feed_programs_response.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:totalfit/data/dto/response/habbit_completion_toggle_response.dart';
import 'package:totalfit/data/dto/response/habit_response.dart';
import 'package:totalfit/data/dto/response/load_country_list_response.dart';
import 'package:totalfit/data/dto/response/mood_tracking_progress_response.dart';
import 'package:totalfit/data/dto/response/parse_url_response.dart';
import 'package:totalfit/data/dto/response/profile_completed_workouts_response.dart';
import 'package:totalfit/data/dto/response/profile_statistics_response.dart';
import 'package:totalfit/data/dto/response/progress_response.dart';
import 'package:totalfit/data/dto/response/push_notifications_settings_response.dart';
import 'package:totalfit/data/dto/response/statement_response.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:workout_data_legacy/data.dart';

class MockServer implements RemoteStorage {
  MockServer();

  @override
  Future<User> logIn(LogInRequest request) async {
    return Future.delayed(Duration(milliseconds: 1500), () => User.mock());
  }

  @override
  Future<User> signUp(SignUpRequest request) {
    final user =
        User(lastName: "${request.lastName}", email: "${request.email}", roles: ["ATHLETE"], status: Status.ACTIVE);

    return Future.delayed(Duration(milliseconds: 1500), () => user);
  }

  @override
  Future<String> resetPassword(String email) {
    return Future.delayed(Duration(milliseconds: 1500), () => null);
  }

  @override
  Future<List<Country>> fetchCountryList(String prefix, String locale) async {
    return Future.delayed(Duration(milliseconds: 500), () {
      final list = List.generate(50, (index) => Country(name: "item $index"));
      list.retainWhere((c) => c.name.startsWith(prefix));
      return list;
    });
  }

  @override
  void closeCountryClient() {
    print("closeCountryClient");
  }

  Future<String> verifyRecoveryToken(String token) {
    return Future.delayed(Duration(milliseconds: 1500), () => null);
  }

  @override
  Future<String> passwordRecovery(PasswordRecoveryRequest request) {
    return Future.delayed(Duration(milliseconds: 1500), () => null);
  }

  @override
  Future<Habit> completeHabit(String id, bool selected) {
    // TODO: implement completeHabit
    throw UnimplementedError();
  }

  @override
  Future<String> deleteWorkoutProgress(String id) {
    // TODO: implement deleteWorkoutProgress
    throw UnimplementedError();
  }

  @override
  Future<FinishProgramResponse> finishProgram(int id) {
    // TODO: implement finishProgram
    throw UnimplementedError();
  }

  @override
  Future<ActiveProgramResponse> getCurrentFullProgram(String date) {
    // TODO: implement getCurrentFullProgram
    throw UnimplementedError();
  }

  @override
  Future<CurrentProgramLimitedResponse> getCurrentLimitedProgram(String date) {
    // TODO: implement getCurrentLimitedProgram
    throw UnimplementedError();
  }

  @override
  Future<ExerciseListResponse> getExerciseList() {
    // TODO: implement getExerciseList
    throw UnimplementedError();
  }

  @override
  Future<FeedProgramsResponse> getFeedPrograms(int offset, int pageSize) {
    // TODO: implement getFeedPrograms
    throw UnimplementedError();
  }

  @override
  Future<HabitListResponse> getHabitList() async {
    // TODO: implement getHabitList
    throw UnimplementedError();
  }

  @override
  Future<ProfileCompletedWorkoutsResponse> getProfileCompletedWorkouts(int offset, int pageSize) {
    // TODO: implement getProfileCompletedWorkouts
    throw UnimplementedError();
  }

  @override
  Future<ProfileStatisticsResponse> getProfileStatistics() {
    // TODO: implement getProfileStatistics
    throw UnimplementedError();
  }

  @override
  Future<ProgressResponse> getProgress(String date) {
    // TODO: implement getProgress
    throw UnimplementedError();
  }

  @override
  Future<Habit> getRecommendedHabit(String date) {
    // TODO: implement getRecommendedHabit
    throw UnimplementedError();
  }

  @override
  Future<int> interruptProgram() {
    // TODO: implement interruptProgram
    throw UnimplementedError();
  }

  @override
  Future<ParseUrlResponse> parseUrl(String url) {
    // TODO: implement parseUrl
    throw UnimplementedError();
  }

  @override
  Future<HabitDto> selectHabit(String habitId, String date) {
    // TODO: implement selectHabit
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithSocial(SignInWithSocialRequest request) {
    // TODO: implement signInWithSocial
    throw UnimplementedError();
  }

  @override
  Future<ActiveProgramResponse> startProgram(ProgramRequest request) {
    // TODO: implement startProgram
    throw UnimplementedError();
  }

  @override
  Future<HabitCompletionToggleResponse> toggleHabitCompletion(String id, bool completed, String date) {
    // TODO: implement toggleHabitCompletion
    throw UnimplementedError();
  }

  @override
  Future<void> unSelectHabit(String habitModelId, String date) {
    // TODO: implement unSelectHabit
    throw UnimplementedError();
  }

  @override
  Future<String> updateProfile(UpdateProfileRequest body) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<ActiveProgramResponse> updateProgram(ProgramRequest request) {
    // TODO: implement updateProgram
    throw UnimplementedError();
  }

  @override
  Future<ProgressResponse> updateProgress(UpdateProgressRequest request) async {
    // var jsonText = await rootBundle.loadString('assets/response.json');
    // return Future.value(ProgressResponse.fromMap(jsonDecode(jsonText)));
    throw UnimplementedError();
  }

  @override
  Future<StatementResponse> updateStatement(String id, String date, bool isDone) {
    // TODO: implement updateStatement
    throw UnimplementedError();
  }

  @override
  Future<String> uploadProfileImage(String imagePath) {
    // TODO: implement uploadProfileImage
    throw UnimplementedError();
  }

  @override
  Future<BreathPracticeResponse> updateBreathPractice(UpdateBreathPracticeRequest request) {
    // TODO: implement updateBreathPractice
    throw UnimplementedError();
  }

  // @override
  // Future<WorkoutResponse> filterWorkouts(String request) {
  //   // TODO: implement filterWorkouts
  //   throw UnimplementedError();
  // }

  @override
  FutureOr<void> assignFCMToken(AssignFCMTokenRequest assignFCMTokenRequest) {
    // TODO: implement assignFCMToken
    throw UnimplementedError();
  }

  @override
  Future<void> unAssignFCMToken(UnAssignFCMTokenRequest unAssignFCMTokenRequest) {
    // TODO: implement unAssignFCMToken
    throw UnimplementedError();
  }

  @override
  Future<void> reassignFCMToken(ReAssignFCMTokenRequest reassignFCMTokenRequest) {
    // TODO: implement reassignFCMToken
    throw UnimplementedError();
  }

  @override
  Future<PushNotificationsSettingsResponse> getPushNotificationsConfig(
      PushNotificationsConfigRequest pushNotificationsConfigRequest) {
    // TODO: implement getPushNotificationsConfig
    throw UnimplementedError();
  }

  @override
  Future<PushNotificationsSettingsResponse> setupPushNotificationsConfig(
      PushNotificationsSettingsRequest pushNotificationsSettingsRequest) {
    // TODO: implement setupPushNotificationsConfig
    throw UnimplementedError();
  }

  @override
  Future<WorkoutCollectionResponse> fetchWODCollectionPriority() {
    throw UnimplementedError();
  }

  @override
  Future<FeedProgramItemResponse> getBestMatchProgram(int weeksCount, String level, List<String> equipment) {
    // TODO: implement getBestMatchProgram
    throw UnimplementedError();
  }

  @override
  Future<void> addOnboardingInformation(OnboardingInfoDto payload) {
    // TODO: implement addOnboardingInformation
    throw UnimplementedError();
  }

  @override
  Future<MoodTrackingProgressResponse> getMoodTrackingProgress(String date) {
    // TODO: implement getMoodTrackingProgress
    throw UnimplementedError();
  }
}
