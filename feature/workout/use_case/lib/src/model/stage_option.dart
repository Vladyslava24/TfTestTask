import 'package:workout_use_case/src/model/rest.dart';

class StageOption {
  String metricType;
  int metricQuantity;
  List<Rest> rests;

  StageOption({
    required this.metricType,
    required this.metricQuantity,
    required this.rests,
  });
}
