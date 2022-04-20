import 'package:core/generated/l10n.dart';

enum ErrorCode {
  ERROR_IDLE,
  ERROR_PARSE_RESPONSE,
  ERROR_SAVE_PROFILE_IMAGE,
  ERROR_SAVE_PROFILE,
  ERROR_FETCH_ACTIVE_PROGRAM,
  ERROR_AUTH_CONFLICT,
  ERROR_AUTH_TOKEN_EXPIRED,
  ERROR_AUTH_FAILED,
  ERROR_AUTH_SOCIAL_FAILED,
  ERROR_AUTH_CANCELED,
  ERROR_NETWORK,
  ERROR_DB,
  ERROR_NO_AUTHORIZED_USER,
  ERROR_ILLEGAL_AUTHORIZED_USER_NUMBER,
  ERROR_LOAD_WORKOUT_PROGRESS,
  ERROR_DELETE_WORKOUT_PROGRESS,
  ERROR_BUILD_PROGRAM_UI_ITEMS,
  ERROR_FINISH_PROGRAM,
  ERROR_INTERRUPT_PROGRAM,
  ERROR_PROGRAM_NOT_RUNNING,
  ERROR_START_PROGRAM,
  ERROR_UPDATE_PROGRAM,
  ERROR_LOAD_PROGRAM,
  ERROR_LOAD_WORKOUT_SUMMARY,
  ERROR_PURCHASE,
  ERROR_VIDEO_PLAYER,
  ERROR_PUSH_NOTIFICATIONS_CONFIG,
  ERROR_LOAD_EXPLORE,
  ERROR_TIMEOUT,
  ERROR_UNKNOWN,
}

extension StringExtension on ErrorCode {
  String getStringMessage(context) {
    switch (this) {
      case ErrorCode.ERROR_SAVE_PROFILE_IMAGE:
        return S.of(context).code_error_save_profile_image;
      case ErrorCode.ERROR_SAVE_PROFILE:
        return S.of(context).code_error_save_profile;
      case ErrorCode.ERROR_FETCH_ACTIVE_PROGRAM:
        return S.of(context).code_error_fetch_active_program;
      case ErrorCode.ERROR_PARSE_RESPONSE:
        return S.of(context).code_error_parse_response;
      case ErrorCode.ERROR_AUTH_CONFLICT:
        return S.of(context).code_error_auth_conflict;
      case ErrorCode.ERROR_AUTH_TOKEN_EXPIRED:
        return S.of(context).code_error_auth_token_expired;
      case ErrorCode.ERROR_AUTH_FAILED:
        return S.of(context).code_error_auth_failed;
      case ErrorCode.ERROR_AUTH_CANCELED:
        return S.of(context).code_error_auth_canceled;
      case ErrorCode.ERROR_AUTH_SOCIAL_FAILED:
        return S.of(context).code_error_auth_social_failed;
      case ErrorCode.ERROR_NETWORK:
        return S.of(context).code_error_network;
      case ErrorCode.ERROR_DB:
        return S.of(context).code_error_db;
      case ErrorCode.ERROR_NO_AUTHORIZED_USER:
        return S.of(context).code_error_no_authorized_user;
      case ErrorCode.ERROR_ILLEGAL_AUTHORIZED_USER_NUMBER:
        return S.of(context).code_error_illegal_authorized_user_number;
      case ErrorCode.ERROR_LOAD_WORKOUT_PROGRESS:
        return S.of(context).code_error_load_workout_progress;
      case ErrorCode.ERROR_DELETE_WORKOUT_PROGRESS:
        return S.of(context).code_error_delete_workout_progress;
      case ErrorCode.ERROR_BUILD_PROGRAM_UI_ITEMS:
        return S.of(context).code_error_build_program_ui_items;
      case ErrorCode.ERROR_FINISH_PROGRAM:
        return S.of(context).code_error_finish_program;
      case ErrorCode.ERROR_INTERRUPT_PROGRAM:
        return S.of(context).code_error_interrupt_program;
      case ErrorCode.ERROR_PROGRAM_NOT_RUNNING:
        return S.of(context).code_error_program_not_running;
      case ErrorCode.ERROR_START_PROGRAM:
        return S.of(context).code_error_start_program;
      case ErrorCode.ERROR_UPDATE_PROGRAM:
        return S.of(context).code_error_update_program;
      case ErrorCode.ERROR_LOAD_PROGRAM:
        return S.of(context).code_error_load_program;
      case ErrorCode.ERROR_LOAD_WORKOUT_SUMMARY:
        return S.of(context).code_error_load_workout_summary;
      case ErrorCode.ERROR_PURCHASE:
        return S.of(context).code_error_purchase;
      case ErrorCode.ERROR_VIDEO_PLAYER:
        return S.of(context).code_error_video_player;
      case ErrorCode.ERROR_PUSH_NOTIFICATIONS_CONFIG:
        return S.of(context).code_error_push_notifications_config;
      case ErrorCode.ERROR_LOAD_EXPLORE:
        return S.of(context).code_error_load_explore;
      case ErrorCode.ERROR_TIMEOUT:
        return S.of(context).code_error_timeout;
      default:
        return S.of(context).code_error_unknown;
    }
  }

  String getUnlocalizedStringMessage() {
    switch (this) {
      case ErrorCode.ERROR_SAVE_PROFILE_IMAGE:
        return "Failed to save profile image";
      case ErrorCode.ERROR_FETCH_ACTIVE_PROGRAM:
        return "Failed to fetch active program";
      case ErrorCode.ERROR_PARSE_RESPONSE:
        return "Failed to parse response";
      case ErrorCode.ERROR_AUTH_CONFLICT:
        return "User already exists";
      case ErrorCode.ERROR_AUTH_TOKEN_EXPIRED:
        return "Token expired";
      case ErrorCode.ERROR_AUTH_FAILED:
        return "Failed to authorize. Check your credentials";
      case ErrorCode.ERROR_AUTH_CANCELED:
        return "Authorization canceled";
      case ErrorCode.ERROR_NETWORK:
        return "Network error";
      case ErrorCode.ERROR_DB:
        return "Failed to access local database";
      case ErrorCode.ERROR_NO_AUTHORIZED_USER:
        return "No authorized user";
      case ErrorCode.ERROR_ILLEGAL_AUTHORIZED_USER_NUMBER:
        return "ILLEGAL AUTHORIZED USER NUMBER";
      case ErrorCode.ERROR_LOAD_WORKOUT_PROGRESS:
        return "Failed to load Workout Progress";
      case ErrorCode.ERROR_DELETE_WORKOUT_PROGRESS:
        return "Failed to delete Workout Progress";
      case ErrorCode.ERROR_BUILD_PROGRAM_UI_ITEMS:
        return "Failed to build Program UI items";
      case ErrorCode.ERROR_FINISH_PROGRAM:
        return "Failed to finish Program";
      case ErrorCode.ERROR_INTERRUPT_PROGRAM:
        return "Failed to interrupt Program";
      case ErrorCode.ERROR_PROGRAM_NOT_RUNNING:
        return "Program not running";
      case ErrorCode.ERROR_START_PROGRAM:
        return "Failed to start Program";
      case ErrorCode.ERROR_UPDATE_PROGRAM:
        return "Failed to update Program";
      case ErrorCode.ERROR_LOAD_PROGRAM:
        return "Failed to load Program";
      case ErrorCode.ERROR_LOAD_WORKOUT_SUMMARY:
        return "Failed to load Workout Summary";
      case ErrorCode.ERROR_PURCHASE:
        return "Failed to load make a Purchase";
      case ErrorCode.ERROR_VIDEO_PLAYER:
        return "Failed to use a video player";
      default:
        return 'Error message not defined';
    }
  }
}
