part of 'workout_bloc.dart';

class WorkoutState extends Equatable {
  final WorkoutStatus status;
  final FilterStatus filterStatus;
  final List<WorkoutDto> workouts;
  final bool hasReachedMax;
  final List<String> difficultFilters;
  final List<String> durationFilters;
  final List<String> equipmentFilters;
  final Map<String, List<ChipData>> mapFilters;

  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.filterStatus = FilterStatus.initial,
    this.workouts = const [],
    this.hasReachedMax = false,
    this.difficultFilters,
    this.durationFilters,
    this.equipmentFilters,
    this.mapFilters = const {},
  });

  WorkoutState copyWith({
    WorkoutStatus status,
    FilterStatus filterStatus,
    List<WorkoutDto> workouts,
    bool hasReachedMax,
    Map<String, List<ChipData>> mapFilters,
    List<String> difficultFilters,
    List<String> durationFilters,
    List<String> equipmentFilters,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      filterStatus: filterStatus ?? this.filterStatus,
      workouts: workouts ?? this.workouts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      mapFilters: mapFilters ?? this.mapFilters,
      difficultFilters: difficultFilters ?? this.difficultFilters,
      durationFilters: durationFilters ?? this.durationFilters,
      equipmentFilters: equipmentFilters ?? this.equipmentFilters,
    );
  }

  @override
  List<Object> get props => [
    status,
    filterStatus,
    workouts,
    hasReachedMax,
    mapFilters,
    difficultFilters,
    durationFilters,
    equipmentFilters,
  ];
}
