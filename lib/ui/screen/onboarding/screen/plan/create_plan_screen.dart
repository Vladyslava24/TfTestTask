import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:totalfit/data/dto/onboarding_info_dto.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/onboarding/screen/plan/create_plan_bloc.dart';
import 'package:totalfit/ui/screen/onboarding/model/goal.dart';
import 'package:totalfit/ui/screen/onboarding/model/onboarding_data.dart';
import 'package:totalfit/ui/screen/onboarding/model/reason.dart';
import 'package:rive/rive.dart';
import 'package:totalfit/ui/screen/paywall_screen.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ui_kit/ui_kit.dart';

import '../summary/onboarding_summary_screen.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen();

  @override
  _CreatePlanScreenState createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen>
    with SingleTickerProviderStateMixin {
  Artboard _riveArtBoard;
  StateMachineController _controller;
  SMIInput<double> _progress;
  SMIInput<bool> _start;
  Future _initRive;

  AnimationController _animationController;
  Animation<double> _animation;

  static ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );

  Set<int> _selectedStages = {};
  List<String Function(BuildContext context)> _stages = [
    (c) => S.of(c).create_plan_stage_1,
    (c) => S.of(c).create_plan_stage_2,
    (c) => S.of(c).create_plan_stage_3,
    (c) => S.of(c).create_plan_stage_4
  ];
  int _stagePointer = 0;
  OnPlanCreatedAction onPlanCreatedAction;

  final _bloc = CreatePlanBloc();

  @override
  void initState() {
    _initRive = _initializeRive();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 7500), vsync: this);

    bool _checkForUpdate(double target, int stage) {
      return _animationController.value >= target &&
          !_selectedStages.contains(stage) &&
          _selectedStages.length == stage;
    }

    _updateSelection() {
      setState(() {
        _selectedStages.add(_stagePointer);
        _stagePointer++;
      });
    }

    _animationController.addListener(() {
      if (_checkForUpdate(0.25, 0)) {
        _updateSelection();
        return;
      } else if (_checkForUpdate(0.5, 1)) {
        _updateSelection();
        return;
      } else if (_checkForUpdate(0.75, 2)) {
        _updateSelection();
        return;
      } else if (_checkForUpdate(1.0, 3)) {
        _updateSelection();
        return;
      }
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (onPlanCreatedAction == null) {
          _bloc.add(CancelRequestByTimeoutAction());
        } else {
          Future.delayed(Duration(milliseconds: 150), () {
            final data = Provider.of<OnBoardingData>(context, listen: false);
            Navigator.of(context).push<void>(OnboardingSummaryScreen.route(
                onPlanCreatedAction.programResponse, data));
          });
        }
      }
    });

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.slowMiddle,
    );
    _animation.addListener(() {
      setState(() {
        _progress?.value = _animation.value * 100;
      });
    });

    Future.delayed(Duration(milliseconds: 350), () {
      if (mounted) {
        _createPlan();
      }
    });
    super.initState();
  }

  _createPlan() {
    _animationController.forward(from: 0.0);
    final data = Provider.of<OnBoardingData>(context, listen: false);

    final updateProfileRequest = UpdateProfileRequest(
      height: data.height,
      weight: data.weight,
      birthday: data.birthday,
      firstName: data.name,
      gender: data.gender,
      goalWeight: data.desiredWeight,
      preferredHighMetric: data.preferredHighMetric,
      preferredWeightMetric: data.preferredWeightMetric,
    );

    int weekCount = data.duration;
    String level = data.level?.key;
    List<String> equipment = data.equipment;

    List<String> habits = data.habits;
    List<Goal> goals = data.goals;
    Reason reason = data.reason;

    OnboardingInfoDto onboardingInfo =
        OnboardingInfoDto(reason: reason, habits: habits, goals: goals);
    final currentUser =
        StoreProvider.of<AppState>(context).state.loginState.user;
    _bloc.add(CreatePlanAction(
        currentUser: currentUser,
        onboardingInfo: onboardingInfo,
        updateProfileRequest: updateProfileRequest,
        weekCount: weekCount,
        level: level,
        equipment: equipment));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreatePlanBloc>.value(
      value: _bloc,
      child: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<CreatePlanBloc, CreatePlanBlocEvent>(
              bloc: _bloc,
              child: SizedBox.shrink(),
              listener: (c, action) async {
                if (action is Error) {
                  if (_animationController.isAnimating) {
                    _animationController.stop();
                  }
                  _selectedStages.clear();
                  _stagePointer = 0;
                  _animationController.value = 0.0;
                  final attrs = TfDialogAttributes(
                    title: S.of(context).dialog_error_title,
                    description: action.exception.getMessage(context),
                    negativeText: S.of(context).dialog_error_recoverable_negative_text,
                    positiveText: S.of(context).all__retry,
                  );
                  final result = await TfDialog.show(context, attrs);
                  if (result is Confirm) {
                    _createPlan();
                  }
                } else {
                  onPlanCreatedAction = (action as OnPlanCreatedAction);
                  StoreProvider.of<AppState>(context).dispatch(
                      UpdateUserStateAction(onPlanCreatedAction.updatedUser));
                }
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.width / 1.5,
              child: Stack(
                children: [
                  FutureBuilder<Artboard>(
                      future: _initRive,
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          return Rive(artboard: snapShot.data);
                        }
                        if (snapShot.hasError) {
                          print(snapShot.error);
                        }
                        return SizedBox.shrink();
                      }),
                  Center(
                      child: Text('${(_animation.value * 100).ceil()} %',
                          style: title30.copyWith(color: Colors.white)))
                ],
              ),
            ),
            SizedBox(height: 32),
            AbsorbPointer(
              child: AnimatedItemPicker(
                key: ValueKey(_stagePointer),
                axis: Axis.vertical,
                itemCount: _stages.length,
                multipleSelection: true,
                maxItemSelectionCount: 2,
                initialSelection: _selectedStages,
                onItemPicked: (index, selected) {},
                itemBuilder: (index, animatedValue) {
                  return _buildStageItem(
                      _stages[index](context), index, animatedValue);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildStageItem(String stage, int index, double animValue) {
    return Container(
        height: 64,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
                width: 20,
                height: 20,
                decoration: new BoxDecoration(
                    color: _itemBackgroundColorTween.transform(animValue),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    shape: BoxShape.rectangle),
                child: Icon(Icons.done,
                    size: 20, color: AppColorScheme.colorBlack2)),
            SizedBox(width: 16),
            Text(stage,
                style: title14.copyWith(color: AppColorScheme.colorBlack10),
                textAlign: TextAlign.center),
          ],
        ));
  }

  Future<Artboard> _initializeRive() async {
    return RiveController.getHexagonFile().then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;

        _controller = StateMachineController.fromArtboard(artboard, 'Hexagon');

        if (_controller != null) {
          artboard.addController(_controller);
          _start = _controller.findInput('start');
          _progress = _controller.findInput('progress');
          _start?.value = true;
          _progress?.value = 0.1;
        }
        _riveArtBoard = artboard;
        return artboard;
      },
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }

    if (_riveArtBoard != null) {
      _riveArtBoard.remove();
    }

    _animationController.dispose();
    _bloc.close();

    super.dispose();
  }
}

class RiveController {
  static Completer<ByteData> _fileLoader;

  static Future<ByteData> getHexagonFile() async {
    if (_fileLoader == null) {
      final completer = Completer<ByteData>();
      try {
        final file =
            await rootBundle.load('assets/rive/onboarding_progress_bar.riv');
        completer.complete(file);
      } on Exception catch (e) {
        completer.completeError(e);
        final Future<ByteData> clientFuture = completer.future;
        _fileLoader = null;
        return clientFuture;
      }
      _fileLoader = completer;
    }
    return _fileLoader.future;
  }
}
