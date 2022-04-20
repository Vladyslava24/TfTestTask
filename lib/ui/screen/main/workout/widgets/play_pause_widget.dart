import 'dart:async';

import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class PlayPauseWidget extends StatefulWidget {
  static const double SIZE = 70;
  final Function(bool) onPressed;
  final StreamController playBackStream;
  final double size;

  PlayPauseWidget({
    @required this.onPressed,
    @required this.playBackStream,
    @required this.size,
  });

  @override
  _PlayPauseWidgetState createState() => _PlayPauseWidgetState();
}

class _PlayPauseWidgetState extends State<PlayPauseWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isPlaying = false;
  double _opacity = 1;
  Timer _timer;
  StreamSubscription _playBackSubscription;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _playBackSubscription = widget.playBackStream.stream.listen((event) {
      if (_opacity == 0) {
        setState(() {
          _opacity = 1;
          _startTimer();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _opacity == 0,
      child: Center(
        child: Container(
          width: widget.size,
          height: widget.size,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 300),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                  if (_isPlaying) {
                    _animationController.forward();
                    _startTimer();
                  } else {
                    _cancelTimer();
                    _animationController.reverse();
                  }
                  widget.onPressed(_isPlaying);
                });
              },
              child: AnimatedIcon(
                size: 50,
                color: AppColorScheme.colorPrimaryWhite,
                icon: AnimatedIcons.play_pause,
                progress: _animationController,
                semanticLabel: '${S.of(context).play}/${S.of(context).play}',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelTimer();
    _playBackSubscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _opacity = 0;
      });
    });
  }

  void _cancelTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      _timer = null;
    }
  }
}
