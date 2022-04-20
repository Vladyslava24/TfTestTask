import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/ui/utils/plan_utils.dart';
import 'package:totalfit/ui/widgets/cards/card_widget.dart';

class ExploreWorkoutsListScreen extends StatelessWidget {
  const ExploreWorkoutsListScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final title = settings['title'];
    final workouts = List<WorkoutDto>.of(settings['workouts']);

    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) =>
        Scaffold(
        appBar: SimpleAppBar(
          leadingType: LeadingType.back,
          leadingAction: () => Navigator.of(context).pop(),
          title: title,
          actionType: ActionType.button,
          actionButtonText: S.of(context).explore_btn_wod_title,
          actionFunction: () => vm.navigateToWorkouts(),
        ),
        backgroundColor: AppColorScheme.colorBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (BuildContext context, int index) {
              return CardWidget(
                margin: const EdgeInsets.only(bottom: bottomListCardsMargin),
                title: workouts[index].theme,
                image: workouts[index].image,
                chips: [
                  '${workouts[index].estimatedTime} min',
                  workouts[index].difficultyLevel
                ],
                premium: convertStringToPlan(workouts[index].plan) == Plan.premium
                  && !vm.isPremiumUser ?
                true : false,
                action: () => vm.onWorkoutSelected(workouts[index]),
              );
            }
          ),
        ),
      )
    );
  }
}

class _ViewModel {
  Function navigateToWorkouts;
  Function(WorkoutDto) onWorkoutSelected;
  final bool isPremiumUser;

  _ViewModel({
    @required this.navigateToWorkouts,
    @required this.onWorkoutSelected,
    @required this.isPremiumUser
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      navigateToWorkouts: () {
        store.dispatch(ShowSortedWorkoutsAction());
      },
      onWorkoutSelected: (WorkoutDto workout) =>
        store.dispatch(NavigateToWorkoutPreviewPageAction(workout)),
      isPremiumUser: store.state.isPremiumUser(),
    );
  }
}