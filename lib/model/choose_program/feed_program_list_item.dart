import 'package:totalfit/data/dto/program_progress_dto.dart';
import 'package:totalfit/data/dto/workout_entry_dto.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/ui/utils/utils.dart';

import '../../../../../../../../data/dto/response/feed_program_list_item_response.dart';

class FeedProgramListItem implements FeedItem {
  final List<String> equipment;
  final String equipmentForFeedUI;
  final String goal;
  final String id;
  final String name;
  final String session;
  final List<LevelType> levels;
  final String levelsForFeedUI;
  final List<WorkoutEntryDto> workouts;
  final bool isActive;
  final String image;
  final ProgramProgressDto programProgress;
  final int maxWeekNumber;

  FeedProgramListItem({
    this.equipment,
    this.equipmentForFeedUI,
    this.goal,
    this.id,
    this.session,
    this.levels,
    this.levelsForFeedUI,
    this.name,
    this.workouts,
    this.isActive,
    this.image,
    this.programProgress,
    this.maxWeekNumber,
  });

  FeedProgramListItem copyWith({
    List<String> equipment,
    String equipmentForFeedUI,
    String goal,
    String id,
    String name,
    String session,
    List<LevelType> levels,
    String levelsForFeedUI,
    List<WorkoutEntryDto> workouts,
    bool isActive,
    String image,
    ProgramProgressDto workoutProgress,
    int maxWeekNumber,
  }) {
    return FeedProgramListItem(
      equipment: equipment ?? this.equipment,
      equipmentForFeedUI: equipmentForFeedUI ?? this.equipmentForFeedUI,
      goal: goal ?? this.goal,
      id: id ?? this.id,
      name: name ?? this.name,
      session: session ?? this.session,
      levels: levels ?? this.levels,
      levelsForFeedUI: levelsForFeedUI ?? this.levelsForFeedUI,
      workouts: workouts ?? this.workouts,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      programProgress: workoutProgress ?? this.programProgress,
      maxWeekNumber: maxWeekNumber ?? this.maxWeekNumber,
    );
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedProgramListItem &&
          runtimeType == other.runtimeType &&
          goal == other.goal &&
          id == other.id &&
          name == other.name &&
          session == other.session &&
          isActive == other.isActive &&
          image == other.image &&
          levelsForFeedUI == other.levelsForFeedUI &&
          maxWeekNumber == other.maxWeekNumber &&
          equipmentForFeedUI == other.equipmentForFeedUI &&
          deepEquals(programProgress, other.programProgress) &&
          deepEquals(levels, other.levels) &&
          deepEquals(workouts, other.workouts) &&
          deepEquals(equipment, other.equipment);

  @override
  int get hashCode =>
      deepHash(equipment) ^
      deepHash(levels) ^
      deepHash(workouts) ^
      programProgress.hashCode ^
      levelsForFeedUI.hashCode ^
      equipmentForFeedUI.hashCode ^
      goal.hashCode ^
      image.hashCode ^
      isActive.hashCode ^
      maxWeekNumber.hashCode ^
      id.hashCode ^
      name.hashCode ^
      session.hashCode;
}
