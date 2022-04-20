enum WorkoutStatus {
  initial,
  loading,
  success,
  error,
}

extension XWorkoutStatus on WorkoutStatus {
  bool get isInitial => this == WorkoutStatus.initial;
  bool get isSuccess => this == WorkoutStatus.success;
  bool get isLoading => this == WorkoutStatus.loading;
  bool get isError => this == WorkoutStatus.error;
}

enum FilterStatus {
  initial,
  loading,
  success,
  error,
}

extension XFilterStatus on FilterStatus {
  bool get isInitial => this == FilterStatus.initial;
  bool get isSuccess => this == FilterStatus.success;
  bool get isLoading => this == FilterStatus.loading;
  bool get isError => this == FilterStatus.error;
}
