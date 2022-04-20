import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/model/choose_program/program_workout_item.dart';
import 'package:ui_kit/ui_kit.dart';

import 'done_indicator.dart';

class ScheduledWorkoutItemWidget extends StatelessWidget {
  final ScheduledWorkoutItem item;
  final Function(ScheduledWorkoutItem) onItemClick;

  ScheduledWorkoutItemWidget({@required this.item, @required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 6,
        bottom: 6,
        left: 16,
        right: 16,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(cardBorderRadius)),
        child: GestureDetector(
          onTap: () {
            onItemClick(item);
          },
          child: Container(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 12.0,
              right: 12.0,
            ),
            color: AppColorScheme.colorBlack2,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildDate(),
                const SizedBox(width: 12),
                Container(
                  width: 1,
                  height: 50,
                  color: AppColorScheme.colorBlack4,
                ),
                const SizedBox(width: 12),
                _buildTexts(),
                const Expanded(
                  child: const SizedBox(width: 8),
                ),
                item.inPastDays || item.workoutProgress.finished
                    ? DoneIndicator(
                        isCompleted: item.workoutProgress.workoutPhase ==
                            WorkoutPhase.FINISHED)
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDate() => Container(
        width: 30,
        child: Column(children: <Widget>[
          Text(
            item.day,
            style: textRegular12.copyWith(
              color: item.isToday
                  ? AppColorScheme.colorYellow
                  : AppColorScheme.colorBlack7,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.dayNumber,
            style: textMedium12.copyWith(
              color: item.isToday
                  ? AppColorScheme.colorYellow
                  : AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ]),
      );

  Widget _buildTexts() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.workoutProgress.workout.theme,
            style: title16.copyWith(
              color: item.inPastDays
                  ? AppColorScheme.colorBlack7
                  : AppColorScheme.colorPrimaryWhite,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.workoutProgress.workout.getWorkoutTime,
            style: textRegular14.copyWith(
              color: item.inPastDays
                  ? AppColorScheme.colorBlack7
                  : AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ],
      );
}
