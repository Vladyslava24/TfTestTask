import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/redux/selectors/progress_selectors.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class TimeIndicator extends StatefulWidget {
  final bool startTimer;
  final bool isPaused;

  TimeIndicator({
    @required Key key,
    @required this.isPaused,
    this.startTimer = true,
  }) : super(key: key);

  @override
  _TimeIndicatorState createState() => _TimeIndicatorState();
}

class _TimeIndicatorState extends State<TimeIndicator> {
  Stream _timer;
  String _time;
  StreamSubscription _streamSubscription;
  int _workoutDuration;

  @override
  void didUpdateWidget(TimeIndicator oldWidget) {
    if (widget.startTimer && _streamSubscription == null) {
      _initTimer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          WorkoutProgressDto progress = selectProgress(store, store.state.workoutState.workout);
          if (progress == null || progress.workoutDuration == null) {
            _workoutDuration = 0;
          } else {
            _workoutDuration = selectProgress(store, store.state.workoutState.workout).workoutDuration;
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  _initTimer() {
    _timer = Stream.periodic(Duration(milliseconds: 1000));
    _streamSubscription = _timer.listen((event) {
      if (mounted && !widget.isPaused && _workoutDuration != null) {
        setState(() {
          _time = timeFromMilliseconds(_workoutDuration += 1000);
        });
      }
    });
  }

  Widget _buildContent(_ViewModel vm) {
    return _time == null
        ? Container()
        : AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: _time != null ? 1.0 : 0.0,
            child: Text(_time,
                style: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite), textAlign: TextAlign.center),
          );
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
    }
    super.dispose();
  }
}

class _ViewModel {
  _ViewModel();

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}
