import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_use_case/use_case.dart';

class ExercisesHeaderItemWidget extends StatelessWidget {
  const ExercisesHeaderItemWidget({
    Key? key,
    required this.exercises,
    required this.rounds,
    required this.name,
    required this.type,
  }) : super(key: key);
  final int exercises;
  final int rounds;
  final WorkoutStage name;
  final WorkoutStageType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getTitle(name, WorkoutLocalizations.of(context)),
            style: title20,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            _getSubTitle(context, name, type, rounds, exercises),
            style: textRegular14.copyWith(color: AppColorScheme.colorBlack8),
          ),
        ],
      ),
    );
  }
}

String _getSubTitle(BuildContext context, WorkoutStage name,
  WorkoutStageType type, int rounds, int exercises) {
  final wodType = name == WorkoutStage.COOLDOWN || name == WorkoutStage.WARMUP ?
    '' : '${fromWorkoutStageTypeEnumToString(type, forUI: true).replaceAll("_", " ")} • ';

  return wodType + (rounds==1 ? '$rounds ${WorkoutLocalizations.of(context).workout_summary_round} ' : '$rounds ${WorkoutLocalizations.of(context).workout_summary_rounds} ')
      + '• $exercises ${WorkoutLocalizations.of(context).workout_summary_exercises}';
}

String _getTitle(WorkoutStage status, WorkoutLocalizations L) {
  if (status == WorkoutStage.WARMUP) {
    return L.exercise_category_title_warm_up;
  } else if (status == WorkoutStage.SKILL) {
    return L.exercise_category_title_skill;
  } else if (status == WorkoutStage.WOD) {
    return L.exercise_category_title_wod;
  }
  return L.exercise_category_title_cooldown;
}
