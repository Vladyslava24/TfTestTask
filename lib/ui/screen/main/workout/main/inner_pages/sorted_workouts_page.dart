import 'package:core/core.dart';
import 'package:workout_api/api.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/domain/bloc/workouts_bloc/workout_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/widgets/filter_chip.dart';
import 'package:totalfit/ui/widgets/single_workouts/single_workouts_error_widget.dart';
import 'package:totalfit/ui/widgets/single_workouts/single_workouts_filter_icon_widget.dart';
import 'package:totalfit/ui/widgets/single_workouts/single_workouts_filter_skeleton_widget.dart';
import 'package:totalfit/ui/widgets/single_workouts/single_workouts_not_found_widget.dart';
import 'package:totalfit/ui/widgets/single_workouts/single_workouts_skeleton_widget.dart';
import 'package:totalfit/utils/enums.dart';
import 'package:totalfit/ui/screen/main/workout/main/inner_pages/relative_workouts_page.dart';

class SortedWorkoutsPage extends StatefulWidget {
  const SortedWorkoutsPage({Key key}) : super(key: key);

  @override
  _SortedWorkoutsPageState createState() => _SortedWorkoutsPageState();
}

class _SortedWorkoutsPageState extends State<SortedWorkoutsPage> with
  SingleTickerProviderStateMixin {
  WorkoutBloc _workoutBloc;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      onInit: (store) {
        _workoutBloc = WorkoutBloc(DependencyProvider.get<WorkoutApi>());
        final workouts = store.state.mainPageState.workouts;
        workouts != null && workouts.isNotEmpty ?
          _workoutBloc.add(WorkoutsLoad(workouts: workouts)) :
          _workoutBloc.add(WorkoutsFetched());
      },
      onDispose: (store) {
        _workoutBloc.close();
      },
      builder: (context, vm) => _buildContent(vm)
    );
  }

  Widget _buildContent(_ViewModel vm) => BlocProvider<WorkoutBloc>.value(
    value: _workoutBloc,
    child: Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      appBar: SimpleAppBar(
        leadingType: LeadingType.back,
        leadingAction: () => Navigator.of(context).pop(),
        title: S.of(context).single_workouts,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            BlocBuilder<WorkoutBloc, WorkoutState>(
              builder: (context, state) {
                if (!state.filterStatus.isSuccess) {
                  return Container();
                }

                return Container(
                  height: 64.0,
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 16.0,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SingleWorkoutsFilterIconWidget(
                        callback: () => vm.showFilterWorkoutsPage(
                          context.read<WorkoutBloc>(),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: state.mapFilters['difficulty'].map(
                              (chip) {
                                int index = state.mapFilters['difficulty'].indexOf(chip);
                                return Row(
                                  children: [
                                    TsFilterChip(
                                      currentItem: chip,
                                      onSelected: (isSelected) {
                                        vm.sentPressedEvent(chip.value);
                                        context.read<WorkoutBloc>()..add(ChangeFilter(chip, index));
                                        _workoutBloc.add(ApplyFilter());
                                      },
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                          Row(
                            children: state.mapFilters['estimatedTime'].map((chip) {
                              int index = state.mapFilters['estimatedTime'].indexOf(chip);
                              return Row(
                                children: [
                                  TsFilterChip(
                                    currentItem: chip,
                                    onSelected: (isSelected) {
                                      vm.sentPressedEvent(chip.value);
                                      context.read<WorkoutBloc>()..add(ChangeFilter(chip, index));
                                      _workoutBloc.add(ApplyFilter());
                                    },
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          Row(
                            children: [
                              TsFilterChip(
                                currentItem: state.mapFilters['equipment'].first,
                                onSelected: (isSelected) {
                                  vm.sentPressedEvent(state.mapFilters['equipment'][0].value);
                                  context.read<WorkoutBloc>()
                                    ..add(ChangeFilter(state.mapFilters['equipment'].first, 0));
                                  _workoutBloc.add(ApplyFilter());
                                },
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<WorkoutBloc>()..add(ClearFilter());
                        },
                        child: Text(
                          S.of(context).clear_filters,
                          style: textRegular16.copyWith(
                            color: AppColorScheme.colorYellow,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<WorkoutBloc, WorkoutState>(
              builder: (context, state) {
                if (state.status.isLoading && !state.filterStatus.isSuccess) {
                  return Expanded(
                    child: SingleWorkoutsSkeletonWidget(),
                  );
                } else if (state.status.isLoading && state.filterStatus.isSuccess) {
                  return Expanded(child: SingleWorkoutsFilterSkeletonWidget());
                }

                if (state.status.isError) {
                  return SingleWorkoutsErrorWidget(
                      callback: () => context.read<WorkoutBloc>().add(WorkoutsFetched()));
                }

                return Expanded(
                  child: _contentList(state.workouts),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );

  Widget _contentList(elements) {
    if (elements.length == 0) {
      return SingleWorkoutsNotFoundWidget(
        callback: () => _workoutBloc.add(ClearFilter()),
      );
    }

    return RelativeWorkoutsPage(
      workouts: elements,
    );
  }
}

class _ViewModel {
  final Function(WorkoutBloc bloc) showFilterWorkoutsPage;
  final Function(String eventName) sentPressedEvent;
  final List<WorkoutDto> workouts;

  _ViewModel({
    @required this.showFilterWorkoutsPage,
    @required this.sentPressedEvent,
    @required this.workouts
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      showFilterWorkoutsPage: (bloc) =>
        store.dispatch(ShowFilterWorkoutsAction(bloc)),
      sentPressedEvent: (eventName) =>
        store.dispatch(SentPressedFilterEventAction(eventName: eventName)),
      workouts: store.state.mainPageState.workouts
    );
  }
}
