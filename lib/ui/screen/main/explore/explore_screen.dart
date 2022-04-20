import 'package:core/core.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/data/source/repository/explore_repository.dart';
import 'package:totalfit/domain/bloc/explore_bloc/explore_bloc.dart';
import 'package:totalfit/model/exercise_category.dart';
import 'package:totalfit/model/explore/explore_feature_model.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/main_screen.dart';
import 'package:totalfit/ui/utils/plan_utils.dart';
import 'package:totalfit/ui/widgets/explore/explore_error_widget.dart';
import 'package:totalfit/ui/widgets/explore/explore_features_widget.dart';
import 'package:totalfit/ui/widgets/explore/explore_skeleton_widget.dart';
import 'package:totalfit/ui/widgets/explore/explore_slider_workout_widget.dart';
import 'package:totalfit/ui/widgets/explore/explore_wod_month_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
  with AutomaticKeepAliveClientMixin {

  final EdgeInsets padding = const EdgeInsets.only(
    left: 16.0,
    right: 16.0,
    bottom: 24.0
  );

  ExploreBloc _exploreBloc;

  @override
  void initState() {
    super.initState();
    _exploreBloc = ExploreBloc(
      exploreRepository: DependencyProvider.get<ExploreRepository>()
    )..add(ExploreFetch());
  }

  @override
  void dispose() {
    _exploreBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) =>
        BlocProvider.value(
          value: _exploreBloc,
          child: Scaffold(
            backgroundColor: AppColorScheme.colorBlack,
            body: BlocBuilder<ExploreBloc, ExploreState>(
              builder: (BuildContext context, ExploreState state) {
                final isLoading = state.isLoading;
                final exploreWODMonth = state.explore != null &&
                  state.explore.exploreWODMonth != null ?
                  state.explore.exploreWODMonth : null;
                final exploreWorkouts = state.explore != null &&
                  state.explore.exploreCollections != null &&
                  state.explore.exploreCollections.workoutCollections != null &&
                  state.explore.exploreCollections.workoutCollections.isNotEmpty ?
                  state.explore.exploreCollections.workoutCollections : null;
                final error = state.error;
                final isLoadingError = state.isLoadingError;

                return SingleChildScrollView(
                  physics: isLoading ? NeverScrollableScrollPhysics() :
                  AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 54.0,
                      bottom: 74.0
                    ),
                    child: isLoading ?
                    ExploreSkeletonWidget() :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        error != null ?
                        ExploreErrorWidget(
                          exception: error,
                          isLoading: isLoadingError,
                          reload: () => _exploreBloc.add(ExploreReLoad()),
                        ) :
                        Column(
                          children: [
                            exploreWODMonth != null ?
                            ExploreWodMonthWidget(
                              title: state.explore.exploreWODMonth.theme,
                              image: state.explore.exploreWODMonth.image,
                              badges: [
                                '${state.explore.exploreWODMonth.estimatedTime} min',
                                state.explore.exploreWODMonth.difficultyLevel],
                              premium: convertStringToPlan(
                                  state.explore.exploreWODMonth.plan
                              ) == Plan.premium && !vm.isPremiumUser ? true : false,
                              action: () =>
                                vm.onWorkoutSelected(state.explore.exploreWODMonth),
                            ) : SizedBox.shrink(),
                            SizedBox(height: 32.0),
                            exploreWorkouts != null ? Column(
                            children: exploreWorkouts.map((c) =>
                              ExploreSliderWorkoutWidget(
                                title: c.name,
                                titleLinkText: S.of(context).explore_see_all,
                                titleAction: () =>
                                  vm.navigateToExploreListWorkoutsScreen(
                                    c.name,
                                    c.workouts
                                  ),
                                workouts: c.workouts.length > 7 ?
                                  c.workouts.sublist(0,7) : c.workouts,
                              )).toList(),
                            ) : SizedBox.shrink(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            bottom: 16.0
                          ),
                          child: Text(
                            S.of(context).explore_more,
                            style: title20,
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: ExploreFeaturesWidget(
                            features: [
                              ExploreFeatureModel(
                                type: ExploreFeatureType.exercise,
                                title: S.of(context).explore_btn_exercise_title,
                                description: S.of(context).explore_btn_exercise_description,
                                action: () => vm.navigateToExercises(
                                  ExerciseCategory(tag: 'MONOSTRUCTURAL', image: ''))
                              ),
                              ExploreFeatureModel(
                                type: ExploreFeatureType.wod,
                                title: S.of(context).explore_btn_wod_title,
                                description: S.of(context).explore_btn_wod_description,
                                action: () => vm.navigateToWorkouts()
                              ),
                              ExploreFeatureModel(
                                type: ExploreFeatureType.weeklyPlan,
                                title: S.of(context).explore_btn_plan_title,
                                description: S.of(context).explore_btn_plan_description,
                                action: () => vm.updateSelectedTab(0)
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ViewModel {
  Function(String, List<WorkoutDto>) navigateToExploreListWorkoutsScreen;
  Function navigateToWorkouts;
  Function(WorkoutDto) onWorkoutSelected;
  Function(int) updateSelectedTab;
  Function(ExerciseCategory) navigateToExercises;
  final bool isPremiumUser;

  _ViewModel({
    @required this.navigateToExploreListWorkoutsScreen,
    @required this.onWorkoutSelected,
    @required this.navigateToWorkouts,
    @required this.updateSelectedTab,
    @required this.navigateToExercises,
    @required this.isPremiumUser
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onWorkoutSelected: (WorkoutDto workout) =>
        store.dispatch(NavigateToWorkoutPreviewPageAction(workout)),
      navigateToExploreListWorkoutsScreen: (String title, List<WorkoutDto> workouts) =>
        store.dispatch(NavigateToExploreWorkoutsListAction(title: title, workouts: workouts)),
      navigateToWorkouts: () => store.dispatch(ShowSortedWorkoutsAction()),
      updateSelectedTab: (index) =>
        store.dispatch(UpdateSelectedTab(tab: BottomTab.values[index])),
      navigateToExercises: (exerciseCategory) => store.dispatch(
        NavigateToSortedExercisesPageOnSeeAllPressedAction(exerciseCategory)),
      isPremiumUser: store.state.isPremiumUser(),
    );
  }
}
