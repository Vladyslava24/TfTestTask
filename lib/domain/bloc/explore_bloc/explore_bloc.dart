import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:totalfit/data/source/repository/explore_repository.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/explore/explore_model.dart';

part 'explore_event.dart';

part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ExploreRepository exploreRepository;

  ExploreBloc({@required this.exploreRepository}) : super(ExploreState.initial());

  @override
  Stream<ExploreState> mapEventToState(
    ExploreEvent event,
  ) async* {
    if (event is ExploreFetch) {
      yield* _mapFetchToState(event, state);
    } else if (event is ExploreReLoad) {
      yield* _mapReloadToState(event, state);
    }
  }

  Stream<ExploreState> _mapFetchToState(
    ExploreEvent event,
    ExploreState state,
  ) async* {
    yield state.copyWith(isLoading: true);

    try {
      final ExploreModel explore = await exploreRepository.fetchExplore();
      yield state.copyWith(explore: explore, isLoading: false);
    } catch (e) {
      print(e);
      yield state.copyWith(error: TfException(ErrorCode.ERROR_LOAD_EXPLORE, e.toString()), isLoading: false);
    }
  }

  Stream<ExploreState> _mapReloadToState(
    ExploreEvent event,
    ExploreState state,
  ) async* {
    yield state.copyWith(isLoadingError: true);

    try {
      final ExploreModel explore = await exploreRepository.fetchExplore();
      yield ExploreState.withValue(false, false, explore, null);
    } on ApiException catch (e) {
      yield state.copyWith(
          error: TfException(ErrorCode.ERROR_LOAD_EXPLORE, e.serverErrorMessage), isLoadingError: false);
    } catch (e) {
      yield state.copyWith(
          error: TfException(ErrorCode.ERROR_LOAD_EXPLORE, e.toString()), isLoadingError: false);
    }
  }
}
