import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/model/workout_settings_item.dart';
import 'package:workout_ui/src/preview/widget/workout_settings_widget.dart';

class WorkoutBottomSheetContentWidget extends StatefulWidget {
  final String title;
  final String textActionButton;
  final List<WorkoutSettingsItem> settings;
  final WorkoutSettingsMode mode;

  const WorkoutBottomSheetContentWidget({
    required this.title,
    required this.textActionButton,
    required this.settings,
    required this.mode,
    Key? key
  }) : super(key: key);

  @override
  _WorkoutBottomSheetContentWidgetState createState() => _WorkoutBottomSheetContentWidgetState();
}

class _WorkoutBottomSheetContentWidgetState extends State<WorkoutBottomSheetContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: title20.copyWith(
                      color: AppColorScheme.colorPrimaryWhite
                    )
                  ),
                ),
                IconCloseCircleWidget(
                  margin: EdgeInsets.zero,
                  action: () => Navigator.of(context).pop()
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: WorkoutSettingsWidget(
              mode: widget.mode,
              settings: widget.settings,
            ),
          ),
          BaseElevatedButton(
            text: widget.textActionButton,
            onPressed: () => Navigator.of(context).pop(widget.settings)
          ),
        ],
      ),
    );
  }
}
