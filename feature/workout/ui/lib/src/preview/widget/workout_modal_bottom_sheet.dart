import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/model/workout_settings_item.dart';
import 'package:workout_ui/src/preview/widget/workout_bottom_sheet_content_widget.dart';
import 'package:workout_ui/src/preview/widget/workout_settings_widget.dart';

Future workoutModalBottomSheet({
  required BuildContext context,
  required String title,
  required String textActionButton,
  required List<WorkoutSettingsItem> settings,
  required WorkoutSettingsMode mode,
  radius = const Radius.circular(12.0),
}) async =>
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: AppColorScheme.colorBlack2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: radius,
        topLeft: radius,
      ),
    ),
    builder: (BuildContext context) {
      return WorkoutBottomSheetContentWidget(
        title: title,
        textActionButton: textActionButton,
        settings: settings,
        mode: mode,
      );
    }
  );