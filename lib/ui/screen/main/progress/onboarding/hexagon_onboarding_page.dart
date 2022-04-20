import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/hint.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/preference_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/fifth_step_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/first_step_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/hint_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/second_step_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/sixth_step_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/third_step_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/fourth_step_onboarding_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class HexagonOnBoardingPage extends StatefulWidget {
  final int index;
  final String video;

  const HexagonOnBoardingPage({@required this.index, @required this.video, Key key}) : super(key: key);

  @override
  _HexagonOnBoardingPageState createState() => _HexagonOnBoardingPageState();
}

class _HexagonOnBoardingPageState extends State<HexagonOnBoardingPage> {
  final List<Widget> _screens = [];

  int activeIndex = 0;

  double opacity = 1.0;

  List<Hint> _hints = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _screens.addAll([
        FirstStepOnBoardingWidget(
          body: 100.0,
          mind: 100.0,
          spirit: 100.0,
        ),
        SecondStepOnBoardingWidget(
          body: 100.0,
          mind: 0.0,
          spirit: 0.0,
        ),
        ThirdStepOnBoardingWidget(
          body: 0.0,
          mind: 100.0,
          spirit: 0.0,
        ),
        FourthStepOnBoardingWidget(
          body: 0.0,
          mind: 0.0,
          spirit: 100.0,
        ),
        FifthStepOnBoardingWidget(
          body: 0.0,
          mind: 0.0,
          spirit: 100.0,
        ),
      ]);
      _hints.addAll([
        Hint(
            title: S.of(context).hexagon_onboarding_hint_title_one,
            description: S.of(context).hexagon_onboarding_hint_description_one),
        Hint(
            title: S.of(context).hexagon_onboarding_hint_title_two,
            description: S.of(context).hexagon_onboarding_hint_description_two),
        Hint(
            title: S.of(context).hexagon_onboarding_hint_title_three,
            description: S.of(context).hexagon_onboarding_hint_description_three),
        Hint(
            title: S.of(context).hexagon_onboarding_hint_title_four,
            description: S.of(context).hexagon_onboarding_hint_description_four),
        Hint(
            title: S.of(context).hexagon_onboarding_hint_title_five,
            description: S.of(context).hexagon_onboarding_hint_description_five),
      ]);
    });
  }

  void doNextStep(_ViewModel vm) async {
    setState(() {
      opacity = 0.0;
    });
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      if (activeIndex + 1 == _screens.length) {
        vm.updateShowHexagonOnBoardingAction(false);
        vm.navigateToMainScreen();
        activeIndex = 0;
      } else {
        activeIndex++;
      }
      opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store, widget.index),
        builder: (context, vm) => Scaffold(
              backgroundColor: AppColorScheme.colorBlack,
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    _screens.isNotEmpty
                        ? SingleChildScrollView(physics: NeverScrollableScrollPhysics(), child: _screens[activeIndex])
                        : SizedBox.shrink(),
                    _hints.isNotEmpty
                        ? Positioned(
                            bottom: 112.0,
                            left: 16.0,
                            right: 16.0,
                            child: AnimatedOpacity(
                              opacity: opacity,
                              duration: const Duration(milliseconds: 400),
                              child: HintOnBoardingWidget(
                                title: _hints[activeIndex].title,
                                description: _hints[activeIndex].description,
                                doNextStep: () => doNextStep(vm),
                              ),
                            ))
                        : SizedBox.shrink()
                  ],
                ),
              ),
            ));
  }

  bool isToday(_ViewModel vm) => isTodayDate(DateTime.parse(vm.model.date).millisecondsSinceEpoch);
}

class _ViewModel {
  final ProgressPageModel model;
  final Function() navigateToMainScreen;
  final Function(bool) updateShowHexagonOnBoardingAction;

  _ViewModel(
      {@required this.model, @required this.navigateToMainScreen, @required this.updateShowHexagonOnBoardingAction});

  static _ViewModel fromStore(Store<AppState> store, int progressIndex) => _ViewModel(
      model: store.state.mainPageState.progressPages[progressIndex],
      navigateToMainScreen: () => store.dispatch(NavigateToMainScreenAction()),
      updateShowHexagonOnBoardingAction: (status) => store.dispatch(UpdateShowHexagonOnBoardingAction(status: status)));
}
