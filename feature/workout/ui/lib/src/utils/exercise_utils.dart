import 'package:core/core.dart';

String getQuantityByMetricsInTimer(String quantity, String metrics) {
  switch (metrics) {
    case 'REPS':
      return 'x$quantity';
    case 'MIN':
      return timeFromMilliseconds(int.parse(quantity) * 1000 * 60);
    case 'SEC':
      return timeFromMilliseconds(int.parse(quantity) * 1000);
    default:
      return quantity.toString();
  }
}

String getQuantityByMetricsInText(int? quantity, String metrics) {
  final q = quantity ?? '';
  switch (metrics) {
    case 'REPS':
      return 'x$q';
    case 'MIN':
      return '$q min';
    case 'SEC':
      return '$q sec';
    default:
      return q.toString();
  }
}
