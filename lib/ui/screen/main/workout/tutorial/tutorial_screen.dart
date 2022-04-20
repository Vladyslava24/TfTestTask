import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/workout_page_type.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart' hide LoadingIndicator;
import 'package:workout_ui/workout_ui.dart' show SkillVideoWidget;

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  bool _isDisposing = false;
  Future<void> _setRotationFuture;

  @override
  void initState() {
    _setRotationFuture = _enableRotation();
    super.initState();
  }

  @override
  void dispose() {
    _setPortraitOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) => _buildContent(vm, context)
    );
  }

  _buildContent(_ViewModel vm, BuildContext context) {
    if (vm.url == null || !vm.url.contains('http')) {
      return Container();
    }
    return WillPopScope(
      onWillPop: () => _moveBack(vm),
      child: SafeArea(
        child: FutureBuilder(
          future: _setRotationFuture,
          builder: (context, snapshot) {
            return OrientationBuilder(
              builder: (context, orientation) {
                return Scaffold(
                  appBar: orientation == Orientation.portrait
                      ? SimpleAppBar(
                          leadingType: LeadingType.back,
                          leadingAction: () => _moveBack(vm),
                          title: vm.name,
                          actionButtonText: S.of(context).all__continue,
                          actionType: vm.isSkillExercise ?
                            ActionType.button : null,
                          buttonWithArrow: true,
                          actionFunction: () =>
                            vm.navigateToSkillExercise(vm.name),
                        )
                      : null,
                  backgroundColor: AppColorScheme.colorBlack,
                  body: FutureBuilder(
                    future: _setRotationFuture,
                    builder: (context, snapshot) {
                      if (snapshot == null || snapshot.connectionState != ConnectionState.done) {
                        return CircularLoadingIndicator();
                      }

                      return !_isDisposing
                          ? SkillVideoWidget(
                              orientation: orientation, url: vm.url, onEndVideoAction: () => _moveBack(vm))
                          : CircularLoadingIndicator();
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<bool> _moveBack(_ViewModel vm) {
    if (vm.isSkillExercise) {
      vm.navigateToSkillExercise(vm.name);
    } else {
      vm.closeTutorial();
      Navigator.of(context).pop();
    }

    return Future.sync(() => true);
  }
}

Future<void> _enableRotation() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

Future<void> _setPortraitOrientation() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class _ViewModel {
  final String name;
  final String url;
  final Function(String) navigateToSkillExercise;
  final Function closeTutorial;
  final isSkillExercise;

  _ViewModel({
    this.name,
    this.url,
    this.closeTutorial,
    this.navigateToSkillExercise,
    this.isSkillExercise,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        isSkillExercise: store.state.workoutState.currentPageType == WorkoutPageType.SKILL,
        closeTutorial: () => store.dispatch(OnCloseTutorialAction()),
        navigateToSkillExercise: (exerciseName) {},
        name: store.state.workoutState.tutorialPage.exercise.name,
        url: store.state.workoutState.tutorialPage.exercise.video480);
  }
}
