import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/program_days_of_week.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';
import 'summary/program_setup_summary_screen.dart';


class ChooseProgramDaysPage extends StatefulWidget {
  const ChooseProgramDaysPage({Key key}) : super(key: key);

  @override
  _ChooseProgramDaysPageState createState() => _ChooseProgramDaysPageState();
}

class _ChooseProgramDaysPageState extends State<ChooseProgramDaysPage> {
  static const double _ITEM_HEIGHT = 48.0;
  static const double _ITEM_MARGIN = 4.0;

  ColorTween _itemBackgroundColorTween = ColorTween(
    begin: AppColorScheme.colorBlack2,
    end: AppColorScheme.colorYellow,
  );
  ColorTween _itemTextColorTween = ColorTween(
    begin: AppColorScheme.colorPrimaryWhite,
    end: AppColorScheme.colorYellow,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          store.dispatch(LoadInitDaysPageStateAction());
        },
        builder: (context, vm) => _buildContent(context, vm, screenWidth));
  }

  Widget _buildContent(BuildContext context, _ViewModel vm, double screenWidth) => Scaffold(
        appBar: SimpleAppBar(
          leadingType: LeadingType.back,
          leadingAction: () => Navigator.of(context).pop(),
          title: S.of(context).choose_program_days__app_bar_title,
          description: '${S.of(context).step} 3/4',
        ),
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () => _onBackPressed(vm),
              child: _buildItemList(vm),
            ),
          ),
        ),
      );

  Widget _buildItemList(_ViewModel vm) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedItemPicker(
              itemCount: vm.days.length,
              axis: Axis.vertical,
              multipleSelection: true,
              initialSelection: Set.of(vm.selectedDays.map((day) => day.index())),
              maxItemSelectionCount: 6,
              onItemPicked: (index, selected) {
                vm.onDayClick(vm.days[index]);
              },
              itemBuilder: (index, animValue) {
                return Container(
                  height: _ITEM_HEIGHT,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColorScheme.colorBlack2,
                    shape: BoxShape.rectangle,
                  ),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(top: _ITEM_MARGIN, bottom: _ITEM_MARGIN),
                  child: Row(
                    children: [
                      SizedBox(width: 6),
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                            color: _itemBackgroundColorTween.transform(animValue), shape: BoxShape.circle),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: DEFAULT_ITEM_PICKER_ANIMATION_DURATION ~/ 2),
                          reverseDuration: Duration(milliseconds: DEFAULT_ITEM_PICKER_ANIMATION_DURATION ~/ 2),
                          child: Container(
                            width: 26,
                            height: 26,
                            child: const Icon(Icons.done, size: 23, color: AppColorScheme.colorBlack2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _itemBackgroundColorTween.transform(animValue),
                                border: Border.all(color: Colors.yellow)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          vm.days[index].stringValue(context),
                          textAlign: TextAlign.center,
                          style: title16.copyWith(color: _itemTextColorTween.transform(animValue)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActionButton(
              isEnable: vm.selectedDays.length > 0,
              text: S.of(context).all__continue.toUpperCase(),
              color: AppColorScheme.colorYellow,
              textColor: AppColorScheme.colorPrimaryBlack,
              padding: const EdgeInsets.all(16),
              onPressed: () {
                vm.continueSetup();
              },
            ),
          ),
        ],
      );

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }
}

class _ViewModel {
  final Function(DayOfWeek) onDayClick;
  final Function() continueSetup;
  final List<DayOfWeek> days;
  final List<DayOfWeek> selectedDays;

  _ViewModel({
    this.onDayClick,
    this.continueSetup,
    this.days,
    this.selectedDays,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      days: store.state.programSetupState.days,
      selectedDays: store.state.programSetupState.selectedDays,
      onDayClick: (day) => store.dispatch(OnProgramDayClickAction(day: day)),
      continueSetup: () {
        final type = store.state.programSetupState.selectedProgramLevel;
        final selectedDays = store.state.programSetupState.selectedDays;
        final selectedNumberOfWeeks = store.state.programSetupState.selectedNumberOfWeeks;
        final targetId = store.state.programSetupState.program.id;

        store.dispatch(
          NavigateToProgramSetupSummaryPageAction(
            ProgramSummaryMode.Start,
            level: type,
            selectedDays: selectedDays.map((d) => DayOfWeek.LIST.indexOf(d)).toList(),
            numberOfWeeks: selectedNumberOfWeeks,
            targetId: targetId,
          ),
        );
      },
    );
  }
}
