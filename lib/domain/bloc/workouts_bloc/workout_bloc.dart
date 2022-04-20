import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:totalfit/model/inner_pages/workouts/workouts_filter_model.dart';
import 'package:totalfit/utils/constants.dart';
import 'package:totalfit/utils/enums.dart';
import 'package:workout_api/api.dart';
import 'package:workout_data_legacy/data.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutApi workoutApi;

  Map<String, List<ChipData>> _defaultFilters =
    Map<String, List<ChipData>>.from(constWorkoutFilters);

  WorkoutBloc(this.workoutApi) : super(WorkoutState());

  @override
  Stream<WorkoutState> mapEventToState(WorkoutEvent event) async* {
    if (event is WorkoutsLoad) {
      yield state.copyWith(
        status: WorkoutStatus.success,
        filterStatus: FilterStatus.success,
        workouts: event.workouts,
        hasReachedMax: true,
        mapFilters: Map<String, List<ChipData>>.from(_defaultFilters),
        difficultFilters: [],
        durationFilters: [],
        equipmentFilters: [],
      );
    } else if (event is WorkoutsReFetched) {
      yield* _mapReFetchedToState(event, state);
    } else if (event is WorkoutsFetched && !state.hasReachedMax) {
      yield* _mapFetchedToState(event, state);
    } else if (event is ChangeFilter) {
      final _mapFilters = Map<String, List<ChipData>>.from(state.mapFilters);
      final _difficultFilters = List<String>.from(state.difficultFilters);
      final _durationFilters = List<String>.from(state.durationFilters);
      final _equipmentFilters = List<String>.from(state.equipmentFilters);
      final String _eventName = event.sendValue.filter;
      final int _eventIndex = event.index;

      _mapFilters[_eventName][_eventIndex].isSelected = !_mapFilters[_eventName][_eventIndex].isSelected;

      switch (_eventName) {
        case 'difficulty':
          {
            if (_difficultFilters.contains(_mapFilters[_eventName][_eventIndex].value)) {
              _difficultFilters.remove(_mapFilters[_eventName][_eventIndex].value);
            } else {
              _difficultFilters.add(_mapFilters[_eventName][_eventIndex].value);
            }
          }
          break;
        case 'estimatedTime':
          {
            if (_durationFilters.contains(_mapFilters[_eventName][_eventIndex].value)) {
              _durationFilters.remove(_mapFilters[_eventName][_eventIndex].value);
            } else {
              _durationFilters.add(_mapFilters[_eventName][_eventIndex].value);
            }
          }
          break;
        case 'equipment':
          {
            if (_equipmentFilters.contains(_mapFilters[_eventName][_eventIndex].value)) {
              _equipmentFilters.remove(_mapFilters[_eventName][_eventIndex].value);
            } else {
              _equipmentFilters.add(_mapFilters[_eventName][_eventIndex].value);
            }
          }
          break;
      }

      yield state.copyWith(
        mapFilters: _mapFilters,
        difficultFilters: _difficultFilters,
        durationFilters: _durationFilters,
        equipmentFilters: _equipmentFilters,
      );
    } else if (event is ApplyFilter) {
      try {
        yield state.copyWith(status: WorkoutStatus.loading);

        final _difficultFilters = state.difficultFilters;
        final _durationFilters = state.durationFilters;
        final _equipmentFilters = state.equipmentFilters;

        final queryParams = {
          "difficulty": _difficultFilters.join(','),
          "estimatedTime": _durationFilters.join(','),
          "equipment": _equipmentFilters.join(','),
        };
        final responseData = await workoutApi.filterWorkouts(queryParams);

        yield state.copyWith(
          status: WorkoutStatus.success,
          workouts: responseData.workouts
        );
      } catch (_) {
        yield state.copyWith(status: WorkoutStatus.error);
      }
    } else if (event is ClearFilter) {
      yield state.copyWith(status: WorkoutStatus.loading);

      final responseData = await workoutApi.fetchWorkouts();
      final _mapFilters = Map<String, List<ChipData>>.from(state.mapFilters);

      _mapFilters.forEach((key, value) {
        value.asMap().forEach((key, value) => value.isSelected = false);
      });

      yield state.copyWith(
        status: WorkoutStatus.success,
        mapFilters: _mapFilters,
        workouts: responseData.workouts,
        difficultFilters: [],
        durationFilters: [],
        equipmentFilters: [],
      );
    }
  }

  Stream<WorkoutState> _mapFetchedToState(
    WorkoutEvent event,
    WorkoutState state,
  ) async* {
    try {
      yield state.copyWith(status: WorkoutStatus.loading);
      final responseData = await workoutApi.fetchWorkouts();

      if (state.status.isLoading || state.status.isInitial || state.status.isError) {
        yield state.copyWith(
          status: WorkoutStatus.success,
          filterStatus: FilterStatus.success,
          workouts: responseData.workouts,
          hasReachedMax: false,
          mapFilters: Map<String, List<ChipData>>.from(_defaultFilters),
          difficultFilters: [],
          durationFilters: [],
          equipmentFilters: [],
        );

        return;
      }

      if (state.status.isSuccess) {
        yield state.copyWith(
          status: WorkoutStatus.success,
          workouts: responseData.workouts,
          hasReachedMax: true,
        );
      }
    } catch (_) {
      yield state.copyWith(status: WorkoutStatus.error);
    }
  }

  Stream<WorkoutState> _mapReFetchedToState(
    WorkoutEvent event,
    WorkoutState state,
  ) async* {
    try {
      yield state.copyWith(status: WorkoutStatus.initial, filterStatus: FilterStatus.initial);

      final responseData = await workoutApi.fetchWorkouts();

      yield state.copyWith(
        status: WorkoutStatus.success,
        workouts: responseData.workouts,
        hasReachedMax: true,
      );
    } catch (_) {
      yield state.copyWith(status: WorkoutStatus.error);
    }
  }

  @override
  Future<void> close() {
    final _mapFilters = Map<String, List<ChipData>>.from(state.mapFilters);

    _mapFilters.forEach((key, value) {
      value.asMap().forEach((key, value) => value.isSelected = false);
    });
    return super.close();
  }
}
