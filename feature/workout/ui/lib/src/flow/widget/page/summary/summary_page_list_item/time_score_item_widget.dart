import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_use_case/use_case.dart';

class TimeScoreItemWidget extends StatelessWidget {
  const TimeScoreItemWidget({Key? key, required this.time, required this.stageType, required this.rounds})
      : super(key: key);
  final String time;
  final String rounds;
  final WorkoutStageType stageType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
             stageType == WorkoutStageType.FOR_TIME ?
             WorkoutLocalizations.of(context).workout_summary_time_score_title
             : WorkoutLocalizations.of(context).workout_summary_rounds,
            style: textRegular14.copyWith(color: AppColorScheme.colorBlack8),
          ),
          Text(
            stageType == WorkoutStageType.FOR_TIME ? time : rounds,
            style: title64,
          ),
        ],
      ),
    );
  }
}
