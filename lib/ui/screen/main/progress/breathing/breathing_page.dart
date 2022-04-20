import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/loading_state/breathing_page_state.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class BreathingPage extends StatefulWidget {
  final int progressPageIndex;
  final String video;

  const BreathingPage({@required this.progressPageIndex, @required this.video});

  @override
  _BreathingPageState createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {
  VideoPlayerController _videoController;

  double opacityLevel = 0.0;

  int overlayDelay = 3000;

  static const int titleAnimationDuration = 500;

  void _activatedControls() {
    setState(() {
      opacityLevel = 1.0;
    });
  }

  void _deactivatedControls() {
    Future.delayed(Duration(milliseconds: overlayDelay)).then((_) {
      if (mounted)
        setState(() {
          opacityLevel = 0.0;
        });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StoreProvider.of<AppState>(context).dispatch(ChangeBreathingPageState(BreathingPageState.LOADING));
    });

    try {
      _videoController = VideoPlayerController.network(widget.video);
      _videoController
        ..initialize().then((_) {
          _videoController.play();
          StoreProvider.of<AppState>(context).dispatch(ChangeBreathingPageState(BreathingPageState.INITIAL));
          setState(() {});
        });

      _videoController.addListener(() {
        if (_videoController.value.hasError) {
          StoreProvider.of<AppState>(context).dispatch(
            ChangeBreathingPageState(BreathingPageState.error(_videoController.value.errorDescription)),
          );
        }
        if ((!_videoController.value.isPlaying && _videoController.value.isInitialized) &&
            (_videoController.value.duration == _videoController.value.position)) {
          StoreProvider.of<AppState>(context)
              .dispatch(SaveBreathingResultAction(progressPageIndex: widget.progressPageIndex));
        }
      });
    } catch (e) {
      StoreProvider.of<AppState>(context).dispatch(ChangeBreathingPageState(BreathingPageState.error(e)));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  _backToPrevious(BuildContext context, _ViewModel vm) {
    vm.onChangeBreathingPageState(BreathingPageState.error(null));
    setState(() {
      _videoController.pause();
    });
    print(widget.progressPageIndex);
    vm.onCompleteBreathingAction(widget.progressPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store, widget.progressPageIndex),
        onInit: (store) {
          Wakelock.enable();
        },
        onWillChange: (oldVm, newVm) {
          if (oldVm.breathingPageState != newVm.breathingPageState) {
            if (newVm.breathingPageState.isError()) {
              final attrs = TfDialogAttributes(
                  description: newVm.breathingPageState.getErrorMessage(), positiveText: S.of(context).all__OK);
              Future dialog = TfDialog.show(context, attrs);
              dialog.then((_) {
                Navigator.of(context).pop();
              });
            }

            if (newVm.breathingPageState == BreathingPageState.COMPLETED) {
              print('Completed');
              Navigator.of(context).pop();
            }
          }
        },
        onDispose: (store) {
          Wakelock.disable();
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    return Scaffold(
      backgroundColor: AppColorScheme.colorBlue,
      body: WillPopScope(
        onWillPop: () => _backToPrevious(context, vm),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            _activatedControls();
          },
          onTapUp: (TapUpDetails details) {
            _deactivatedControls();
          },
          child: vm.breathingPageState == BreathingPageState.LOADING
              ? _progressIndicator()
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [_buildVideoPlayer(), _buildVideoControls(vm)],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return _videoController.value.isInitialized
        ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size?.width ?? 0,
                height: _videoController.value.size?.height ?? 0,
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
              ),
            ),
          )
        : SizedBox.shrink();
  }

  Widget _buildVideoControls(_ViewModel vm) {
    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: const Duration(milliseconds: titleAnimationDuration),
      child: SizedBox.expand(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColorScheme.colorPrimaryBlack.withOpacity(0.2),
          child: Stack(
            children: [
              Positioned(
                bottom: 48.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 82.0,
                          color: AppColorScheme.colorPrimaryWhite,
                          onPressed: () {
                            _activatedControls();
                            setState(() {
                              _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
                            });
                            _deactivatedControls();
                          },
                          icon: SvgPicture.asset(
                            _videoController.value.isPlaying ? pauseIcon : playIcon,
                          )),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 32.0,
                right: 24.0,
                child: IconButton(
                    icon: SvgPicture.asset(
                      closeIcon,
                      width: 36.0,
                      height: 36.0,
                    ),
                    onPressed: () => _backToPrevious(context, vm)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _progressIndicator() {
    return Visibility(child: DimmedCircularLoadingIndicator(), visible: true, replacement: SizedBox.shrink());
  }
}

class _ViewModel {
  Function(int) onCompleteBreathingAction;
  Function onChangeBreathingPageState;
  BreathingPageState breathingPageState;

  _ViewModel(
      {@required this.onCompleteBreathingAction,
      @required this.onChangeBreathingPageState,
      @required this.breathingPageState});

  static _ViewModel fromStore(Store<AppState> store, int progressPageIndex) {
    return _ViewModel(
      onCompleteBreathingAction: (index) => store.dispatch(SaveBreathingResultAction(progressPageIndex: index)),
      onChangeBreathingPageState: (breathingPageState) => store.dispatch(ChangeBreathingPageState(breathingPageState)),
      breathingPageState: store.state.mainPageState.breathingPageState,
    );
  }
}
