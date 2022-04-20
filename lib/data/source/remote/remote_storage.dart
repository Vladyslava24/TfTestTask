import 'dart:async';

import 'package:core/core.dart';
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
import 'package:totalfit/data/dto/response/mood_tracking_progress_response.dart';
import 'package:totalfit/data/dto/response/parse_url_response.dart';
import 'package:totalfit/data/dto/response/progress_response.dart';
import 'package:totalfit/data/dto/response/push_notifications_settings_response.dart';
import 'package:totalfit/data/dto/response/statement_response.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';
import 'package:totalfit/data/dto/response/profile_completed_workouts_response.dart';
import 'package:totalfit/data/dto/response/profile_statistics_response.dart';
import 'package:totalfit/data/dto/response/current_program_limited_response.dart';
import 'package:totalfit/data/dto/response/feed_programs_response.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:totalfit/data/dto/request/program_request.dart';
import 'package:totalfit/data/dto/response/active_program_response.dart';


abstract class RemoteStorage {
  Future<User> signUp(SignUpRequest request);

  Future<User> logIn(LogInRequest request);

  Future<void> resetPassword(String email);

  Future<User> signInWithSocial(SignInWithSocialRequest request);

  Future<void> passwordRecovery(PasswordRecoveryRequest request);

  Future<List<Country>> fetchCountryList(String prefix, String locale);

  Future<HabitListResponse> getHabitList();

  Future<Habit> getRecommendedHabit(String date);

  Future<HabitDto> selectHabit(String habitId, String date);

  Future<HabitCompletionToggleResponse> toggleHabitCompletion(String id, bool completed, String date);

  Future<void> unSelectHabit(String habitModelId, String date);

  Future<Habit> completeHabit(String id, bool selected);

  Future<ProgressResponse> getProgress(String date);

  Future<MoodTrackingProgressResponse> getMoodTrackingProgress(String date);

  Future<ProgressResponse> updateProgress(UpdateProgressRequest request);

  Future<BreathPracticeResponse> updateBreathPractice(UpdateBreathPracticeRequest request);

  Future<StatementResponse> updateStatement(String id, String date, bool isDone);

  Future updateProfile(UpdateProfileRequest body);

  Future<ProfileStatisticsResponse> getProfileStatistics();

  Future<ProfileCompletedWorkoutsResponse> getProfileCompletedWorkouts(int offset, int pageSize);

  Future deleteWorkoutProgress(String id);

  Future<String> uploadProfileImage(String imagePath);

  Future<ParseUrlResponse> parseUrl(String url);

  Future<ExerciseListResponse> getExerciseList();

  Future<FeedProgramsResponse> getFeedPrograms(int offset, int pageSize);

  Future<FeedProgramItemResponse> getBestMatchProgram(int weeksCount, String level, List<String> equipment);

  Future<void> addOnboardingInformation(OnboardingInfoDto payload);

  Future<CurrentProgramLimitedResponse> getCurrentLimitedProgram(String date);

  Future<ActiveProgramResponse> getCurrentFullProgram(String date);

  Future<FinishProgramResponse> finishProgram(int id);

  Future<int> interruptProgram();

  Future<ActiveProgramResponse> startProgram(ProgramRequest request);

  Future<ActiveProgramResponse> updateProgram(ProgramRequest request);

  FutureOr<void> assignFCMToken(AssignFCMTokenRequest assignFCMTokenRequest);

  Future<void> reassignFCMToken(ReAssignFCMTokenRequest reassignFCMTokenRequest);

  Future<void> unAssignFCMToken(UnAssignFCMTokenRequest unAssignFCMTokenRequest);

  Future<PushNotificationsSettingsResponse> getPushNotificationsConfig(
      PushNotificationsConfigRequest pushNotificationsConfigRequest);

  Future<PushNotificationsSettingsResponse> setupPushNotificationsConfig(
      PushNotificationsSettingsRequest pushNotificationsSettingsRequest);
}
