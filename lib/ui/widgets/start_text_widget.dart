import 'dart:async';

import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class StartTextWidget extends StatefulWidget {
  final VoidCallback onCompleted;
  final bool run;

  StartTextWidget({this.onCompleted, this.run});

  @override
  _StartTextWidgetState createState() => _StartTextWidgetState();
}

class _StartTextWidgetState extends State<StartTextWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool isRunReverse = false;

  @override
  void initState() {
    super.initState();
    _prepareAnimations();
    if (widget.run) {
      controller.forward(from: 1);
    }
  }

  void _prepareAnimations() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isRunReverse) {
          widget?.onCompleted();
          return;
        }

        Timer(Duration(seconds: 1), () {
          if (mounted) {
            controller.reverse();
            isRunReverse = true;
          }
        });
      }
    });
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void didUpdateWidget(StartTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.run != oldWidget.run) {
      controller.forward(from: 1);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Text(
        S.of(context).start.toUpperCase(),
        style: title40.copyWith(
          color: AppColorScheme.colorPrimaryWhite,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
