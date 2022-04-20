import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_ui/src/model/workout_status.dart';
import 'package:workout_ui/src/preview/list_item/list_items.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:workout_use_case/src/model/workout_stages.dart';

List<dynamic> buildWorkoutPreviewListItems(WorkoutModel workout,
    WorkoutStatus status, bool isLocked, WorkoutLocalizations localization) {
  final header = HeaderItem(
    uid: workout.id,
    title: workout.theme,
    image: workout.image,
    workoutStatus: status,
  );

  final info = InfoItem(
    level: workout.difficultyLevel,
    equipment: workout.equipment,
    duration: workout.getWorkoutTime,
  );

  ExerciseItem? exerciseCategory01 =
      _getExerciseCategoryItem(workout, WorkoutStatus.warmup, localization);
  ExerciseItem? exerciseCategory02 =
      _getExerciseCategoryItem(workout, WorkoutStatus.skill, localization);
  ExerciseItem? exerciseCategory03 =
      _getExerciseCategoryItem(workout, WorkoutStatus.wod, localization);
  ExerciseItem? exerciseCategory04 =
      _getExerciseCategoryItem(workout, WorkoutStatus.cooldown, localization);

  final items = [
    header,
    info,
    exerciseCategory01,
    exerciseCategory02,
    exerciseCategory03,
    exerciseCategory04,
    SpaceWorkoutListItem(),
  ];

  return items;
}

ExerciseItem? _getExerciseCategoryItem(WorkoutModel workout,
    WorkoutStatus status, WorkoutLocalizations localization) {
  ExerciseItem? exerciseCategory;
  final warmupExercises = _getStageExercises(workout, status);
  if (warmupExercises.isNotEmpty) {
    exerciseCategory = ExerciseItem(
        title: _getTitle(status, localization),
        subTitle: _getSubTitle(workout, status, localization),
        workout: workout,
        exercises: _getStageExercises(workout, status),
        isCompleted: status >= status,
        workoutStatus: status);
  }

  return exerciseCategory;
}

List<ExerciseModel> _getStageExercises(
    WorkoutModel workout, WorkoutStatus status) {
  try {
    return workout.stages
        .firstWhere((element) => fromWorkoutStageEnumToString(element.stageName).toUpperCase() == status.toString().toUpperCase())
        .exercises;
  } catch (e) {
    return [];
  }
}

String _getTitle(WorkoutStatus status, WorkoutLocalizations L) {
  if (status == WorkoutStatus.warmup) {
    return L.exercise_category_title_warm_up;
  } else if (status == WorkoutStatus.skill) {
    return L.exercise_category_title_skill;
  } else if (status == WorkoutStatus.wod) {
    return L.exercise_category_title_wod;
  }
  return L.exercise_category_title_cooldown;
}

String? _getSubTitle(WorkoutModel workout, WorkoutStatus status,
    WorkoutLocalizations L) {
  try {
    final stage = workout.stages.firstWhere(
        (element) => WorkoutStatus.fromString(fromWorkoutStageEnumToString(element.stageName).toUpperCase()) == status);
    if (status == WorkoutStatus.warmup) {
      if (stage.stageOption.rests.isNotEmpty) {
        return '${stage.stageOption.rests.length} ${stage.stageOption.rests.length>1 ? L.all_rounds : L.all_round}'
            ' • ${stage.exercises.length} ${stage.exercises.length>1 ? L.all_exercises : L.all_exercise}';
      } else {
        return '${stage.exercises.length} ${stage.exercises.length>1 ? L.all_exercises : L.all_exercise}';
      }
    } else if (status == WorkoutStatus.wod) {
      return '${fromWorkoutStageTypeEnumToString(stage.stageType, forUI: true).replaceAll('_', ' ')} • '
          '${stage.stageOption.metricQuantity} ${stage.stageOption.metricType.toLowerCase()=="rounds" ? stage.stageOption.metricQuantity>1 ? L.all_rounds : L.all_round : "min"} • '
          '${stage.exercises.length} ${stage.exercises.length>1 ? L.all_exercises : L.all_exercise}';
    }
    return '${stage.exercises.length} ${stage.exercises.length>1 ? L.all_exercises : L.all_exercise}';
  } catch (_) {
    return null;
  }
}
