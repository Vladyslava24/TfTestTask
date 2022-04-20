import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';

class WorkoutResultItemWidget extends StatelessWidget {
  const WorkoutResultItemWidget(
      {Key? key,
      required this.calories,
      required this.duration,
      required this.exercises})
      : super(key: key);
  final String calories;
  final String duration;
  final int exercises;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            WorkoutLocalizations.of(context)
                .workout_summary_workout_result_title,
            style: textRegular16.copyWith(color: AppColorScheme.colorBlack8),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(calories, style: title30),
                  Text(
                    WorkoutLocalizations.of(context).workout_summary_calories,
                    style: textRegular16.copyWith(
                      color: AppColorScheme.colorBlack8
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    duration,
                    style: title30,
                  ),
                  Text(
                    WorkoutLocalizations.of(context).workout_summary_duration,
                    style: textRegular16.copyWith(
                        color: AppColorScheme.colorBlack8),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$exercises',
                    style: title30,
                  ),
                  Text(
                    WorkoutLocalizations.of(context).workout_summary_exercises,
                    style: textRegular16.copyWith(
                        color: AppColorScheme.colorBlack8),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
