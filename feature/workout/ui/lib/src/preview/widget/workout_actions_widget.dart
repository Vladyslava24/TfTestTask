import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';

class WorkoutFixedActionsWidget extends StatelessWidget {
  final Function onAudioSettingsCall;
  final Function onWorkoutSettingsCall;

  const WorkoutFixedActionsWidget({
    required this.onAudioSettingsCall,
    required this.onWorkoutSettingsCall,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // IconMusicCircleWidget(
        //   margin: const EdgeInsets.only(right: 12.0),
        //   action: onAudioSettingsCall
        // ),
        IconSettingsCircleWidget(
          margin: const EdgeInsets.only(right: 16.0),
          action: onWorkoutSettingsCall
        ),
      ],
    );
  }
}
