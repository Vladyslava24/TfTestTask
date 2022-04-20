import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:video_player/video_player.dart';
import 'package:workout_ui/src/flow/utils/constant.dart';
import 'package:workout_ui/src/flow/workout_flow_cubit.dart';
import 'package:workout_ui/src/flow/workout_flow_screen.dart';
import 'package:workout_ui/src/utils/exercise_utils.dart';
import 'package:workout_use_case/use_case.dart';

class ExercisePage extends StatefulWidget {
  final VoidCallback onNext;
  final ExerciseModel exercise;
  final VoidCallback onDelayDone;
  final String hintTitle;

  const ExercisePage({
    required this.exercise,
    required this.onNext,
    required this.onDelayDone,
    this.hintTitle = '',
    Key? key
  }) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final _videoDirectory = 'video';
  bool _appeared = false;
  late Future<VideoPlayerController> _future;
  VideoPlayerController? _videoPlayerController;

  Future<String> get _documentsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  void initState() {
    super.initState();
    _future = Future(() async {
      String documentsPath = await _documentsPath;
      final eName = Uri.parse(widget.exercise.videoVertical).pathSegments.last;
      _videoPlayerController = VideoPlayerController.file(
          File('$documentsPath/$_videoDirectory/$eName'),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true, allowBackgroundPlayback: true));
      await _videoPlayerController?.setLooping(true);
      await _videoPlayerController?.setVolume(0.0);
      await _videoPlayerController?.initialize();
      return _videoPlayerController!;
    });
  }

  @override
  dispose() async {
    super.dispose();
    try {
      final controller = await _future;
      controller.dispose();
    } catch (e) {
      //ignore..
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VideoPlayerController>(
        future: _future,
        builder: (context, snapshot) {
          VideoPlayerController controller;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            controller = snapshot.data!;
          } else {
            return Container(color: AppColorScheme.colorBlack2);
          }

          final isPaused = context.watch<WorkoutFlowCubit>().state.isPaused;
          if(isPaused) {
            controller.pause();
          } else {
            controller.play();
          }

          return Container(
            color: AppColorScheme.colorBlack,
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedFadeOutFadeIn(
                    target: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: controller.value.size.width,
                              height: controller.value.size.height,
                              child: VideoPlayer(controller),
                            ),
                          ),
                        ),
                      ],
                    ),
                    placeholder: const SizedBox.shrink(),
                    isTargetLoaded: true,
                    fadeInDuration: const Duration(milliseconds: 200),
                    fadeOutDuration: const Duration(milliseconds: 200),
                    fadeInCurve: Curves.easeIn,
                    fadeOutCurve: Curves.easeOut,
                  ),
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: !_appeared,
                    child: _ExerciseAppearance(
                      hintTitle: widget.hintTitle,
                      exerciseModel: widget.exercise,
                      onComplete: () {
                        setState(() {
                          _appeared = true;
                        });
                        widget.onDelayDone();
                      },
                      onStarted: () {
                        setState(() {});
                        controller.play();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ExerciseAppearance extends StatefulWidget {
  final VoidCallback onStarted;
  final VoidCallback onComplete;
  final ExerciseModel exerciseModel;
  final String hintTitle;

  const _ExerciseAppearance(
      {required this.onStarted,
      required this.onComplete,
      required this.exerciseModel,
      this.hintTitle = '',
      Key? key})
      : super(key: key);

  @override
  _ExerciseAppearanceState createState() => _ExerciseAppearanceState();
}

class _ExerciseAppearanceState extends State<_ExerciseAppearance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideCurtainAnimation;
  late Animation<double> _curtainOpacityAnimation;
  late Animation<double> _colorCurtainBgAnimation;
  late Animation<double> _fadeOutCurtainAnimation;
  AnimationStatus? _animationStatus;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: exerciseFlowAnimationDuration), vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (_animationStatus != AnimationStatus.completed &&
          status == AnimationStatus.completed) {
        widget.onComplete();
      }
      _animationStatus = status;
    });

    _slideCurtainAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeIn),
      ),
    );

    _curtainOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.75, curve: Curves.easeIn),
      ),
    );

    _colorCurtainBgAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeIn),
      ),
    );

    _fadeOutCurtainAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );

    Future.delayed(
        const Duration(milliseconds: exercisePageTransitionDurationMillis), () {
      if (mounted) {
        _controller.forward();
        widget.onStarted();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeOutCurtainAnimation,
      child: Stack(
        children: [
          Positioned.fill(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(_slideCurtainAnimation),
              child: Container(
                color: AppColorScheme.colorBlack
                    .withOpacity(_curtainOpacityAnimation.value),
              ),
            ),
          ),
          Positioned.fill(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(1, 0),
              ).animate(_slideCurtainAnimation),
              child: Container(
                color: ColorTween(
                  begin: AppColorScheme.colorBlack2,
                  end: AppColorScheme.colorBlack7,
                )
                    .evaluate(_slideCurtainAnimation)!
                    .withOpacity(_colorCurtainBgAnimation.value),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.hintTitle, style: textRegular12),
                const SizedBox(height: 16),
                Text(
                  widget.exerciseModel.name,
                  style: title30,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(getQuantityByMetricsInText(
                  widget.exerciseModel.quantity,
                  widget.exerciseModel.metrics
                ),
                style: title30.copyWith(color: AppColorScheme.colorYellow)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
