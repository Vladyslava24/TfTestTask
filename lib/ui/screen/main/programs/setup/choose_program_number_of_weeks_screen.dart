import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class ChooseProgramNumberOfWeeksPage extends StatefulWidget {
  @override
  _ChooseProgramNumberOfWeeksState createState() => _ChooseProgramNumberOfWeeksState();
}

class _ChooseProgramNumberOfWeeksState extends State<ChooseProgramNumberOfWeeksPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true, converter: _ViewModel.fromStore, builder: (context, vm) => _buildContent(context, vm));
  }

  Widget _buildContent(BuildContext context, _ViewModel vm) => Container(
        color: AppColorScheme.colorBlack,
        child: SafeArea(
          child: Scaffold(
            appBar: SimpleAppBar(
              leadingType: LeadingType.back,
              leadingAction: () => Navigator.of(context).pop(),
              title: S.of(context).choose_program_number_of_weeks_screen__app_bar_title,
              description: '${S.of(context).step} 2/4',
            ),
            backgroundColor: AppColorScheme.colorBlack,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: WillPopScope(
                onWillPop: () => _onBackPressed(vm),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          HorizontalScrollableSelector(
                            height: MediaQuery.of(context).size.height,
                            itemWidth: MediaQuery.of(context).size.width / 5,
                            initialPosition:
                                vm.weekList.indexOf(vm.selectedCount == 0 ? vm.selectedCount / 2 : vm.selectedCount),
                            itemCount: vm.weekList.length,
                            onPullUpComplete: (selectedIndex) {
                              vm.updateWeeksCount(vm.weekList[selectedIndex]);
                            },
                            itemBuilder: (context, index, isSelected) => Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${vm.weekList[index]}",
                                  textAlign: TextAlign.center,
                                  style: title40.copyWith(
                                    color: isSelected ? AppColorScheme.colorYellow : AppColorScheme.colorPrimaryWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 170),
                            child: _buildSelectedRoundIndicator(),
                          ),
                        ],
                      ),
                    ),
                    ActionButton(
                      padding: const EdgeInsets.all(16),
                      text: S.of(context).all__continue.toUpperCase(),
                      color: AppColorScheme.colorYellow,
                      onPressed: () => vm.continueSetup(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildSelectedRoundIndicator() => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            child: Icon(
              Triangle.triangle,
              size: 40,
              color: AppColorScheme.colorYellow,
            ),
          ),
          Container(height: 8),
          Text(
            S.of(context).choose_program_number_of_weeks_screen__weeks,
            textAlign: TextAlign.center,
            style: title16.copyWith(
              color: AppColorScheme.colorYellow,
            ),
          ),
        ],
      );

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }
}

class _ViewModel {
  Function() continueSetup;
  Function(int) updateWeeksCount;
  int selectedCount;
  List<int> weekList;

  _ViewModel({
    @required this.continueSetup,
    @required this.selectedCount,
    @required this.updateWeeksCount,
    @required this.weekList,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      selectedCount: store.state.programSetupState.selectedNumberOfWeeks,
      updateWeeksCount: (count) => store.dispatch(UpdateWeeksCountCountAction(weeks: count)),
      weekList: List.generate(store.state.programSetupState.maxWeekNumber, (index) => index + 1),
      continueSetup: () =>
          store.dispatch(NavigateToChooseDaysOfTheWeekPageAction(store.state.programSetupState.selectedNumberOfWeeks)),
    );
  }
}
