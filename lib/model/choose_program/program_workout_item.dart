import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/model/profile/list_items.dart';

class ScheduledWorkoutItem implements FeedItem {
  final String dayNumber;
  final String day;
  final bool isToday;
  final bool inPastDays;
  final String workoutDuration;
  final WorkoutProgressDto workoutProgress;
  final DateTime date;

  ScheduledWorkoutItem(
    this.date, {
    this.dayNumber,
    this.day,
    this.isToday,
    this.inPastDays,
    this.workoutDuration,
    this.workoutProgress,
  });

  @override
  int get hashCode => dayNumber.hashCode ^ workoutDuration.hashCode ^ workoutProgress.hashCode;

  @override
  bool operator ==(Object other) {
    return other is ScheduledWorkoutItem &&
        runtimeType == other.runtimeType &&
        dayNumber == other.dayNumber &&
        workoutDuration == other.workoutDuration &&
        workoutProgress == other.workoutProgress;
  }
}
