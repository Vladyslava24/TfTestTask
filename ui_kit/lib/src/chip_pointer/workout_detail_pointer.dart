import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'chip_pointer.dart';

enum WorkoutDetail {
  duration,
  level,
}

class WorkoutChipData extends ChipData {
  final WorkoutDetail workoutDetail;

  WorkoutChipData(this.workoutDetail, String name)
      : super(
            name: name,
            selectedIcon: workoutDetail.getSelectedIcon(),
            unselectedIcon: workoutDetail.getUnselectedIcon());
}

extension EWorkoutDetailX on WorkoutDetail {
  String getName(BuildContext context) {
    switch (this) {
      case WorkoutDetail.duration:
        return S.of(context).workout_chip_level;
      case WorkoutDetail.level:
        return S.of(context).equipment_item_kettlebell;
      default:
        return "";
    }
  }

  String getUnselectedIcon() {
    switch (this) {
      case WorkoutDetail.duration:
        return workoutDuration;
      case WorkoutDetail.level:
        return workoutLevel;
      default:
        return "";
    }
  }

  String getSelectedIcon() {
    switch (this) {
      case WorkoutDetail.duration:
        return workoutDuration;
      case WorkoutDetail.level:
        return workoutLevel;
      default:
        return "";
    }
  }

  String getServerName() {
    switch (this) {
      case WorkoutDetail.duration:
        return 'No equipment';
      case WorkoutDetail.level:
        return 'Kettlebell';
      default:
        return "";
    }
  }
}
