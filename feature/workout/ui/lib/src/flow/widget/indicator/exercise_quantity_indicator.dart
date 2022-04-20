import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/utils/constant.dart';
import 'package:workout_ui/src/utils/exercise_utils.dart';

class ExerciseQuantityIndicator extends StatefulWidget {
  final int id;
  final int quantity;
  final String metrics;
  final String? title;
  final bool isPaused;
  final bool show;
  final bool delayDone;
  final VoidCallback moveToNext;

  const ExerciseQuantityIndicator({
    required this.id,
    required this.quantity,
    required this.metrics,
    required this.title,
    required this.moveToNext,
    this.isPaused = false,
    this.show = true,
    this.delayDone = true,
    Key? key
  }) : super(key: key);

  @override
  State<ExerciseQuantityIndicator> createState() => _ExerciseQuantityIndicatorState();
}

class _ExerciseQuantityIndicatorState extends State<ExerciseQuantityIndicator> {
  String? _timerValue;
  int _remainedTime = 0;
  Stream? _timer;
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void didUpdateWidget(covariant ExerciseQuantityIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id && isShowTimer(widget.metrics)) {
      _streamSubscription?.cancel();
      _initTimer();
    } else {
      _timerValue = _remainedTime > 0 ? _timerValue :
        getQuantityByMetricsInTimer(widget.quantity.toString(), widget.metrics);
    }
  }

  @override
  void dispose() {
    if (isShowTimer(widget.metrics) && _streamSubscription != null) {
      _streamSubscription?.cancel();
    }
    super.dispose();
  }

  int addTimeByMetrics(String metrics) {
    switch(metrics) {
      case 'MIN':
        return 60;
      default:
        return 1;
    }
  }

  bool isShowTimer(String metrics) {
    switch(metrics) {
      case 'SEC':
        return true;
      case 'MIN':
        return true;
      default:
        return false;
    }
  }

  void _initTimer() async {
    _timer = Stream.periodic(const Duration(milliseconds: 1000));
    if (isShowTimer(widget.metrics)) {
      _remainedTime = widget.quantity * 1000 * addTimeByMetrics(widget.metrics);
      _timerValue = timeFromMilliseconds(_remainedTime);

      _streamSubscription = _timer!.listen((event) {
        if (!widget.delayDone) return;

        if (widget.isPaused) {
          return;
        }

        _remainedTime -= 1000;

        if (_remainedTime + 1000 <= 0) {
          setState(() {
            _timerValue = timeFromMilliseconds(_remainedTime);
          });
          _streamSubscription?.cancel();
          widget.moveToNext();

        } else {
          setState(() {
            _timerValue = timeFromMilliseconds(_remainedTime);
          });
        }
      });
    } else {
      _timerValue = timeFromMilliseconds(_remainedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: AnimatedOpacity(
        duration: !widget.delayDone ? Duration.zero : const Duration(
          milliseconds: exerciseFlowQuantityIndicatorAnimationDuration),
        opacity: !widget.isPaused && widget.delayDone ? 1.0 : 0.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                _timerValue != null ?
                  _timerValue! : '',
                style: title42.copyWith(color: AppColorScheme.colorYellow),
                textAlign: TextAlign.center
              ),
              widget.title != null ? Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2
                ),
                child: Text(
                  widget.title!,
                  style: title20.copyWith(color: AppColorScheme.colorPrimaryWhite),
                  textAlign: TextAlign.center,
                ),
              ) : const SizedBox.shrink()
            ],
          ),
        ),
      ),
      visible: widget.show,
      replacement: const SizedBox.shrink()
    );
  }
}



