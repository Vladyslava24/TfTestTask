import 'dart:ui';
import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/utils/constant.dart';

class PauseModalWidget extends StatefulWidget {
  final VoidCallback onPlayTap;
  final VoidCallback onQuitWorkout;
  final VoidCallback onWatchTutorial;
  final String title;
  final bool isPaused;

  const PauseModalWidget({
    required this.onPlayTap,
    required this.onQuitWorkout,
    required this.onWatchTutorial,
    required this.title,
    required this.isPaused,
    Key? key
  }) : super(key: key);

  @override
  State<PauseModalWidget> createState() => _PauseModalWidgetState();
}

class _PauseModalWidgetState extends State<PauseModalWidget> with
  SingleTickerProviderStateMixin {
  static const double _blurC = 5.0;

  late AnimationController _animationController;
  late Animation _blurAnimation;
  late Animation _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(
        milliseconds: exerciseFlowPauseAnimationDuration
      ), vsync: this
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
        if (status == AnimationStatus.dismissed) {}
      })
      ..addListener(() {
        setState(() {});
      });

    _blurAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut
    );
    _opacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        0.9,
        curve: Curves.easeOut,
      ),
      reverseCurve: const Interval(
        0.7,
        0.9,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward(from: 0.0);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PauseModalWidget oldWidget) {
    if (oldWidget.isPaused == false && widget.isPaused) {
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPaused ? SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _blurC * _blurAnimation.value,
            sigmaY: _blurC * _blurAnimation.value
          ),
          child: Container(
            color: AppColorScheme.colorPrimaryBlack.withOpacity(0),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 42.0),
                      child: Text(
                        widget.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: title20.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 76.0,
                            height: 76.0,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: AppColorScheme.colorBlack10.withOpacity(0.1),
                              highlightColor: Colors.transparent,
                              child: const Icon(
                                PlaybackIcons.play,
                                color: AppColorScheme.colorPrimaryWhite,
                                size: 44,
                              ),
                              onTap: () async {
                                await _animationController.reverse(from: 1.0);
                                widget.onPlayTap();
                              }
                            ),
                          ),
                        ),
                        Text(
                          S.of(context).all__continue.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: title14.copyWith(
                            color: AppColorScheme.colorPrimaryWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        // Container(height: 16.0),
                        // TransparentButton(
                        //   text: _getSoundButtonTitle(vm.audioMode),
                        //   iconData: _getSoundButtonIcon(vm.audioMode),
                        //   onTap: () => vm.switchAudioMode(),
                        // ),
                        Container(height: 16.0),
                        BaseTransparentButton(
                          text: S.of(context).quit_workout.toUpperCase(),
                          iconData: Icons.clear,
                          onTap: () async {
                            final attrs = TfDialogAttributes(
                              title: S.of(context).dialog_quit_workout_title,
                              description: S.of(context).dialog_quit_workout_description,
                              negativeText: S.of(context).dialog_quit_workout_negative_text,
                              positiveText: S.of(context).all__continue,
                            );
                            final result = await TfDialog.show(context, attrs);
                            if (result is Cancel) {
                              widget.onQuitWorkout();
                            }
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ) : const SizedBox();
  }
}
