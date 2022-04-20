import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totalfit/model/breathing_model.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/model/wisdom_model.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/preference_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:totalfit/ui/screen/main/progress/item_widgets/breathing_item_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/body_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/shade_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/spirit_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/title_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/hexagon_onboarding_widget.dart';
import 'package:totalfit/ui/screen/main/progress/onboarding/wisdom_onboarging_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class SixthStepOnBoardingWidget extends StatelessWidget {
  final double body;
  final double mind;
  final double spirit;
  final int index;

  const SixthStepOnBoardingWidget({
    @required this.body,
    @required this.mind,
    @required this.spirit,
    @required this.index,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              left: 16.0,
              top: 40.0,
              child: TitleOnBoardingWidget()
            ),
            HexagonOnBoardingWidget(
              body: 0.0,
              mind: 0.0,
              spirit: 0.0,
              initial: false,
            ),
          ]
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                mindHexIc,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 12),
              Text(
                S.of(context).grow_your_mind,
                textAlign: TextAlign.left,
                style: title20.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                  letterSpacing: 0.015,
                ),
              ),
            ],
          ),
        ),
        StoreConnector<AppState, _ViewModel>(
          distinct: true,
          converter: (store) => _ViewModel.fromStore(store, index),
          builder: (context, vm) =>
            BreathingItemWidget(
              item: BreathingListItem(
                breathingModel: BreathingModel(
                  id: "1",
                  video: "https://totalfit-workout-videos.s3.eu-west-1.amazonaws.com/Breathing/TotalfitBreathing.mp4",
                  done: false
                ),
              ),
              onSelected: () {
                vm.updateShowHexagonOnBoardingAction(false);
                vm.navigateToBreathingPage(index, vm.model.breathingModel.video);
              },
            ),
        ),
        Stack(
          children: [
            WisdomOnBoardingWidget(
              item: WisdomListItem(
                wisdomModel: WisdomModel(
                  id: '5891',
                  name: 'No Time for The Gym, No Problem. Just Get Moving',
                  text: '',
                  image: 'https://totalfit-app-images.s3-eu-west-1.amazonaws.com/w005.jpg',
                  estimatedReadingTime: 22,
                  isRead: false
                ),
              ),
            ),
            Positioned.fill(child: ShadeOnBoardingWidget()),
          ],
        ),
        Stack(
          children: [
            BodyOnBoardingWidget(),
            Positioned.fill(child: ShadeOnBoardingWidget()),
          ],
        ),
        Stack(
          children: [
            SpiritOnBoardingWidget(),
            Positioned.fill(child: ShadeOnBoardingWidget()),
          ],
        )
      ],
    );
  }
}

class _ViewModel {
  final Function(int, String) navigateToBreathingPage;
  final Function(bool) updateShowHexagonOnBoardingAction;
  final ProgressPageModel model;

  _ViewModel({
    @required this.model,
    @required this.navigateToBreathingPage,
    @required this.updateShowHexagonOnBoardingAction
  });

  static _ViewModel fromStore(Store<AppState> store, int progressIndex) =>
    _ViewModel(
      model: store.state.mainPageState.progressPages[progressIndex],
      navigateToBreathingPage: (index, video) =>
        store.dispatch(
          NavigateToBreathingPageAction(progressPageIndex: index, video: video)
        ),
      updateShowHexagonOnBoardingAction: (status) =>
        store.dispatch(UpdateShowHexagonOnBoardingAction(status: status))
    );
}