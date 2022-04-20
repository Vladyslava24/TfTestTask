import 'package:freezed_annotation/freezed_annotation.dart';

enum StatisticMeasure {
  @JsonValue("DAY")
  DAY,
  @JsonValue("WEEK")
  WEEK,
  @JsonValue("MONTH")
  MONTH,
}

// extension on StatisticMeasure {
//   String stringValue() {
//     switch (this) {
//       case StatisticMeasure.day:
//         return 'DAY';
//       case StatisticMeasure.week:
//         return 'WEEK';
//       case StatisticMeasure.month:
//         return 'MONTH';
//     }
//   }
// }
