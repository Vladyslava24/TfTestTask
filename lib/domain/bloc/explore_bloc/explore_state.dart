part of 'explore_bloc.dart';

@immutable
class ExploreState extends Equatable {
  final bool isLoading;
  final bool isLoadingError;
  final ExploreModel explore;
  final Exception error;

  const ExploreState._({
    this.isLoading,
    this.isLoadingError,
    this.explore,
    this.error
  });

  ExploreState copyWith({
    bool isLoading,
    bool isLoadingError,
    ExploreModel explore,
    Exception error
  }) {
    return ExploreState._(
      isLoading: isLoading ?? this.isLoading,
      isLoadingError: isLoadingError ?? this.isLoadingError,
      explore: explore ?? this.explore,
      error: error ?? this.error
    );
  }

  factory ExploreState.initial() => ExploreState._(
    isLoading: false,
    isLoadingError: false,
    explore: null,
    error: null
  );

  factory ExploreState.withValue(isLoading, isLoadingError, explore, error) =>
    ExploreState._(
      isLoading: isLoading,
      isLoadingError: isLoadingError,
      explore: explore,
      error: error
    );

  @override
  List<Object> get props => [isLoading, isLoadingError, explore, error];
}