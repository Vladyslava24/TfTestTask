import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/model/exercise_category.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/workout_list_items.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/middleware/storage_middleware.dart';
import 'package:totalfit/redux/states/app_state.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    return Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView.builder(
            itemCount: vm.listItems.length,
            itemBuilder: (context, index) {
              final item = vm.listItems[index];
              if (item is PageHeaderItem) {
                return PageHeaderWidget(
                    item: item,
                    onWorkoutSelected: () =>
                        vm.onWorkoutSelected(item.workout));
              }
              if (item is SingleWorkoutListItem) {
                return SingleWorkoutListWidget(
                    navigateToWorkoutSelectionPage: () {
                      vm.showSortedWorkoutsPage();
                    },
                    onWorkoutSelected: (workout) {
                      vm.onWorkoutSelected(workout);
                    },
                    item: item,
                    key: PageStorageKey("ProgramListItem"));
              }
              if (item is SpaceItem) {
                return Container(height: 100);
              }

              return ExerciseCategoryListWidget(
                item: item,
                onCategorySelected: (exerciseCategory) {
                  vm.showSortedExercisePage(exerciseCategory);
                },
                onSeeAllPressed: () {
                  vm.onSeeAllPressed((item as ExercisesItem).exercises.first);
                },
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ViewModel {
  final List listItems;
  final Function() showSortedWorkoutsPage;
  final Function(ExerciseCategory) showSortedExercisePage;
  final Function(ExerciseCategory) onSeeAllPressed;
  final Function removeInnerWorkoutPage;
  final Function(WorkoutDto) onWorkoutSelected;
  final Function() navigateToWorkoutSelectionPage;

  _ViewModel(
      {this.listItems,
      this.showSortedWorkoutsPage,
      this.showSortedExercisePage,
      this.onSeeAllPressed,
      this.removeInnerWorkoutPage,
      this.onWorkoutSelected,
      this.navigateToWorkoutSelectionPage});

  static _ViewModel fromStore(Store<AppState> store) {
    List items;
    List workoutItemList = store.state.mainPageState.workoutItemList;
    if (workoutItemList != null) {
      items = workoutItemList;
      items.removeWhere((element) => element is SpaceItem);
      items.add(SpaceItem());
    } else {
      items = WorkoutPageHelper.getCarcassItems();
    }

    return _ViewModel(
      listItems: items,
      navigateToWorkoutSelectionPage: () =>
          store.dispatch(NavigateToWorkoutSelectionAction()),
      showSortedWorkoutsPage: () => store.dispatch(ShowSortedWorkoutsAction()),
      showSortedExercisePage: (exerciseCategory) =>
          store.dispatch(NavigateToSortedExercisesPageAction(exerciseCategory)),
      onSeeAllPressed: (exerciseCategory) => store.dispatch(
          NavigateToSortedExercisesPageOnSeeAllPressedAction(exerciseCategory)),
      removeInnerWorkoutPage: () =>
          store.dispatch(RemoveInnerWorkoutPageAction()),
      onWorkoutSelected: (workout) {
        store.dispatch(NavigateToWorkoutPreviewPageAction(workout));
      },
    );
  }
}
