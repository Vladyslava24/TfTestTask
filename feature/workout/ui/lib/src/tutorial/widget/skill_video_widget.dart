import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:video_player/video_player.dart';

class SkillVideoWidget extends StatefulWidget {
  final String url;
  final Orientation orientation;
  final bool showProgress;
  final Function? onEndVideoAction;

  const SkillVideoWidget({
    required this.url,
    required this.orientation,
    this.showProgress = true,
    this.onEndVideoAction,
    Key? key
  }) : super(key: key);

  @override
  _SkillVideoWidgetState createState() => _SkillVideoWidgetState();
}

class _SkillVideoWidgetState extends State<SkillVideoWidget> {
  late VideoPlayerController _controller;
  late VoidCallback _onEndVideoCallback;
  late ChewieController _chewieController;
  late Future<void> _future;

  static const double _defaultAspectRatio = 16 / 9;
  static const double _defaultMinDelta = -30.0;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    _future = initVideoPlayer();
    super.initState();
  }

  Future<void> initVideoPlayer() async {
    await _controller.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        aspectRatio: _defaultAspectRatio,
        looping: false,
        autoInitialize: true,
        allowedScreenSleep: false,
        fullScreenByDefault: false,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        cupertinoProgressColors: ChewieProgressColors(
          bufferedColor: AppColorScheme.colorBlack3,
          backgroundColor: AppColorScheme.colorBlack2,
          playedColor: AppColorScheme.colorYellow,
          handleColor: AppColorScheme.colorYellow,
        ),
        materialProgressColors: ChewieProgressColors(
          bufferedColor: AppColorScheme.colorBlack3,
          backgroundColor: AppColorScheme.colorBlack2,
          playedColor: AppColorScheme.colorYellow,
          handleColor: AppColorScheme.colorYellow,
        ),
        additionalOptions: (BuildContext context) {
          return <OptionItem>[
            OptionItem(
              onTap: () {
                if (_chewieController.isFullScreen) {
                  _chewieController.exitFullScreen();
                }
                Navigator.of(context).pop();
                widget.onEndVideoAction!();
              },
              iconData: Icons.exit_to_app,
              title: 'Close'
            )
          ];
        },
        errorBuilder: (context, errorMessage) {
          return const Center(
            child: Text('Error')
          );
        }
      );
    });

    _onEndVideoCallback = () {
      if (_chewieController.videoPlayerController.value.isInitialized &&
          _chewieController.videoPlayerController.value.position ==
          _chewieController.videoPlayerController.value.duration) {
        widget.onEndVideoAction?.call();
        _controller.removeListener(_onEndVideoCallback);
      }
    };
    _controller.addListener(_onEndVideoCallback);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: _controller.value.isInitialized ? Center(
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    if (details.delta.dy < _defaultMinDelta &&
                        details.delta.dx == 0.0) {
                      widget.onEndVideoAction?.call();
                    }
                  },
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
              ) : const Center(
                child: CircularLoadingIndicator()
              ),
            );
          },
        );
      }
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onEndVideoCallback);
    _controller.pause();
    _controller.dispose();
    _chewieController.pause();
    _chewieController.dispose();
    super.dispose();
  }
}