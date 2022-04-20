part of 'workout_bloc.dart';


abstract class WorkoutEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WorkoutsLoad extends WorkoutEvent {
  final List<WorkoutDto> workouts;
  WorkoutsLoad({
    this.workouts,
  });

  @override
  List<Object> get props => [workouts];
}

class WorkoutsFetched extends WorkoutEvent {
  final List<WorkoutDto> workouts;
  final bool hasReachedMax;

  WorkoutsFetched({
    this.workouts,
    this.hasReachedMax,
  });

  @override
  List<Object> get props => [workouts, hasReachedMax];
}

class WorkoutsReFetched extends WorkoutEvent {
  final List<WorkoutDto> workouts;
  final bool hasReachedMax;

  WorkoutsReFetched({
    this.workouts,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [workouts, hasReachedMax];
}

class ChangeFilter extends WorkoutEvent {
  final ChipData sendValue;
  final int index;
  final List<String> difficultFilters;
  final List<String> durationFilters;
  final List<String> wodFilters;
  final List<String> equipmentFilters;
  final Map<String, List<ChipData>> mapFilters;

  ChangeFilter(
    this.sendValue,
    this.index, {
    this.mapFilters,
    this.difficultFilters,
    this.durationFilters,
    this.wodFilters,
    this.equipmentFilters,
  });

  @override
  List<Object> get props => [
    mapFilters,
    difficultFilters,
    durationFilters,
    wodFilters,
    equipmentFilters,
  ];
}

class ClearFilter extends WorkoutEvent {
  final List<String> difficultFilters;
  final List<String> durationFilters;
  final List<String> wodFilters;
  final List<String> equipmentFilters;
  final Map<String, List<ChipData>> mapFilters;

  ClearFilter({
    this.mapFilters,
    this.difficultFilters,
    this.durationFilters,
    this.wodFilters,
    this.equipmentFilters,
  });

  @override
  List<Object> get props => [
    mapFilters,
    difficultFilters,
    durationFilters,
    wodFilters,
    equipmentFilters,
  ];
}

class ApplyFilter extends WorkoutEvent {

}
