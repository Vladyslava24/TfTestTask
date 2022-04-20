import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CountdownWidget extends StatefulWidget {
  final int count;
  final VoidCallback onStartCountdown;
  final VoidCallback onCountdownFinished;

  CountdownWidget({
    @required this.count,
    this.onStartCountdown,
    this.onCountdownFinished,
    Key key,
  }) : super(key: key);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  int _countdown;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer?.cancel();
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_countdown < 2) {
            timer.cancel();
            widget?.onCountdownFinished();
          } else {
            _countdown = _countdown - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    _countdown = widget.count;
    widget?.onStartCountdown();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      color: Colors.transparent,
      child: Center(
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final inAnimation =
                Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation);
            final outAnimation =
                Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation);

            if (child.key == ValueKey(_countdown)) {
              return SlideTransition(
                position: inAnimation,
                child: Container(
                  width: screenWidth,
                  child: Center(
                    child: child,
                  ),
                ),
              );
            } else {
              return SlideTransition(
                position: outAnimation,
                child: Container(
                  width: screenWidth,
                  child: Center(
                    child: child,
                  ),
                ),
              );
            }
          },
          child: Text(
            '$_countdown',
            key: ValueKey(_countdown),
            style: textExtraBoldItalic288.copyWith(
              color: AppColorScheme.colorYellow,
            ),
          ),
        ),
      ),
    );
  }
}
