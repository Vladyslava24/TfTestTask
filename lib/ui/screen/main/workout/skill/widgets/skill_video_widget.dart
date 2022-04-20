import 'dart:async';

import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:totalfit/ui/screen/main/workout/widgets/play_pause_widget.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:video_player/video_player.dart';

class SkillVideoWidget extends StatefulWidget {
  final String url;
  final Orientation orientation;
  final bool showProgress;
  final Function onEndVideoAction;

  SkillVideoWidget({
    @required this.url,
    @required this.orientation,
    this.showProgress = true,
    this.onEndVideoAction,
  });

  @override
  _SkillVideoWidgetState createState() => _SkillVideoWidgetState();
}

class _SkillVideoWidgetState extends State<SkillVideoWidget> {
  static const PROGRESS_BAR_BOTTOM_PADDING = 32;
  VideoPlayerController _controller;
  StreamController _playBackStream = StreamController.broadcast();
  Future<void> _initializeVideoPlayerFuture;
  VoidCallback _callback;
  VoidCallback _onEndVideoCallback;
  String _playedTime = "00:00";
  String _durationTime = "00:00";
  bool _isPlaying = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    if (widget.showProgress) {
      _callback = () {
        setState(() {
          _playedTime = timeFromDuration(_controller.value.position);
          if (_controller.value.duration != null) {
            _durationTime = timeFromDuration(_controller.value.duration);
          }
        });
      };

      _controller.addListener(_callback);
    }

    _onEndVideoCallback = () {
      if (_controller.value.isInitialized && _controller.value.position == _controller.value.duration) {
        widget.onEndVideoAction?.call();
        _controller.removeListener(_onEndVideoCallback);
      }
    };
    _controller.addListener(_onEndVideoCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _playBackStream.add(Object());
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: AnimatedFadeOutFadeIn(
                          target: Stack(
                            children: <Widget>[
                              _controller.value.size == null
                                  ? Container()
                                  : Positioned(
                                      top: widget.orientation ==
                                              Orientation.portrait
                                          ? (constraints.biggest.height -
                                                      _getProportionalVideoHeight(
                                                          _controller.value
                                                              .aspectRatio,
                                                          widget.orientation)) /
                                                  2 -
                                              PROGRESS_BAR_BOTTOM_PADDING
                                          : 0,
                                      left: 0,
                                      right: 0,
                                      bottom: widget.orientation ==
                                              Orientation.portrait
                                          ? null
                                          : 0,
                                      child: Center(
                                        child: Container(
                                          color: Colors.transparent,
                                          width: widget.orientation ==
                                                  Orientation.landscape
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  _controller.value.aspectRatio
                                              : null,
                                          height: _getProportionalVideoHeight(
                                              _controller.value.aspectRatio,
                                              widget.orientation),
                                          child: VideoPlayer(
                                            _controller
                                          ),
                                        ),
                                      ),
                                    ),
                              Positioned.fill(
                                child: AnimatedOpacity(
                                  opacity: _isPlaying ? 0.0 : 1.0,
                                  duration: Duration(milliseconds: 300),
                                  child: Container(
                                    color: AppColorScheme.colorBlack2,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: (constraints.biggest.height -
                                            PlayPauseWidget.SIZE) /
                                        2 -
                                    PROGRESS_BAR_BOTTOM_PADDING,
                                left: 0,
                                right: 0,
                                child: PlayPauseWidget(
                                  size: PlayPauseWidget.SIZE,
                                  playBackStream: _playBackStream,
                                  onPressed: (isPlaying) {
                                    setState(() {
                                      _isPlaying = isPlaying;
                                      if (_isPlaying) {
                                        _controller.play();
                                      } else {
                                        _controller.pause();
                                      }
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          placeholder: CircularLoadingIndicator(),
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
                      bottom: 24,
                      left: 24,
                      right: 24,
                      child: AnimatedOpacity(
                        opacity:
                            snapshot.connectionState == ConnectionState.done
                                ? 1
                                : 0,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                ),
              ),
            );
          },
        );
      },
    );
  }

  _getProportionalVideoHeight(double aspectRatio, Orientation orientation) {
    if (orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.height;
    }
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / aspectRatio;
  }

  @override
  void dispose() {
    _playBackStream.close();
    _controller.removeListener(_callback);
    _controller.removeListener(_onEndVideoCallback);
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
      if (widget.controller.value.duration != null &&
          widget.controller.value.position != null) {
        final int duration = widget.controller.value.duration.inMilliseconds;
        final int position = widget.controller.value.position.inMilliseconds;
        setState(() {
          _progress = position / duration;
        });
      } else {}
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
          child: VideoProgressIndicator(
            widget.controller,
            allowScrubbing: true,
            padding: EdgeInsets.all(0),
            colors: VideoProgressColors(
              playedColor: AppColorScheme.colorYellow,
            ),
          ),
        ),
        CustomPaint(
          foregroundPainter: ProgressDotPainter(
            color: AppColorScheme.colorYellow,
            progress: _progress,
          ),
        ),
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
