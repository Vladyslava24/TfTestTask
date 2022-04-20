import 'package:workout_api/api.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/source/repository/explore_repository.dart';
import 'package:totalfit/model/explore/explore_model.dart';

class ExploreRepositoryImpl extends ExploreRepository {
  final WorkoutApi workoutApi;

  ExploreRepositoryImpl({@required this.workoutApi});

  @override
  Future<ExploreModel> fetchExplore() async {
    final r1 = await workoutApi.fetchWODOfTheMonth();
    final r2 = await workoutApi.fetchWODCollectionPriority();
    return ExploreModel(exploreWODMonth: r1, exploreCollections: r2);
    // return Future.wait([
    //   workoutApi.fetchWODCollectionPriority(),
    // ]).then((resultList) => ExploreModel(exploreWODMonth: resultList.first, exploreCollections: resultList.last));
  }
}
