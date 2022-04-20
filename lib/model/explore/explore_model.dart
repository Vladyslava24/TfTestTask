import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';

class ExploreModel {
  final WorkoutDto exploreWODMonth;
  final WorkoutCollectionResponse exploreCollections;

  const ExploreModel({@required this.exploreWODMonth, @required this.exploreCollections});
}
