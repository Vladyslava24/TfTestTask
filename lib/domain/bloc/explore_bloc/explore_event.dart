part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();
}

class ExploreFetch extends ExploreEvent {
  @override
  List<Object> get props => [];
}

class ExploreReLoad extends ExploreEvent {
  @override
  List<Object> get props => [];
}