import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/utils/constant.dart';

class TutorialIconWidget extends StatefulWidget {
  final VoidCallback onWatchTutorial;
  final bool show;
  final bool delayDone;
  final double size;

  const TutorialIconWidget({
    required this.delayDone,
    required this.onWatchTutorial,
    this.show = false,
    this.size = 18.0,
    Key? key
  }) : super(key: key);

  @override
  State<TutorialIconWidget> createState() => _TutorialIconWidgetState();
}

class _TutorialIconWidgetState extends State<TutorialIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.show,
      child: AnimatedOpacity(
        duration: Duration(
            milliseconds: widget.delayDone
                ? exerciseFlowTutorialIconAnimationDuration
                : 0),
        opacity: widget.delayDone ? 1.0 : 0.0,
        child: GestureDetector(
          onTap: widget.onWatchTutorial,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            color: Colors.transparent,
            child: Center(
              child: Icon(
                PlaybackIcons.tutorial,
                color: AppColorScheme.colorPrimaryWhite, size: widget.size
              ),
            ),
          ),
        ),
      ),
      replacement: const SizedBox(),
    );
  }
}
