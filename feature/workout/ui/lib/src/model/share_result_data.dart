import 'package:workout_ui/src/model/workout_summary_payload.dart';
import 'package:workout_use_case/use_case.dart';

class ShareResultData {
  String totalTime;
  final String image;
  Map<String, int> priorityExercisesDurationMap;
  int? amrapRoundCount;
  int? forTimeRoundCount;
  WorkoutStage priorityStage;
  String priorityStageTime;
  WorkoutStageType priorityStageType;
  WorkoutSummaryPayload? workoutSummaryPayload;

  ShareResultData({
    required this.totalTime,
    required this.forTimeRoundCount,
    required this.priorityExercisesDurationMap,
    required this.amrapRoundCount,
    required this.priorityStage,
    required this.priorityStageTime,
    required this.image,
    required this.priorityStageType,
    this.workoutSummaryPayload
  });

  factory ShareResultData.initialWithPayload(WorkoutSummaryPayload workoutSummaryPayload) {
    return ShareResultData(
        forTimeRoundCount: null,
        image: '',
        totalTime: '',
        amrapRoundCount: null,
        priorityStage: WorkoutStage.IDLE,
        priorityStageTime: '',
        priorityExercisesDurationMap: {},
        priorityStageType: WorkoutStageType.IDLE,
        workoutSummaryPayload: workoutSummaryPayload
    );
  }

  factory ShareResultData.initial() {
    return ShareResultData(
      forTimeRoundCount: null,
      image: '',
      totalTime: '',
      amrapRoundCount: null,
      priorityStage: WorkoutStage.IDLE,
      priorityStageTime: '',
      priorityExercisesDurationMap: {},
      priorityStageType: WorkoutStageType.IDLE,
      workoutSummaryPayload: null
    );
  }
}
