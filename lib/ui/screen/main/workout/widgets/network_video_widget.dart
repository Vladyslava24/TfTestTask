import 'dart:io';

import 'package:video_player/video_player.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/file/file_helper.dart';

class NetworkVideoWidget extends StatefulWidget {
  final double width;
  final double height;
  final bool looping;
  final VoidCallback onReady;
  final Exercise exercise;
  final VoidCallback scrollToNextPage;
  final VoidCallback scrollToPreviousPage;
  final bool playOnStart;

  NetworkVideoWidget(
      {@required this.height,
      @required this.exercise,
      @required this.width,
      @required this.looping,
      this.onReady,
      @required this.scrollToNextPage,
      this.scrollToPreviousPage,
      this.playOnStart = true,
      Key key})
      : super(key: key);

  @override
  _NetworkVideoWidgetState createState() => _NetworkVideoWidgetState();
}

class _NetworkVideoWidgetState extends State<NetworkVideoWidget> {
  VideoPlayerController _controller;
  LoadingState _loadingState = LoadingState.Loading;
  bool _isInitialized = false;

  Future<String> get _documentsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store, _isInitialized),
        onInit: (store) {},
        onWillChange: (previousVm, newVm) {
          if (_isInitialized || previousVm.pausedExercise != newVm.pausedExercise) {
            if (newVm.pausedExercise == widget.exercise) {
              _controller.pause();
            } else {
              if (widget.playOnStart) {
                _controller.play();
              }
            }
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    final name = Uri.parse(widget.exercise.videoVertical).pathSegments.last;
    Future.delayed(Duration(milliseconds: Platform.isIOS ? 55 : 100), () async {
      if (mounted) {
        if (_controller == null) {
          String documentsPath = await _documentsPath;
          _controller = VideoPlayerController.file(File('$documentsPath/$VIDEO_DIRECTORY/$name'),
              videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
          _controller.initialize().then((_) {
            setState(() {
              _isInitialized = true;
              widget.onReady();
              _loadingState = LoadingState.Success;
            });
          }).catchError((e) {
            print(e);
          });
          _controller.setLooping(widget.looping);
          if (widget.playOnStart) {
            _controller.play();
          }
        }
      }
    });

    return _showVideo();
  }

  Widget _showVideo() => GestureDetector(
        onTapDown: (details) {
          if (details.globalPosition.dx > MediaQuery.of(context).size.width - 50) {
            widget?.scrollToNextPage();
          }
          if (details.globalPosition.dx < 50) {
            widget?.scrollToPreviousPage();
          }
        },
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            if (widget.scrollToPreviousPage != null) {
              widget.scrollToPreviousPage();
            }
          } else if (details.delta.dx < 0) {
            //right swipe
            if (widget.scrollToNextPage != null) {
              widget.scrollToNextPage();
            }
          }
        },
        child: Center(
          child: Container(
            width: widget.width,
            height: widget.height,
            color: AppColorScheme.colorBlack2,
            child: AnimatedFadeOutFadeIn(
              target: _controller == null
                  ? Container()
                  : Stack(
                      children: <Widget>[
                        SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _controller.value.size?.width ?? 0,
                              height: _controller.value.size?.height ?? 0,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                        //FURTHER IMPLEMENTATION
                      ],
                    ),
              placeholder: CircularLoadingIndicator(),
              isTargetLoaded: _loadingState == LoadingState.Success,
              fadeInDuration: Duration(milliseconds: 200),
              fadeOutDuration: Duration(milliseconds: 200),
              fadeInCurve: Curves.easeIn,
              fadeOutCurve: Curves.easeOut,
            ),
          ),
        ),
      );

  @override
  void dispose() {
    if (_controller != null) {
      int start = DateTime.now().millisecondsSinceEpoch;
      _controller.dispose().then((value) => print("dispose ${DateTime.now().millisecondsSinceEpoch - start}"));
    }
    super.dispose();
  }
}

class _ViewModel {
  Exercise pausedExercise;
  WorkoutDto currentWorkout;
  bool isInitialized;

  _ViewModel({
    this.isInitialized,
    this.pausedExercise,
    this.currentWorkout,
  });

  static _ViewModel fromStore(Store<AppState> store, bool isInitialized) {
    return _ViewModel(
        isInitialized: isInitialized,
        pausedExercise: store.state.workoutState == null ? null : store.state.workoutState.pausedExercise,
        currentWorkout: store.state.workoutState.workout);
  }
}

enum LoadingState { Loading, Error, Success }
