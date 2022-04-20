import 'package:totalfit/model/choose_program/program_workout_item.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/ui/utils/utils.dart';

class ProgramScheduleItem implements FeedItem {
  final String week;
  final String dateRange;
  final List<ScheduledWorkoutItem> workouts;

  ProgramScheduleItem({
    this.week,
    this.dateRange,
    this.workouts,
  });

  @override
  int get hashCode => week.hashCode ^ dateRange.hashCode ^ deepHash(workouts);

  @override
  bool operator ==(Object other) {
    return other is ProgramScheduleItem &&
        runtimeType == other.runtimeType &&
        week == other.week &&
        dateRange == other.dateRange &&
        deepEquals(workouts, other.workouts);
  }
}
