import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/plan_utils.dart';
import 'package:totalfit/ui/widgets/cards/card_widget.dart';
import 'package:totalfit/ui/widgets/common/title_category_widget.dart';

class ExploreSliderWorkoutWidget extends StatelessWidget {

  final String title;
  final String titleLinkText;
  final Function titleAction;
  final List<WorkoutDto> workouts;
  final EdgeInsets margin;

  const ExploreSliderWorkoutWidget({
    @required this.title,
    @required this.titleLinkText,
    @required this.titleAction,
    this.workouts = const [],
    this.margin = const EdgeInsets.only(bottom: 32.0),
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TitleCategoryWidget(
              title: title,
              textButton: titleLinkText,
              actionButton: titleAction,
            ),
          ),
          SizedBox(height: 16.0),
          StoreConnector<AppState, _ViewModel>(
            distinct: true,
            converter: (store) => _ViewModel.fromStore(store),
            builder: (context, vm) =>
              Container(
                width: double.infinity,
                height: 270.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: workouts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardWidget(
                      maxWidth: 218.0,
                      margin: EdgeInsets.only(
                        left: index == 0 ? 16.0 : 0.0,
                        right: 20.0),
                      title: workouts[index].theme,
                      image: workouts[index].image,
                      chips: [
                        '${workouts[index].estimatedTime} min',
                        workouts[index].difficultyLevel
                      ],
                      premium: convertStringToPlan(workouts[index].plan) == Plan.premium && !vm.isPremiumUser ?
                        true : false,
                      action: () => vm.onWorkoutSelected(workouts[index]),
                    );
                  },
                ),
              ),
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  Function(WorkoutDto) onWorkoutSelected;
  final bool isPremiumUser;

  _ViewModel({
    @required this.onWorkoutSelected,
    @required this.isPremiumUser
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onWorkoutSelected: (WorkoutDto workout) =>
        store.dispatch(NavigateToWorkoutPreviewPageAction(workout)),
      isPremiumUser: store.state.isPremiumUser(),
    );
  }
}