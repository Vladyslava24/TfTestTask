import 'dart:async';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:ui_kit/ui_kit.dart';

class TimeIndicator extends StatefulWidget {
  final bool startTimer;
  final bool isPaused;
  final bool reversedTimer;
  final int workoutDuration;
  final int? stageAMRAPDuration;
  final VoidCallback onEndAMRAPStage;
  final Color timerColor;
  final double timerSize;
  final String fontFamily;

  const TimeIndicator({
    Key? key,
    required this.isPaused,
    required this.workoutDuration,
    required this.stageAMRAPDuration,
    required this.onEndAMRAPStage,
    this.reversedTimer = false,
    this.startTimer = true,
    this.timerColor = AppColorScheme.colorPrimaryWhite,
    this.timerSize = 16.0,
    this.fontFamily = 'Roboto',
  }) : super(key: key);

  @override
  _TimeIndicatorState createState() => _TimeIndicatorState();
}

class _TimeIndicatorState extends State<TimeIndicator> {
  late Stream _timer;
  late int _workoutDuration;
  String? _time;
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    _workoutDuration = widget.reversedTimer ?
      widget.stageAMRAPDuration! : widget.workoutDuration;
    if (widget.reversedTimer) _initTimer();
    super.initState();
  }

  @override
  void didUpdateWidget(TimeIndicator oldWidget) {
    if (widget.startTimer && _streamSubscription == null && !widget.reversedTimer) {
      _initTimer();
    } else if (!oldWidget.reversedTimer && widget.reversedTimer) {
      _workoutDuration = widget.stageAMRAPDuration!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _time == null ?
      const SizedBox() :
      AnimatedOpacity(
        duration: Duration.zero,
        opacity: _time != null ? 1.0 : 0.0,
        child: Text(_time!,
          style: TextStyle(
            fontFamily: widget.fontFamily,
            fontSize: widget.timerSize,
            color: widget.timerColor
          ),
          textAlign: TextAlign.center
        ),
      );
  }

  _initTimer() {
    _timer = Stream.periodic(const Duration(milliseconds: 1000));
    _streamSubscription = _timer.listen((event) {
      if (mounted && !widget.isPaused && !widget.reversedTimer) {
        setState(() {
          _time = timeFromMilliseconds(_workoutDuration += 1000);
        });
      } else if (mounted && !widget.isPaused && widget.reversedTimer) {
        if (_workoutDuration - 1000 == 0) {
          widget.onEndAMRAPStage();
          return;
        }

        setState(() {
          _time = timeFromMilliseconds(_workoutDuration -= 1000);
        });
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
