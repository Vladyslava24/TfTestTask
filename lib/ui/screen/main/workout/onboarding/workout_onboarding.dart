import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/preference_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class WorkoutOnboarding extends StatefulWidget {
  @override
  _WorkoutOnboardingState createState() => _WorkoutOnboardingState();
}

class _WorkoutOnboardingState extends State<WorkoutOnboarding> {
  bool _showStep1 = true;
  bool _showStep2 = false;
  bool _showStep3 = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Stack(
        children: <Widget>[
          Visibility(
              child: _buildStep1Widget(vm),
              visible: _showStep1,
              replacement: const SizedBox.shrink()),
          Visibility(
              child: _buildStep2Widget(vm),
              visible: _showStep2,
              replacement: const SizedBox.shrink()),
          Visibility(
              child: _buildStep3Widget(vm),
              visible: _showStep3,
              replacement: const SizedBox.shrink())
        ],
      );

  Widget _buildStep3Widget(_ViewModel vm) => GestureDetector(
        onTapDown: (details) {
          setState(() {
            _showStep1 = false;
            _showStep2 = false;
            _showStep3 = false;
          });
          vm.hideOnboarding();
        },
        child: Stack(
          children: [
            Container(color: AppColorScheme.colorPrimaryBlack.withOpacity(0.5)),
            Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height - 200,
                  width: 2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox.fromSize(
                            size: Size(double.infinity,
                              MediaQuery.of(context).size.height / 2)),
                          const Icon(OnboardingIcons.onboarding_arrow_left,
                            color: AppColorScheme.colorPrimaryWhite),
                          Container(height: 24),
                          Text(
                            S.of(context).tap_here_or_swipe_prev_exercise,
                            textAlign: TextAlign.center,
                            style: textRegular16.copyWith(
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox.fromSize(
                            size: Size(double.infinity,
                              MediaQuery.of(context).size.height / 2)),
                          const Icon(OnboardingIcons.onboarding_arrow_right,
                            color: AppColorScheme.colorPrimaryWhite),
                          Container(height: 24),
                          Text(
                            S.of(context).tap_here_or_swipe_next_exercise,
                            textAlign: TextAlign.center,
                            style: textRegular16.copyWith(
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildStep2Widget(_ViewModel vm) => Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColorScheme.colorPrimaryBlack.withOpacity(0.5),
              BlendMode.srcOut,
            ), // This one will create the magic
            child: GestureDetector(
              onTapDown: (details) {
                setState(() {
                  _showStep1 = false;
                  _showStep2 = false;
                  _showStep3 = true;
                });
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColorScheme.colorPrimaryBlack,
                      backgroundBlendMode: BlendMode.dstOut,
                    ), // This one will handle background + difference out
                  ),
                  Positioned(
                    left: 6,
                    bottom: 8,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColorScheme.colorRed,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 100,
            bottom: 60,
            child: SizedBox(
              width: 200,
              child: Text(
                S.of(context).tap_here_to_watch_workout,
                textAlign: TextAlign.start,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildStep1Widget(_ViewModel vm) => Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColorScheme.colorPrimaryBlack.withOpacity(0.5),
              BlendMode.srcOut,
            ), // This one will create the magic
            child: GestureDetector(
              onTapDown: (details) {
                setState(() {
                  _showStep1 = false;
                  _showStep2 = true;
                  _showStep3 = false;
                });
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColorScheme.colorPrimaryBlack,
                      backgroundBlendMode: BlendMode.dstOut,
                    ), // This one will handle background + difference out
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColorScheme.colorRed,
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 100,
            child: SizedBox(
              width: 200,
              child: Text(
                S.of(context).tap_here_to_pause_workout,
                textAlign: TextAlign.start,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
          ),
        ],
      );
}

class _ViewModel {
  Function hideOnboarding;

  _ViewModel({this.hideOnboarding});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        hideOnboarding: () => store.dispatch(OnHideWorkoutOnboardingAction()));
  }
}
