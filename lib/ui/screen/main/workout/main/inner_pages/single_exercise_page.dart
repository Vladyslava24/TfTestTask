import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:workout_ui/workout_ui.dart' show SkillVideoWidget;

class SingleExercisePage extends StatefulWidget {
  final Exercise exercise;

  SingleExercisePage({@required this.exercise});

  @override
  _SingleExercisePageState createState() => _SingleExercisePageState();
}

class _SingleExercisePageState extends State<SingleExercisePage> {
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
        converter: (store) => _ViewModel.fromStore(store, widget.exercise),
        builder: (context, vm) => _buildContent(vm, context));
  }

  _buildContent(_ViewModel vm, BuildContext context) {
    if (vm.url == null || !vm.url.contains('http')) {
      return Container();
    }
    return WillPopScope(
      onWillPop: () => _onBackPressed(vm),
      child: FutureBuilder(
        future: _setRotationFuture,
        builder: (context, snapshot) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return Scaffold(
                // appBar:
                //     orientation == Orientation.portrait ?
                //       SimpleAppBar(
                //         leadingType: LeadingType.back,
                //         leadingAction: () => _onBackPressed(vm),
                //         title: vm.name,
                //       ) : null,
                backgroundColor: AppColorScheme.colorPrimaryBlack,
                body: FutureBuilder(
                  future: _setRotationFuture,
                  builder: (context, snapshot) {
                    if (snapshot == null ||
                        snapshot.connectionState != ConnectionState.done) {
                      return CircularLoadingIndicator();
                    }

                    return !_isDisposing
                        ? SafeArea(
                          child: SkillVideoWidget(
                              orientation: orientation,
                              url: vm.url,
                              onEndVideoAction: () => _onBackPressed(vm),
                            ),
                        )
                        : CircularLoadingIndicator();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> _onBackPressed(_ViewModel vm) {
    Navigator.of(context).pop();
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

  _ViewModel({
    this.name,
    this.url,
  });

  static _ViewModel fromStore(Store<AppState> store, Exercise exercise) {
    return _ViewModel(name: exercise.name, url: exercise.video480);
  }
}
