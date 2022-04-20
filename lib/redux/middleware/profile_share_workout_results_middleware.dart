import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/model/workout_preview_list_items.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/redux/actions/profile_share_workout_results_actions.dart';
import 'package:totalfit/ui/widgets/grid_items.dart';

List<Middleware<AppState>> profileShareResultsMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  return [
    TypedMiddleware<AppState, BuildShareScreenStateAction>(_buildShareScreenStateAction(logger)),
  ];
}

Middleware<AppState> _buildShareScreenStateAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("shareResultsMiddleware _buildListItemsMiddleware");

    var bundle = (action as BuildShareScreenStateAction).bundle;

    final itemList = []
      ..add(HeaderItem())
      ..add(GalleryPickerItem())
      ..addAll(_imageList);

    final workout = bundle.workout;

    final wodItem = ExerciseCategoryItem(
        isCompleted: true, dedicatedStage: WorkoutPhase.WOD, workout: workout, exercises: []);//workout.wod);

    WorkoutProgressDto progress = bundle.progress;

    int totalExercises = progress.warmupExerciseDurations.length +
        progress.skillExerciseDurations.length +
        progress.wodExerciseDurations.length +
        progress.cooldownExerciseDurations.length;

    int wodResult = 0;
    progress.wodExerciseDurations.forEach((e) {
      wodResult += e.exerciseDuration;
    });
    int workoutDuration = progress.workoutDuration;
    int roundCount = progress.roundCount ?? -111;

    String wodType = '';//bundle.workout.wodType;
    String workoutName = bundle.workout.theme;

    next(SetShareScreenStateAction(
      listItems: itemList,
      wodItem: wodItem,
      wodType: wodType,
      workoutName: workoutName,
      totalExercises: totalExercises,
      wodResult: wodResult,
      roundCount: roundCount,
      workoutDuration: workoutDuration,
      workoutId: bundle.workout.id,
      selectedImageItem: _imageList[9],
    ));
    next(action);
  };
}


const DEFAULT_SHARE_IMAGE = "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing09.jpg";

final _imageList = [
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing01.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing02.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing03.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing04.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing05.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing06.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing07.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing08.jpg",
  DEFAULT_SHARE_IMAGE,
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing10.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing11.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing12.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing13.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing14.jpg",
  "https://totalfit-app-images.s3-eu-west-1.amazonaws.com/Sharing15.jpg"
].map((imageUrl) => ImageItem(url: imageUrl)).toList();
