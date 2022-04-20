import 'package:core/core.dart';
import 'package:totalfit/data/dto/response/progress_response.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/profile_actions.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/selectors/progress_selectors.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/ui/screen/main/main_screen.dart';
import 'package:workout_data/data.dart';

List<Middleware<AppState>> updateProgressMiddleWare(WorkoutRepository workoutRepository, TFLogger logger){
  final onSubscribeStream = _onSubscribeStream(workoutRepository, logger);

  return [
    TypedMiddleware<AppState, SessionStartAction>(onSubscribeStream),
  ];

}

Middleware<AppState>_onSubscribeStream(WorkoutRepository workoutRepository, TFLogger logger){
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    final stream = workoutRepository.progressUpdateStream();
    stream.listen((rawResponse) async{
      try {
        ProgressResponse progressResponse = ProgressResponse.fromMap(rawResponse);
        //refresh progress ui
        int progressPageIndex = selectProgressPageIndex(store);
        next(BuildProgressListAction(progressResponse: progressResponse, progressPageIndex: progressPageIndex));
        next(MarkProfileRequireUpdate(true));
      } catch (e) {
        logger.logError("_onSubscribeStream in updateProgressMiddleWare error : ${e.toString()}");
        next(ErrorReportAction(where: "_onUpdateProgressAction", errorMessage: e.toString(), trigger: action.runtimeType));
      }
    });

    final streamWorkoutFinish = workoutRepository.workoutFinishStream().stream;
    streamWorkoutFinish.listen((event) async{
      store.dispatch(UpdateSelectedTab(tab: BottomTab.Progress));
    });
  };
}
