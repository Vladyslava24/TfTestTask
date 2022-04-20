import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/hexagon_state.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/model/profile_workout_summary_bundle.dart';
import 'package:totalfit/model/skill_summary_list_items.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/selectors/progress_selectors.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';
import 'package:totalfit/utils/locales_service.dart';

final LocalesService _localesService = DependencyProvider.get<LocalesService>();

List<Middleware<AppState>> profileWorkoutSummaryMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  return [
    TypedMiddleware<AppState, UpdateProgressForProfileWorkoutSummaryAction>(
        _onUpdateProgressAction(remoteStorage, logger)),
    TypedMiddleware<AppState, BuildWorkoutSummaryScreenStateAction>(_buildWorkoutSummaryScreenStateAction(logger)),
  ];
}

Middleware<AppState> _buildWorkoutSummaryScreenStateAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final bundle = (action as BuildWorkoutSummaryScreenStateAction).bundle;

    final workoutPhase = bundle.workoutPhase;
    if (workoutPhase == WorkoutPhase.COOLDOWN || workoutPhase == WorkoutPhase.FINISHED) {
      _buildWorkoutSummaryState(bundle, store, next, logger);
    }
  };
}

Middleware<AppState> _onUpdateProgressAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onUpdateProgressAction");
    final updateAction = action as UpdateProgressForProfileWorkoutSummaryAction;
    try {
      final response = await remoteStorage.updateProgress(updateAction.request);
      final hs = response.hexagonState;
      final progress = selectProgressFromResponse(response, store.state.workoutState.workout);
      final user = store.state.loginState.user;
      final warmUpExerciseCount = progress.warmupExerciseDurations.length;
      final wodExerciseCount = progress.wodExerciseDurations.length;
      final coolDownExerciseCount = progress.cooldownExerciseDurations.length;
      final skillExerciseCount = progress.skillExerciseDurations.length;
      final totalExercises = warmUpExerciseCount + wodExerciseCount + coolDownExerciseCount + skillExerciseCount;

      final wodRounds = progress.roundCount;
      final wodType = 'wodType';
      final skillImage = 'skill.image';
      final skillName = 'skill.name';

      List<dynamic> items = _buildWorkoutSummaryListItems(hs, progress, user, totalExercises, warmUpExerciseCount,
          wodExerciseCount, coolDownExerciseCount, wodRounds, wodType, skillImage, false, skillName);

      next(SetWorkoutSummaryStateAction(
        listItems: items,
        isWorkoutCompleted: updateAction.bundle.workoutPhase == WorkoutPhase.FINISHED,
        workout: updateAction.bundle.workout,
        progress: updateAction.bundle.progress,
      ));

      //refresh progress ui
      int progressPageIndex = selectProgressPageIndex(store);
      next(BuildProgressListAction(progressResponse: response, progressPageIndex: progressPageIndex));
    } catch (e) {
      print(e);
      next(OnProfileWorkoutSummaryErrorAction(error: e));
      next(
          ErrorReportAction(where: "_onUpdateProgressAction", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

void _buildWorkoutSummaryState(
    WorkoutSummaryBundle bundle, Store<AppState> store, NextDispatcher next, TFLogger logger) async {
  final hs = bundle.hexagonState;
  final progress = bundle.progress;
  final user = store.state.loginState.user;

  final warmUpExerciseCount = progress.warmupExerciseDurations.length;
  final wodExerciseCount = progress.wodExerciseDurations.length;
  final coolDownExerciseCount = progress.cooldownExerciseDurations.length;
  final skillExerciseCount = progress.skillExerciseDurations.length;
  final totalExercises = warmUpExerciseCount + wodExerciseCount + coolDownExerciseCount + skillExerciseCount;
  final wodRounds = progress.roundCount;
  final wodType = 'workout.wodType';
  final skillImage = progress.workout.image;
  final skillName = 'skill.name';

  List<dynamic> items = _buildWorkoutSummaryListItems(
    hs,
    progress,
    user,
    totalExercises,
    warmUpExerciseCount,
    wodExerciseCount,
    coolDownExerciseCount,
    wodRounds,
    wodType,
    skillImage,
    true,
    skillName,
  );

  next(SetWorkoutSummaryStateAction(
    listItems: items,
    isWorkoutCompleted: bundle.workoutPhase == WorkoutPhase.FINISHED,
    workout: bundle.workout,
    progress: progress,
  ));
}

List<dynamic> _buildWorkoutSummaryListItems(
  HexagonState hs,
  WorkoutProgressDto workoutProgress,
  User user,
  int totalExercises,
  int warmUpExerciseCount,
  int wodExerciseCount,
  int coolDownExerciseCount,
  int wodRounds,
  String wodType,
  String skillImage,
  bool canMoveBack,
  String skillName,
) {
  Map<MetaHexSegment, double> rateMap = {
    MetaHexSegment.BODY: hs.body.toDouble(),
    MetaHexSegment.MIND: hs.mind.toDouble(),
    MetaHexSegment.SPIRIT: hs.spirit.toDouble(),
  };

  List<dynamic> items = [];

  final userName = user.firstName;

  final headerItem = PageHeaderWorkoutSummaryListItem(
    title: "${_localesService.locales.well_done}, $userName!",
    subTitle: _localesService.locales.youre_greate_athlete,
    rateMap: rateMap,
    totalExercises: totalExercises,
    workoutDuration: timeFromMilliseconds(workoutProgress.workoutDuration),
    showBackArrow: canMoveBack,
    wodType: wodType,
    roundCount: wodRounds,
    totalPoints: workoutProgress.points,
    finished: workoutProgress.finished,
  );

  items.add(headerItem);
  final warmUpResult = ResultItem(
      title: _localesService.locales.exercise_category_title_warm_up,
      subTitle: "$warmUpExerciseCount ${_localesService.locales.sm_exercise}");

  items.add(warmUpResult);
  final skillResult = SkillItem(imageUrl: skillImage, skillName: skillName);

  items.add(skillResult);
  final rounds = wodRounds == 1
      ? "$wodRounds ${_localesService.locales.round.toUpperCase()}"
      : "$wodRounds ${_localesService.locales.rounds.toUpperCase()}";

  final exercises = wodExerciseCount == 1
      ? "$wodExerciseCount ${_localesService.locales.exercise.toUpperCase()}"
      : "$wodExerciseCount ${_localesService.locales.exercises.toUpperCase()}";
  final wodResult = ResultItem(
      title: _localesService.locales.workout_of_the_day,
      subTitle: "${wodType.replaceAll('_', ' ')} • $rounds • $exercises");
  items.add(wodResult);

  final coolDownResult = ResultItem(
      title: _localesService.locales.exercise_category_title_cooldown,
      subTitle: "$coolDownExerciseCount ${_localesService.locales.sm_exercise}");
  items.add(coolDownResult);
  items.add(ListBottomPaddingItem());

  return items;
}
