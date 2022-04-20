// import 'package:flutter/foundation.dart';
// import 'package:totalfit/exception/tf/tf_exception.dart';
//
// class StorageException implements TfException {
//   final ErrorCode errorCode;
//   final String errorMessage;
//
//   StorageException({this.errorMessage, @required this.errorCode});
//
//   @override
//   String toString() {
//     switch (errorCode) {
//       case ErrorCode.ERROR_SAVE_PROFILE_IMAGE:
//         return "Failed to save profile image";
//       case ErrorCode.ERROR_NO_AUTHORIZED_USER:
//         return "No Authorized User";
//       case ErrorCode.ERROR_ILLEGAL_AUTHORIZED_USER_NUMBER:
//         return "It is forbidden to have more than one authorized user";
//       case ErrorCode.ERROR_EMAIL_DUPLICATION:
//         return "It is forbidden to use same email for different users";
//       case ErrorCode.ERROR_WORKOUT_SAVE:
//         return "Failed to save workouts";
//       case ErrorCode.ERROR_WORKOUT_UPDATE:
//         return "Failed to update workouts";
//       case ErrorCode.ERROR_WORKOUT_FETCH:
//         return "Failed to fetch workouts";
//       default:
//         return errorMessage;
//     }
//   }
// }
//
// enum ErrorCode {
//   ERROR_SAVE_PROFILE_IMAGE,
//   ERROR_NO_AUTHORIZED_USER,
//   ERROR_ILLEGAL_AUTHORIZED_USER_NUMBER,
//   ERROR_EMAIL_DUPLICATION,
//   ERROR_WORKOUT_SAVE,
//   ERROR_WORKOUT_UPDATE,
//   ERROR_WORKOUT_FETCH
// }
