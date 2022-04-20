import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';

enum Goal { Weight, Muscle, Shape, Training }

Goal goalFromBackendKey(String key) {
  if (key == 'LOSE_WEIGHT') {
    return Goal.Weight;
  } else if (key == 'BUILD_MUSCLE') {
    return Goal.Muscle;
  } else if (key == 'STAY_IN_SHAPE') {
    return Goal.Shape;
  } else if (key == 'TRAINING_IN_GYM') {
    return Goal.Training;
  }
  return null;
}

extension GoalX on Goal {
  String toBackendKey() {
    switch (this) {
      case Goal.Weight:
        return 'LOSE_WEIGHT';
      case Goal.Muscle:
        return 'BUILD_MUSCLE';
      case Goal.Shape:
        return 'STAY_IN_SHAPE';
      case Goal.Training:
        return 'TRAINING_IN_GYM';
      default:
        return null;
    }
  }

  String getTitle(BuildContext context) {
    switch (this) {
      case Goal.Weight:
        return S.of(context).goal_weight_title;
      case Goal.Muscle:
        return S.of(context).goal_muscle_title;
      case Goal.Shape:
        return S.of(context).goal_shape_title;
      case Goal.Training:
        return S.of(context).goal_training_title;
      default:
        return "";
    }
  }

  String getIcon() {
    switch (this) {
      case Goal.Weight:
        return '💦';
      case Goal.Muscle:
        return '💪';
      case Goal.Shape:
        return '🏃';
      case Goal.Training:
        return '🏋️‍♂️';
      default:
        return "";
    }
  }
}
