import 'package:workout_api/api.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/foundation.dart';
import 'package:totalfit/data/dto/request/update_progress_request.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/profile_workout_summary_bundle.dart';
import 'package:workout_use_case/use_case.dart';

class OnProfileWorkoutSummaryErrorAction {
  final TfException error;

  OnProfileWorkoutSummaryErrorAction({@required this.error});
}

class BuildWorkoutSummaryScreenStateAction {
  final WorkoutSummaryBundle bundle;

  BuildWorkoutSummaryScreenStateAction({@required this.bundle});
}

class UpdateWorkoutSummaryProgressAction {
  final WorkoutSummaryBundle bundle;

  UpdateWorkoutSummaryProgressAction({@required this.bundle});
}

class SetWorkoutSummaryStateAction {
  final List<dynamic> listItems;
  final bool isWorkoutCompleted;
  final WorkoutDto workout;
  final WorkoutProgressDto progress;

  SetWorkoutSummaryStateAction({
    this.listItems,
    this.isWorkoutCompleted,
    this.workout,
    this.progress,
  });
}

class UpdateProgressForProfileWorkoutSummaryAction {
  final UpdateProgressRequest request;
  final WorkoutSummaryBundle bundle;

  UpdateProgressForProfileWorkoutSummaryAction({@required this.request, @required this.bundle});
}

class NavigateToWorkoutSummaryPageWithBundleAction {
  final WorkoutSummaryBundle bundle;

  NavigateToWorkoutSummaryPageWithBundleAction({@required this.bundle});
}

class NavigateToWorkoutFlowScreenWithBundleAction {
  final WorkoutSummaryPayload bundle;

  NavigateToWorkoutFlowScreenWithBundleAction({@required this.bundle});
}
