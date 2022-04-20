import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/model/workout_settings_item.dart';

class WorkoutSettingsWidget extends StatefulWidget {
  final List<WorkoutSettingsItem> settings;
  final WorkoutSettingsMode mode;

  const WorkoutSettingsWidget({
    required this.settings,
    this.mode = WorkoutSettingsMode.unknown,
    Key? key
  }) : super(key: key);

  @override
  _WorkoutSettingsWidgetState createState() =>
    _WorkoutSettingsWidgetState();
}

class _WorkoutSettingsWidgetState extends State<WorkoutSettingsWidget> {

  int _selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    _selectedRadio = widget.settings.indexWhere((e) => e.value == true);
  }

  @override
  Widget build(BuildContext context) {
    return widget.mode == WorkoutSettingsMode.unknown ?
      const SizedBox() :
      Column(
        children: List<Widget>.of(widget.settings.asMap().entries.map((e) {
          final index = e.key;
          final entry = e.value;
          return  widget.mode == WorkoutSettingsMode.audio ?
            BaseRadioWidget(
              label: entry.label,
              value: index,
              groupValue: _selectedRadio,
              margin: const EdgeInsets.only(bottom: 20.0),
              onChange: (value) {
                setState(() {
                  _selectedRadio = value;
                });
                widget.settings.map((e) => e.value = false).toList();
                widget.settings[index].value = true;
              },
            ) : BaseSwitchWidget(
              label: entry.label,
              value: entry.value,
              onChange: (value) => widget.settings[index].value = value,
              margin: const EdgeInsets.only(bottom: 20.0),
            );
          }
        ),
      ),
    );
  }
}

enum WorkoutSettingsMode { audio, workout, unknown }