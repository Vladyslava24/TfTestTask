/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:core/core.dart';

class SkillTimeIndicator extends StatefulWidget {
  final bool isPaused;

  SkillTimeIndicator({@required this.isPaused, @required Key key})
      : super(key: key);

  @override
  _SkillTimeIndicatorState createState() => _SkillTimeIndicatorState();
}

class _SkillTimeIndicatorState extends State<SkillTimeIndicator> {
  Stream _timer;
  String _time = "00:00";
  StreamSubscription _streamSubscription;
  int workoutTime = 0;
  bool _isPaused;

  @override
  void initState() {
    _isPaused = widget.isPaused;
    _initTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  _initTimer() {
    _timer = Stream.periodic(Duration(milliseconds: 1000));
    _streamSubscription = _timer.listen((event) {
      setState(() {
        workoutTime += 1000;
        _time = timeFromMilliseconds(workoutTime);
      });
    });
  }

  Widget _buildContent() {
    if (_isPaused != widget.isPaused) {
      if (widget.isPaused) {
        _streamSubscription.cancel();
      } else {
        _initTimer();
      }

      _isPaused = widget.isPaused;
    }

    return Text(_time,
        style: const TextStyle(fontSize: 16.0, color: AppColorScheme.colorPrimaryWhite),
        textAlign: TextAlign.center);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
*/
