import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/domain/bloc/workouts_bloc/workout_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/widgets/filter_chip.dart';
import 'package:ui_kit/ui_kit.dart';

class FilterWorkoutsPage extends StatefulWidget {
  final WorkoutBloc bloc;

  const FilterWorkoutsPage(this.bloc, {Key key}) : super(key: key);

  @override
  _FilterWorkoutsPageState createState() => _FilterWorkoutsPageState();
}

class _FilterWorkoutsPageState extends State<FilterWorkoutsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      onInit: (store) {},
      converter: _ViewModel.fromStore,
      onWillChange: (previousVm, newVm) {},
      builder: (context, vm) => _buildContent(vm)
    );
  }

  Widget _buildContent(_ViewModel vm) => BlocProvider.value(
    value: widget.bloc,
    child: Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      appBar: SimpleAppBar(
        leadingType: LeadingType.back,
        leadingAction: () {
          widget.bloc.add(ApplyFilter());
          Navigator.of(context).pop();
        },
        title: S.of(context).filters,
        actionButtonText: S.of(context).clear_filters,
        actionType: ActionType.button,
        actionFunction: () =>
          widget.bloc.add(ClearFilter()),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: _buildFilterList(vm, context),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 14.5, left: 16, right: 16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<WorkoutBloc, WorkoutState>(
                      builder: (context, state) {
                        if (state.workouts.isEmpty) {
                          return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                MaterialStateProperty.all<Color>(
                                  AppColorScheme.colorBlack6),
                            ),
                            onPressed: () => context.read<WorkoutBloc>()
                              ..add(ApplyFilter()),
                            child: Padding(
                              padding:
                                const EdgeInsets.symmetric(vertical: 12.5),
                              child: Text(
                                S.of(context).no_workouts_found,
                                style: title16.copyWith(
                                  color: AppColorScheme.colorPrimaryBlack,
                                ),
                              ),
                            ),
                          );
                        }

                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColorScheme.colorYellow),
                          ),
                          onPressed: () async {
                            final _difficultFilters = widget.bloc.state.difficultFilters;
                            final _durationFilters = widget.bloc.state.durationFilters;
                            final _equipmentFilters = widget.bloc.state.equipmentFilters;

                            final _filtersList = [];
                            if (_difficultFilters.isNotEmpty)
                              _filtersList.addAll(_difficultFilters);
                            if (_durationFilters.isNotEmpty)
                              _filtersList.addAll(_durationFilters);
                            if (_equipmentFilters.isNotEmpty)
                              _filtersList.addAll(_equipmentFilters);

                           final _filtersString = _filtersList.join(',');

                            vm.sentPressedEvent(_filtersString);

                            context.read<WorkoutBloc>()
                              ..add(ApplyFilter());
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding:
                              const EdgeInsets.symmetric(vertical: 12.5),
                            child: Text(
                              '${S.of(context).show} ${S.of(context).bottom_menu__workouts}',
                              style: title16.copyWith(
                                color: AppColorScheme.colorBlack,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildFilterList(_ViewModel vm, BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        S.of(context).difficulty,
        style: textRegular16.copyWith(
          color: AppColorScheme.colorBlack9,
        ),
      ),
      SizedBox(height: 12.0),
      BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          return Wrap(
            verticalDirection: VerticalDirection.down,
            runSpacing: 12.0,
            spacing: 8.0,
            children: state.mapFilters['difficulty'].map((chip) {
              int index = state.mapFilters['difficulty'].indexOf(chip);
              return TsFilterChip(
                currentItem: chip,
                onSelected: (isSelected) {
                  context.read<WorkoutBloc>()
                    ..add(ChangeFilter(chip, index));
                },
              );
            }).toList(),
          );
        },
      ),
      Divider(
        color: AppColorScheme.colorBlack4,
        height: 49,
      ),
      Text(
        S.of(context).estimated_type,
        style: textRegular16.copyWith(
          color: AppColorScheme.colorBlack9,
        ),
      ),
      SizedBox(height: 12),
      BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          return Wrap(
            verticalDirection: VerticalDirection.down,
            runSpacing: 12,
            spacing: 8,
            children: state.mapFilters['estimatedTime'].map((chip) {
              int index = state.mapFilters['estimatedTime'].indexOf(chip);
              return TsFilterChip(
                currentItem: chip,
                onSelected: (isSelected) {
                  context.read<WorkoutBloc>()
                    ..add(ChangeFilter(chip, index));
                },
              );
            }).toList(),
          );
        },
      ),
      Divider(
        color: AppColorScheme.colorBlack4,
        height: 49,
      ),
      Text(
        S.of(context).equipment,
        style: textRegular16.copyWith(
          color: AppColorScheme.colorBlack9,
        ),
      ),
      SizedBox(height: 12),
      BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          return Wrap(
            verticalDirection: VerticalDirection.down,
            runSpacing: 12,
            spacing: 8,
            children: state.mapFilters['equipment'].map((chip) {
              int index = state.mapFilters['equipment'].indexOf(chip);
              return TsFilterChip(
                currentItem: chip,
                onSelected: (isSelected) {
                  context.read<WorkoutBloc>()
                    ..add(ChangeFilter(chip, index));
                },
              );
            }).toList(),
          );
        },
      ),
      SizedBox(height: 48),
    ],
  );
}

class _ViewModel {
  final Function(String eventName) sentPressedEvent;

  _ViewModel({
    this.sentPressedEvent,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      sentPressedEvent: (eventName) => store.dispatch(
        SentPressedFilterEventAction(eventName: eventName),
      ),
    );
  }
}
