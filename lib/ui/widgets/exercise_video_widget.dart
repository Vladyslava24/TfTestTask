import 'dart:async';

import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:video_player/video_player.dart';

class ExerciseVideoWidget extends StatefulWidget {
  final String url;
  final bool isPlaying;
  final double width;
  final double height;
  final bool showProgress;

  ExerciseVideoWidget(
      {@required this.url,
      @required this.height,
      this.width,
      this.showProgress = true,
      @required this.isPlaying});

  @override
  _ExerciseVideoWidgetState createState() => _ExerciseVideoWidgetState();
}

class _ExerciseVideoWidgetState extends State<ExerciseVideoWidget> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool _currentPlayingState = false;
  VoidCallback _callback;
  String _playedTime = "00:00";
  String _durationTime = "00:00";

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then(
        (value) => Future.delayed(Duration(milliseconds: 1000), () => value));
    _controller.setLooping(true);
    if (widget.showProgress) {
      _callback = () {
        setState(() {
          _playedTime = timeFromDuration(_controller.value.position);
          _durationTime = timeFromDuration(_controller.value.duration);
        });
      };
      _controller.addListener(_callback);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPlayingState != widget.isPlaying) {
      _currentPlayingState = widget.isPlaying;
      if (_currentPlayingState) {
        _controller.play();
      } else {
        _controller.pause();
      }
    }

    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Center(
              child: Container(
                width: widget.width,
                height: widget.height,
                color: AppColorScheme.colorBlack2,
                child: AnimatedFadeOutFadeIn(
                  target: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller)),
                  placeholder: Container(color: AppColorScheme.colorBlack2),
                  isTargetLoaded:
                      snapshot.connectionState == ConnectionState.done,
                  fadeInDuration: Duration(milliseconds: 150),
                  fadeOutDuration: Duration(milliseconds: 150),
                  fadeInCurve: Curves.easeIn,
                  fadeOutCurve: Curves.easeOut,
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 30,
              child: AnimatedOpacity(
                opacity:
                    snapshot.connectionState == ConnectionState.done ? 1 : 0,
                duration: Duration(milliseconds: 500),
                child: widget.showProgress
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          PointedVideoProgressIndicator(
                              controller: _controller),
                          Container(height: 10),
                          Container(
                            padding: EdgeInsets.only(left: 2, right: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  _playedTime,
                                  textAlign: TextAlign.center,
                                  style: textRegular12.copyWith(
                                    color: AppColorScheme.colorBlack7,
                                  ),
                                ),
                                Text(
                                  _durationTime,
                                  textAlign: TextAlign.center,
                                  style: textRegular12.copyWith(
                                    color: AppColorScheme.colorBlack7,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : Container(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_callback);
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }
}

class PointedVideoProgressIndicator extends StatefulWidget {
  final VideoPlayerController controller;

  PointedVideoProgressIndicator({@required this.controller});

  @override
  _PointedVideoProgressIndicator createState() =>
      _PointedVideoProgressIndicator();
}

class _PointedVideoProgressIndicator
    extends State<PointedVideoProgressIndicator> {
  double _progress = 0;
  VoidCallback _callback;

  @override
  void initState() {
    _callback = () {
      final int duration = widget.controller.value.duration.inMilliseconds;
      final int position = widget.controller.value.position.inMilliseconds;
      setState(() {
        _progress = position / duration;
      });
    };
    widget.controller.addListener(_callback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        ClipRRect(
          borderRadius: new BorderRadius.all(Radius.circular(3)),
          child: VideoProgressIndicator(widget.controller,
              allowScrubbing: true,
              padding: EdgeInsets.all(0),
              colors:
                  VideoProgressColors(playedColor: AppColorScheme.colorYellow)),
        ),
        CustomPaint(
            foregroundPainter: ProgressDotPainter(
                color: AppColorScheme.colorYellow, progress: _progress))
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_callback);
    super.dispose();
  }
}

class ProgressDotPainter extends CustomPainter {
  final Color color;
  final double progress;

  ProgressDotPainter({this.color, this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width * progress, size.height / 2), 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
