import 'package:totalfit/model/explore/explore_model.dart';

abstract class ExploreRepository {
  // remote
  Future<ExploreModel> fetchExplore();
}