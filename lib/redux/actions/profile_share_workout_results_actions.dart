import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/profile_share_workout_results_bundle.dart';
import 'package:totalfit/model/workout_preview_list_items.dart';

import '../../ui/widgets/grid_items.dart';

class SetShareScreenStateAction {
  final List<dynamic> listItems;
  final ExerciseCategoryItem wodItem;
  final int workoutDuration;
  final String wodType;
  final String workoutName;
  final int totalExercises;
  final int wodResult;
  final int roundCount;
  final int workoutId;
  final ImageItem selectedImageItem;

  SetShareScreenStateAction({
    this.listItems,
    this.wodItem,
    this.workoutDuration,
    this.wodType,
    this.workoutName,
    this.totalExercises,
    this.wodResult,
    this.roundCount,
    this.workoutId,
    this.selectedImageItem,
  });
}

class BuildShareScreenStateAction {
  final ProfileShareWorkoutResultsScreenBundle bundle;

  BuildShareScreenStateAction({@required this.bundle});
}

class NavigateToProfileShareScreenAction {
  final ProfileShareWorkoutResultsScreenBundle bundle;

  NavigateToProfileShareScreenAction({@required this.bundle});
}

class OnProfileShareErrorAction {
  final TfException error;

  OnProfileShareErrorAction({@required this.error});
}

class ClearProfileShareErrorAction {}

class OnImageItemSelectedAction {
  final ImageItem selectedImage;

  OnImageItemSelectedAction({@required this.selectedImage});
}
