import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/common/time_utils.dart';
import 'package:workout_use_case/use_case.dart';

class ResultHeaderItemWidget extends StatelessWidget {
  final String image;
  final String totalTime;
  final String priorityStageTime;
  final WorkoutStageType priorityStageType;

  final Map<String, int> exerciseDurationMap;
  final int? amrapRoundCount;
  final int? forTimeRoundCount;
  final WorkoutStage priorityStage;
  final GlobalKey shareContentKey;

  const ResultHeaderItemWidget({
    required this.shareContentKey,
    required this.image,
    required this.totalTime,
    required this.amrapRoundCount,
    required this.forTimeRoundCount,
    required this.exerciseDurationMap,
    required this.priorityStage,
    required this.priorityStageTime,
    required this.priorityStageType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: shareContentKey,
      child: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.85,
              child: TfImage(url: image)),
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Time',
                  style:
                      textRegular14.copyWith(color: AppColorScheme.colorBlack7),
                ),
                Text(
                  totalTime,
                  style: title14,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  priorityStage == WorkoutStage.WOD ? "WORKOUT OF THE DAY" : fromWorkoutStageEnumToString(priorityStage),
                  style: title20,
                ),
                Text(
                  amrapRoundCount != null
                      ? fromWorkoutStageTypeEnumToString(priorityStageType)
                      : fromWorkoutStageTypeEnumToString(priorityStageType, forUI: true),
                  style:
                      textRegular14.copyWith(color: AppColorScheme.colorBlack7),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: exerciseDurationMap.entries
                          .map(
                            (e) => Row(
                              children: [
                                Text(
                                  '${TimeUtils.formatExerciseDuration(e.value)}',
                                  style: title14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  e.key,
                                  style: textRegular14,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    priorityStageType == WorkoutStageType.AMRAP
                        ? _showAmrapResult()
                        : Column(
                            children: [
                              Text(
                                'Result',
                                style: title20,
                              ),
                              Text(
                                priorityStageTime,
                                style: title20,
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showAmrapResult() {
    return Column(
      children: [
        Text(
          'Result',
          style: title20,
        ),
        Text(
          '$amrapRoundCount',
          style: title20,
        ),
        Text(
          'Rounds',
          style: textRegular14.copyWith(color: AppColorScheme.colorBlack7),
        ),
      ],
    );
  }
}
