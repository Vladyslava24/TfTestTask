import 'package:equatable/equatable.dart';
import 'package:workout_ui/src/model/workout_settings_item.dart';
import 'package:workout_ui/src/preview/list_item/list_items.dart';

class WorkoutPreviewState extends Equatable {
  final List<dynamic> workoutListItems;
  final DownloadStatus? downloadedStatus;
  final List<WorkoutSettingsItem>? listWorkoutSettingItems;

  const WorkoutPreviewState(
      {this.listWorkoutSettingItems,
      required this.workoutListItems,
      this.downloadedStatus = DownloadStatus.notLoaded});

  HeaderItem? getHeader() {
    if (workoutListItems.isEmpty) {
      return null;
    }
    return workoutListItems.singleWhere((element) => element is HeaderItem,
        orElse: () => null);
  }

  WorkoutPreviewState copyWith({
    List<dynamic>? workoutListItems,
    DownloadStatus? downloadedStatus,
    List<WorkoutSettingsItem>? listWorkoutSettingItems
  }){
    return WorkoutPreviewState(
      workoutListItems: workoutListItems ?? this.workoutListItems,
      downloadedStatus: downloadedStatus ?? this.downloadedStatus,
      listWorkoutSettingItems: listWorkoutSettingItems ?? this.listWorkoutSettingItems,
    );
  }

  factory WorkoutPreviewState.initial() => const WorkoutPreviewState(
      workoutListItems: [],
      listWorkoutSettingItems: [],
      downloadedStatus: DownloadStatus.notLoaded);


  @override
  List<Object?> get props =>
      [workoutListItems, downloadedStatus, listWorkoutSettingItems];
}

enum DownloadStatus { notLoaded, loading, loaded }
