import 'package:workout_use_case/use_case.dart';

extension ExerciseX on ExerciseModel {
  String getMetricQuantity() {
    if (metrics == 'MIN') {
      return '$quantity min';
    }
    if (metrics == 'SEC') {
      return '$quantity sec';
    }
    if (metrics == 'REPS') {
      return 'x$quantity';
    }
    return quantity.toString();
  }
}
