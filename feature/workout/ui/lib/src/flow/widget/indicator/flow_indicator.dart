import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/widget/indicator/exercise_progress_indicator.dart';
import 'package:workout_ui/src/flow/widget/indicator/time_indicator.dart';

class FlowIndicator extends StatefulWidget {
  final bool enabledSegmentIndicator;
  final bool enabledPauseControl;
  final bool enabledTimer;
  final bool reversedTimer;
  final int? stageAMRAPDuration;
  final bool enabledFlowIndicator;
  final bool isPaused;
  final int segmentCount;
  final int selectedSegment;
  final List<int> rests;
  final VoidCallback onPause;
  final String? nextExerciseName;
  final String nextButtonText;
  final ButtonType nextButtonType;
  final VoidCallback? nextButtonAction;
  final IndicatorType? segmentIndicatorType;
  final VoidCallback onEndAMRAPStage;

  const FlowIndicator({
    required this.segmentCount,
    required this.selectedSegment,
    required this.onPause,
    required this.nextButtonAction,
    required this.segmentIndicatorType,
    required this.stageAMRAPDuration,
    required this.onEndAMRAPStage,
    this.enabledSegmentIndicator = false,
    this.enabledPauseControl = false,
    this.enabledTimer = false,
    required this.reversedTimer,
    this.isPaused = false,
    this.enabledFlowIndicator = true,
    this.rests = const [],
    this.nextButtonType = ButtonType.none,
    this.nextButtonText = '',
    this.nextExerciseName,
    Key? key
  }) : super(key: key);

  @override
  _FlowIndicatorState createState() => _FlowIndicatorState();
}

class _FlowIndicatorState extends State<FlowIndicator> {
  static const double _maxHeight = 52.0;

  @override
  Widget build(BuildContext context) {
    return widget.enabledFlowIndicator ? SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 16.0),
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      AnimatedOpacity(
                        opacity: widget.enabledPauseControl ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            splashColor:
                            AppColorScheme.colorBlack10.withOpacity(0.1),
                            highlightColor: Colors.transparent,
                            onTap: () => widget.onPause(),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 16.0, right: 8.0),
                              child: const Icon(
                                Icons.pause,
                                color: AppColorScheme.colorPrimaryWhite,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: widget.enabledTimer ? 1.0 : 0.0,
                        duration: Duration.zero,
                        child: TimeIndicator(
                          stageAMRAPDuration: widget.stageAMRAPDuration,
                          isPaused: widget.isPaused,
                          onEndAMRAPStage: widget.onEndAMRAPStage,
                          key: const ValueKey('_time_indicator'),
                          startTimer: true,
                          workoutDuration: 0,
                        ),
                      ),
                    ]
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: widget.nextButtonType == ButtonType.none ?
                  const SizedBox() :
                  BaseTextButton(
                    text: widget.nextButtonType == ButtonType.rest ?
                      widget.nextButtonText : widget.nextExerciseName,
                    action: widget.nextButtonAction,
                    textColor:
                      widget.nextButtonType == ButtonType.exercise ?
                        AppColorScheme.colorPrimaryWhite :
                        AppColorScheme.colorYellow,
                    arrowColor:
                      widget.nextButtonType == ButtonType.exercise ?
                      AppColorScheme.colorPrimaryWhite :
                      AppColorScheme.colorYellow,
                    withArrow: true
                  ),
                )
              ],
            ),
            widget.segmentIndicatorType != null ?
              Container(
                constraints: const BoxConstraints(
                  maxHeight: _maxHeight
                ),
                margin: EdgeInsets.only(
                  top: widget.segmentIndicatorType == IndicatorType.circular ?
                    32.0 : 0.0),
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ExerciseProgressIndicator(
                        type: widget.segmentIndicatorType!,
                        segmentCount: widget.segmentCount,
                        selectedSegment: widget.selectedSegment,
                        rests: widget.rests,
                      ),
                      widget.segmentIndicatorType == IndicatorType.circular ?
                        AnimatedOpacity(
                          opacity: widget.enabledSegmentIndicator &&
                            widget.enabledTimer ? 1.0 : 0.0,
                          duration: Duration.zero,
                          child: Center(
                            child: TimeIndicator(
                              stageAMRAPDuration: widget.stageAMRAPDuration,
                              reversedTimer: widget.reversedTimer,
                              isPaused: widget.isPaused,
                              onEndAMRAPStage: widget.onEndAMRAPStage,
                              key: const ValueKey('_time_back_indicator'),
                              startTimer: true,
                              workoutDuration: 0,
                              timerSize: 20,
                              timerColor: AppColorScheme.colorYellow,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ) : const SizedBox()
                    ],
                  ),
                ),
              ) : const SizedBox(),
          ],
        ),
      ),
    ) : const SizedBox();
  }
}

enum ButtonType { exercise, rest, none }
