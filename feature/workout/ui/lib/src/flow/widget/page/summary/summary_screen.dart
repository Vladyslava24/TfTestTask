import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_ui/src/flow/widget/page/summary/summary_page_list_item/exercises_header_item_wdiget.dart';
import 'package:workout_ui/src/flow/widget/page/summary/summary_page_list_item/exercises_item_widget.dart';
import 'package:workout_ui/src/flow/widget/page/summary/summary_page_list_item/header_item_widget.dart';
import 'package:workout_ui/src/flow/widget/page/summary/summary_page_list_item/time_score_item_widget.dart';
import 'package:workout_ui/src/flow/widget/page/summary/summary_page_list_item/workout_result_item_widget.dart';
import 'package:workout_ui/src/model/summary_model.dart';

class SummaryScreen extends StatefulWidget {
  final SummaryModel model;
  final VoidCallback onFinish;
  final VoidCallback? onBackPressed;

  const SummaryScreen({
    required this.model,
    required this.onFinish,
    required this.onBackPressed,
    Key? key,
  }) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColorScheme.colorBlack,
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.model.listItems.length,
              itemBuilder: (context, index) {
                final item = widget.model.listItems[index];
                if (item is HeaderItem) {
                  return HeaderItemWidget(
                    image: item.image,
                    onBackArrowPressed: widget.onBackPressed,
                    workoutName: item.workoutName,
                  );
                }
                if (item is TimeScoreItem) {
                  return TimeScoreItemWidget(
                    time: item.time,
                    stageType: item.stageType,
                    rounds: item.rounds,
                  );
                }
                if (item is WorkoutResultItem) {
                  return WorkoutResultItemWidget(
                    duration: item.duration,
                    calories: item.calories,
                    exercises: item.exercises,
                  );
                }
                if (item is ExercisesHeaderItem) {
                  return ExercisesHeaderItemWidget(
                    exercises: item.exercises,
                    name: item.name,
                    rounds: item.rounds,
                    type: item.type,
                  );
                }
                if (item is ExercisesItem) {
                  return ExercisesItemWidget(
                    image: item.image,
                    name: item.name,
                    duration: item.duration,
                  );
                }
                if (item is BottomPaddingItem) {
                  return const SizedBox(
                    height: 80,
                  );
                }
                return Container();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BaseElevatedButton(
              text: widget.model.workoutSummaryPayload != null
                  ? WorkoutLocalizations.of(context).workout_summary_share
                  : WorkoutLocalizations.of(context).workout_summary_finish,
              onPressed: () {
                widget.onFinish();
              },
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  _buildExerciseResult(String exerciseName, int duration) {
    return Row(
      children: [
        Text(
          duration.toString(),
          style: title20.copyWith(
            color: AppColorScheme.colorPrimaryWhite,
          ),
        ),
        Container(height: 4),
        Text(
          exerciseName,
          style: textRegular12.copyWith(
            color: AppColorScheme.colorPrimaryWhite,
          ),
        ),
      ],
    );
  }
}
