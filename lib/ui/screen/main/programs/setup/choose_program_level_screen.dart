import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class ChooseProgramLevelPage extends StatefulWidget {
  const ChooseProgramLevelPage({Key key}) : super(key: key);

  @override
  _ChooseProgramLevelPageState createState() => _ChooseProgramLevelPageState();
}

class _ChooseProgramLevelPageState extends State<ChooseProgramLevelPage> {
  LevelType _selectedLevel;

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
        builder: (context, vm) => _buildContent(context, vm, screenWidth));
  }

  Widget _buildContent(BuildContext context, _ViewModel vm, double screenWidth) =>
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          top: false,
          child: WillPopScope(
            onWillPop: () => _onBackPressed(vm),
            child: _buildItemList(vm),
          ),
        ),
      );

  Widget _buildItemList(_ViewModel vm) => Scaffold(
        appBar: SimpleAppBar(
          leadingType: LeadingType.back,
          leadingAction: () => Navigator.of(context).pop(),
          title: S.of(context).choose_program_level__app_bar_title,
          description: '${S.of(context).step} 1/4',
        ),
        backgroundColor: AppColorScheme.colorBlack,
        body: Column(
          children: <Widget>[
            const SizedBox(height: 8.0),
            AnimatedItemPicker(
              itemCount: vm.levels.length,
              axis: Axis.vertical,
              onItemPicked: (index, selected) {
                setState(() {
                  _selectedLevel = vm.levels[index];
                });
                vm.onLevelClick(_selectedLevel);
              },
              itemBuilder: (index, animValue) {
                return Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration:
                        BoxDecoration(color: AppColorScheme.colorBlack2, borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 6, bottom: 6),
                    child: Row(
                      children: [
                        SizedBox(width: 6),
                        Container(
                          width: 26,
                          height: 26,
                          child: const Icon(Icons.done, size: 23, color: AppColorScheme.colorBlack2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _itemBackgroundColorTween.transform(animValue),
                              border: Border.all(color: Colors.yellow)),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  vm.levels[index].uiName.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: title20.copyWith(
                                    color: _itemTextColorTween.transform(animValue),
                                  ),
                                ),
                              ),
                              Container(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  vm.levels[index].getDescription(context),
                                  textAlign: TextAlign.left,
                                  style: textRegular16.copyWith(
                                    color: AppColorScheme.colorBlack7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActionButton(
                isEnable: _selectedLevel != null,
                text: S.of(context).all__continue.toUpperCase(),
                color: AppColorScheme.colorYellow,
                textColor: AppColorScheme.colorPrimaryBlack,
                padding: const EdgeInsets.all(16),
                onPressed: () {
                  vm.continueSetup(_selectedLevel);
                },
              ),
            ),
          ],
        ),
      );

  Future<bool> _onBackPressed(_ViewModel vm) {
    return Future.sync(() => true);
  }
}

class _ViewModel {
  final List<LevelType> levels;
  final Function(LevelType) onLevelClick;
  final Function(LevelType) continueSetup;

  _ViewModel({
    this.levels,
    this.onLevelClick,
    this.continueSetup,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      levels: store.state.programSetupState.program.levels,
      onLevelClick: (selectedLevel) => store.dispatch(SetProgramLevelAction(selectedLevel: selectedLevel)),
      continueSetup: (selectedLevel) => store.dispatch(NavigateToChooseProgramNumberOfWeeksPageAction(selectedLevel)),
    );
  }

  @override
  bool operator ==(Object other) {
    return true;
  }

  @override
  int get hashCode => 777;
}
