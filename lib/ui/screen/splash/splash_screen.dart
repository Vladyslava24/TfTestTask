import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:force_upgrade_service/service.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/splash_screen_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/splash/widgets/logo.dart';
import 'package:totalfit/ui/screen/splash/widgets/logo_positioner.dart';
import 'package:totalfit/ui/screen/splash/widgets/splash_image_widget.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:uni_links/uni_links.dart';

class SplashScreen extends StatefulWidget {
  final SplashLaunchMode launchMode;

  SplashScreen({@required this.launchMode});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin
    implements SplashImagePathProvider {
  static const SPLASH_IMAGE_1 = 'assets/images/splash_image_1.jpg';
  static const SPLASH_IMAGE_2 = 'assets/images/splash_image_2.jpg';
  static const SPLASH_IMAGE_3 = 'assets/images/splash_image_3.jpg';

  static const _images = [SPLASH_IMAGE_1, SPLASH_IMAGE_2, SPLASH_IMAGE_3];
  static const SIGN_IN_APPEARANCE_ANIMATION_DURATION = 700;
  static const IMAGE_PRESENCE_DURATION = 600;

  AnimationController _animationController;
  double _contentOpacity = 0;
  int _currentImageIndex = 0;

  PhotoConfig _lowerImageConfig;
  PhotoConfig _upperImageConfig;

  String _latestLink;

  StreamSubscription _sub;

  @override
  initState() {
    super.initState();
    initPlatformStateForStringUniLinks();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DependencyProvider.get<ForceUpgradeService>();
    });
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    _animationController.dispose();
    _animationController = null;
    super.dispose();
  }

  Future<void> initPlatformStateForStringUniLinks() async {
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        _latestLink = link;
      });
    }, onError: (Object err) {
      if (!mounted) return;
      setState(() {
        _latestLink = null;
      });
    });
  }

  Future _showImageSwitching(int index, Function onSequenceCompleted) {
    return Future.delayed(
        Duration(milliseconds: IMAGE_PRESENCE_DURATION * _images.length),
        () => index + 1).then((incrementedIndex) {
      if (incrementedIndex > _images.length - 1) {
        return Future.sync(() => onSequenceCompleted());
      } else {
        _switchImages();
        return _showImageSwitching(_currentImageIndex, onSequenceCompleted);
      }
    });
  }

  _switchImages() {
    ++_currentImageIndex;
    if (mounted) {
      setState(() {
        _lowerImageConfig.toggle();
        _upperImageConfig.toggle();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: StoreConnector<AppState, _ViewModel>(
            distinct: true,
            converter: _ViewModel.fromStore,
            onInit: (store) {
              store.dispatch(SetupAppOnStartAction(_latestLink));
              store.dispatch(SessionStartAction(
                  time: DateTime.now().millisecondsSinceEpoch));
              if (store.state.preferenceState.isFirstLaunch) {
                store.dispatch(SendFirstLaunchEventAction());
              }

              if (widget.launchMode == SplashLaunchMode.INITIAL) {
                _lowerImageConfig = PhotoConfig(SPLASH_IMAGE_1, true, this);
                _upperImageConfig = PhotoConfig(SPLASH_IMAGE_2, false, this);
              } else {
                _lowerImageConfig = PhotoConfig(SPLASH_IMAGE_1, false, this);
                _upperImageConfig = PhotoConfig(SPLASH_IMAGE_3, true, this);
              }

              _animationController = AnimationController(
                  duration: Duration(
                      milliseconds: SIGN_IN_APPEARANCE_ANIMATION_DURATION),
                  vsync: this)
                ..addListener(() {
                  setState(() {});
                })
                ..addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    store.dispatch(NavigateToEntryScreenAction());
                  }
                });
            },
            onWillChange: (oldVm, newVm) {
              if (oldVm.showWelcomeOnboarding != newVm.showWelcomeOnboarding) {
                if (newVm.showWelcomeOnboarding) {
                  _showSplashImagesIfNeeded();
                }
              }
            },
            builder: (context, vm) => _buildContent(context, vm)),
      ),
    );
  }

  Widget _buildContent(BuildContext context, _ViewModel vm) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: vm.showWelcomeOnboarding
            ? _buildWelcomeOnboardingContent(context)
            : _buildLoadingScreen(context, vm),
      ),
    );
  }

  Widget _buildWelcomeOnboardingContent(BuildContext context) {
    return Container(
      color: AppColorScheme.colorPrimaryBlack,
      child: AnimatedOpacity(
        opacity: _contentOpacity,
        duration: Duration(milliseconds: 200),
        child: Stack(children: <Widget>[
          SplashImage(config: _lowerImageConfig),
          SplashImage(config: _upperImageConfig),
          LogoPositioner(child: Logo()),
        ]),
      ),
    );
  }

  Widget _buildLoadingScreen(BuildContext context, _ViewModel vm) {
    final paddingLeft = ((LOGO_WIDTH - 40) / 2) - 4;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColorScheme.colorPrimaryBlack,
      child: Stack(children: <Widget>[
        LogoPositioner(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Logo(),
            Container(
              padding: EdgeInsets.only(left: paddingLeft),
              child: Visibility(
                visible: vm.isLoading,
                child: CircularLoadingIndicator(),
              ),
            )
          ],
        )),
      ]),
    );
  }

  @override
  String getImagePath() {
    return _images[_currentImageIndex];
  }

  _showSplashImagesIfNeeded() {
    if (_animationController == null) {
      return;
    }
    setState(() {
      _contentOpacity = 1;
    });
    if (widget.launchMode == SplashLaunchMode.INITIAL) {
      _showImageSwitching(_currentImageIndex + 1, () {
        if (_animationController != null) {
          _animationController.forward();
        }
      });
    }
  }
}

enum SplashLaunchMode { INITIAL, COMPLETED }

class _ViewModel {
  final bool isLoading;
  final bool showWelcomeOnboarding;
  final AppLifecycleState appLifecycleState;

  _ViewModel(
      {@required this.isLoading,
      @required this.showWelcomeOnboarding,
      @required this.appLifecycleState});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        isLoading: store.state.splashState.isLoading,
        showWelcomeOnboarding: store.state.splashState.showWelcomeOnboarding,
        appLifecycleState: store.state.appLifecycleState);
  }
}
